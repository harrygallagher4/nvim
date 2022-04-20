(require-macros :core.macros)
(local queries (require :nvim-treesitter.query))
(local ts-utils (require :nvim-treesitter.ts_utils))
(local {: sriapi} (require :core.iterators))
(local api vim.api)

(var queries-name :locals)

(local contains? vim.tbl_contains)
(local get-node-text ts-utils.get_node_text)
(local get-root ts-utils.get_root_for_node)
(local get-named-children ts-utils.get_named_children)

(fn get-text [node bufnr]
  (. (get-node-text node bufnr) 1))

(fn collect-locals [bufnr]
  (queries.collect_group_results bufnr queries-name))

(fn iter-locals [bufnr root]
  (queries.iter_group_results bufnr queries-name root))

(fn get-locals [bufnr]
  (queries.get_matches bufnr queries-name))

(fn get-definition-id [scope text]
  (table.concat [:k (or text "") (scope:range)] "_"))

(fn get-definitions [bufnr]
  (icollect [_ loc (ipairs (get-locals bufnr))]
    (?. loc :definition)))

(fn get-scopes [bufnr]
  (icollect [_ loc (ipairs (get-locals bufnr))]
    (?. loc :scope :node)))

(fn get-references [bufnr]
  (icollect [_ loc (ipairs (get-locals bufnr))]
    (?. loc :reference :node)))

(fn containing-scope [node bufnr allow-scope]
  (let [bufnr (or bufnr (api.nvim_get_current_buf))
        scope? (not (= false allow-scope))
        scopes (get-scopes bufnr)]
    (when (and node scopes)
      (var $node node)
      (while (nor (= nil $node) (contains? scopes $node))
        (set $node ($node:parent)))
      (or $node (or (and scope? node) nil)))))

(fn iter-scope-tree [node bufnr]
  (var $node node)
  #(when $node
     (let [scope (or (containing-scope $node bufnr false)
                     (get-root node))]
       (set $node (scope:parent))
       scope)))

(fn get-scope-tree [node bufnr]
  (icollect [scope (iter-scope-tree node bufnr)] scope))

(fn recurse-local-nodes [local-def acc full-match last-match]
  (when (= :table (type local-def))
    (if local-def.node
        (acc local-def local-def.node full-match last-match)
        (each [$match $def (pairs local-def)]
          (recurse-local-nodes
            $def acc (or (and full-match
                              (.. full-match "." $match)
                              $match)
                         $match))))))

(fn get-local-nodes [local-def]
  (let [result []
        insert
        (fn [defin _ kind]
          (table.insert result (vim.tbl_extend :keep {: kind} defin)))]
    (recurse-local-nodes local-def insert)
    result))

(fn get-definition-scopes [node bufnr scope-type]
  (let [scopes []
        scope-count (if (= scope-type :parent) 2
                        (= scope-type :global) nil 1)]
    (icollect [scope (iter-scope-tree node bufnr) :into scopes
               :until (and scope-count (>= (length scopes) scope-count))]
      scope)))

(fn get-definition-table* [bufnr]
  (local result {})
  (ieach^ [$def (get-definitions bufnr)
           $node (get-local-nodes $def)]
    (let [{: node : scope} $node
          defscope (get-definition-scopes node bufnr scope)
          deftext (get-text node bufnr)]
      (tset result
            (get-definition-id (dotlast defscope) deftext)
            $node)))
  result)

(local get-definition-table
       (ts-utils.memoize_by_buf_tick get-definition-table*))

(fn find-definition [node bufnr]
  (let [defs (get-definition-table bufnr)
        text (get-text node bufnr)]
    (var (scope entry) (values nil nil))
    (each [$scope (iter-scope-tree node bufnr) :until (not= nil entry)]
      (set (scope entry)
           (values $scope
                   (. defs (get-definition-id $scope text)))))
    (if (not= nil entry)
        (values entry.node scope entry.kind)
        (values node (get-root node) nil))))

(fn find-usages [node scope-node bufnr]
  (let [bufnr (or bufnr (api.nvim_get_current_buf))
        text (get-text node bufnr)
        scope (when (and text (< 1 (length text)))
                (or scope-node (get-root node)))]
    (if (= nil scope) []
        (icollect [$local (iter-locals bufnr scope)]
          (let [$ref (?. $local :reference :node)]
            (when (and $ref (= text (get-text $ref bufnr)))
              (let [($def _ $kind) (find-definition $ref bufnr)]
                (when (or (= nil $kind) (= node $def))
                  $ref))))))))

(fn nested-scope [node cursor-pos]
  (let [bufnr (api.nvim_get_current_buf)
        scopes (get-scopes bufnr)
        scope (containing-scope node)
        {: row : col} cursor-pos]
    (when (and node scopes)
      (seek [_ $child (ipairs (get-named-children scope))]
        (let [($row $col) ($child:start)]
          (and (contains? scopes $child)
               (or (and (= row (+ $row 1))
                        (< col $col))
                   (< row (+ $row 1)))))))))

(fn next-scope [node]
  (let [bufnr (api.nvim_get_current_buf)
        scopes (get-scopes bufnr)
        scope (if node (containing-scope node))
        parent (if scope (scope:parent))]
    (when (and node scopes parent)
      (var not-prev false)
      (seek [_ $child (ipairs (get-named-children parent))]
        (do (set not-prev (or not-prev (= scope $child)))
            (and not-prev (contains? scopes $child)))))))

(fn previous-scope [node]
  (let [bufnr (api.nvim_get_current_buf)
        scopes (get-scopes bufnr)
        scope (if node (containing-scope node))
        parent (if scope (scope:parent))
        children (if parent (get-named-children parent))]
    (when (and node scopes parent)
      (var not-prev false)
      (seek [_ $child (sriapi children)]
        (do (set not-prev (or not-prev (= scope $child)))
            (and not-prev (contains? scopes $child)))))))

