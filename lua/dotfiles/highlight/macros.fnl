{
 :hl   (fn [group ...] `(-> ,group (hlclear!) (highlight  ,...)))
 :hl!  (fn [group ...] `(-> ,group (hlclear!) (highlight! ,...)))
 :hln  (fn [group ...] `(-> ,group (hlclear!) (highlight-link  ,...)))
 :hln! (fn [group ...] `(-> ,group (hlclear!) (highlight-link! ,...)))
 :color-transform (fn [color ...] `(tostring (-> (lushcolor ,color) ,...)))
 :color->         (fn [color ...] `(tostring (-> (lushcolor ,color) ,...)))}
