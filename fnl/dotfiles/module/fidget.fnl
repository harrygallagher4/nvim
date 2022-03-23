(module dotfiles.module.fidget
  {require
   {spinners fidget.spinners}
   autoload {: fidget}})

(def- custom
  {:meter
   ["▰▱▱▱▱▱▱"
    "▰▰▱▱▱▱▱"
    "▰▰▰▱▱▱▱"
    "▰▰▰▰▱▱▱"
    "▰▰▰▰▰▱▱"
    "▰▰▰▰▰▰▱"
    "▰▰▰▰▰▰▰"
    "▱▰▰▰▰▰▰"
    "▱▱▰▰▰▰▰"
    "▱▱▱▰▰▰▰"
    "▱▱▱▱▰▰▰"
    "▱▱▱▱▱▰▰"
    "▱▱▱▱▱▱▰"
    "▱▱▱▱▱▱▱"]})

(each [k v (pairs custom)]
  (tset spinners k v))

(defn setup []
  (fidget.setup
    {:text {:spinner "meter"}
     :timer {:spinner_rate 67}}))

