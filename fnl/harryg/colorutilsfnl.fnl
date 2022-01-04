(module harryg.colorutilsfnl
  {require {a aniseed.core
            str aniseed.string
            nvim aniseed.nvim
            lush lush
            hsluv hsluv
            u harryg.colorutils
            icons nvim-web-devicons}
   require-macros [dotfiles.macros]})

; (let [icons ((. (require :nvim-web-devicons) :get_icons))]
;   (table.concat
;     (a.map-indexed
;       (fn [[k v]]
;         (string.format
;           "    %s:\n      foreground: '%s'"
;           k (string.sub (. v :color) 2)))
;      icons)
;     "\n"))
; (.. (icons.get_icon "dart") " ")
(dbg!
  (let [icons ((. (require :nvim-web-devicons) :get_icons))
        cmap {}]
    (a.map-indexed
      (fn [[k v]]
        (tset cmap
              (string.lower (string.gsub k "^%." ""))
              (string.sub (. v :color) 2)))
      icons)
    cmap))

(dbg!
  (a.map tostring (a.get-in (require :melange.colors) [:Melange :lush :g]))
  (a.map-indexed
    (fn [[k v]]
      (if (a.nil? (. v :hex)) (a.map tostring v)
          (tostring v)))
    (a.get-in (require :melange.colors) [:Melange :lush])))

(def- deg math.deg)
(def- rad math.rad)

(def- hex->hsluv hsluv.hex_to_hsluv)
(def- hsluv->hex hsluv.hsluv_to_hex)
(defn- lush->hsluv [c]
  (hex->hsluv c.hex))
(defn- hsluv->lush [c]
  (lush.hsl (hsluv->hex c)))

(defn- transform-h [c f]
  [(f (. c 1)) (. c 2)     (. c 3)])
(defn- transform-s [c f]
  [(. c 1)     (f (. c 2)) (. c 3)])
(defn- transform-l [c f]
  [(. c 1)     (. c 2)     (f (. c 3))])

(defn- linear-tween [start stop]
  (fn [i] (+ start (* i (- stop start)))))

(defn- radial-tween [x y]
  (let [start (rad x)
        stop (rad y)
        delta (math.atan2 (math.sin (- stop start)) (math.cos (- stop start)))]
    (fn [i] (% (+ 360 (deg (+ start (* delta i)))) 360))))

; ((radial-tween 90 270) 0.5) ;; => 180
; ((linear-tween 20 80) 0.5) ;; => 50

(defn blend-hsluv [start stop ratio]
  (let [ratio (or ratio 0.5)
        h (radial-tween (. start 1) (. stop 1))
        s (linear-tween (. start 2) (. stop 2))
        l (linear-tween (. start 3) (. stop 3))]
    [(h ratio) (s ratio) (l ratio)]))

(defn- blend-old [start stop ratio]
  (let [c1 (hsluv.hex_to_hsluv start.hex)
        c2 (hsluv.hex_to_hsluv stop.hex)]
    (lush.hsl (hsluv.hsluv_to_hex (blend-hsluv c1 c2 ratio)))))

(defn blend-lush [c1 c2 r]
  (-> (blend-hsluv (hsluv.hex_to_hsluv c1.hex) (hsluv.hex_to_hsluv c2.hex) r)
      (hsluv.hsluv_to_hex)
      (lush.hsl)))

(defn blend-hex [c1 c2 r]
  (-> (blend-hsluv (hsluv.hex_to_hsluv c1) (hsluv.hex_to_hsluv c2) r)
      (hsluv.hsluv_to_hex)))

(def blend blend-lush)

(defn- lighten [c n]
  (let [l (linear-tween (. c 3) 100)]
    [(. c 1) (. c 2) (l n)]))
(defn- darken [c n]
  (let [l (linear-tween (. c 3) 0)]
    [(. c 1) (. c 2) (l n)]))
(defn- saturate [c n]
  (let [s (linear-tween (. c 2) 100)]
    [(. c 1) (s n) (. c 3)]))
(defn- desaturate [c n]
  (let [s (linear-tween (. c 2) 0)]
    [(. c 1) (s n) (. c 3)]))
(defn- rotate [c n]
  [(% (+ n (. c 1)) 360) (. c 2) (. c 3)])

(defn lush_lighten [c n]
  (hsluv->lush (lighten (lush->hsluv c) n)))
(defn lush_darken [c n]
  (hsluv->lush (darken (lush->hsluv c) n)))
(defn lush_saturate [c n]
  (hsluv->lush (saturate (lush->hsluv c) n)))
(defn lush_desaturate [c n]
  (hsluv->lush (desaturate (lush->hsluv c) n)))
(defn lush_rotate [c n]
  (hsluv->lush (rotate (lush->hsluv c) n)))

;; in progress functions

(defn- gradient [c1 c2]
  (var ls [])
  (for [i 0.00 1.01 0.02]
    (set ls (a.concat ls [i])))
  (map #(blend-hex c1 c2 $1) ls))

(defn- gradient-n [c1 c2 n]
  (var ls [])
  (let [step (/ 1 (+ n 1))]
    (for [i 1 n 1]
      (set ls (a.concat ls [(* i step)]))))
  (a.concat [c1] (a.map #(blend-hex c1 c2 $1) ls) [c2]))


; sample_cyan_xxxxxxxx xxx guifg=#85ADAD guibg=#85ADAD
; sample_teal_xxxxxxxx xxx guifg=#4DB380 guibg=#4DB380
; (gradient-n "#4DB380" "#85ADAD" 37)
(defn- palette [c]
  (. (. (require :melange.colors) :Melange :lush c) :hex))
(defn- palette-lush [c]
  (. (require :melange.colors) :Melange :lush c))

(dbg!
  (tostring (hsluv->lush (darken (lush->hsluv (palette-lush :blue)) 0.4)))
  (tostring (-> (palette-lush :yellow)
                (lush->hsluv)
                (rotate 120)
                (saturate 0.075)
                (darken 0.25)
                (hsluv->lush)))
  (tostring (lush_lighten (palette-lush :blue) 0.1))
  (tostring (lush_darken (palette-lush :blue) 0.4))
  (tostring (lush_saturate (palette-lush :red) 0.25))
  (tostring (lush_desaturate (palette-lush :red) 0.25))
  (tostring (lush_rotate (palette-lush :red) 180))
  (.. (palette :red) " "
      (hsluv->hex (rotate (hex->hsluv (palette :red)) 180)))
  (.. (hsluv->hex (rotate (hex->hsluv (palette :red)) 240)) " "
      (palette :red) " "
      (hsluv->hex (rotate (hex->hsluv (palette :red)) 120)))
  (.. (hsluv->hex (rotate (hex->hsluv (palette :red)) 216)) " "
      (hsluv->hex (rotate (hex->hsluv (palette :red)) 288)) " "
      (palette :red) " "
      (hsluv->hex (rotate (hex->hsluv (palette :red)) 72)) " "
      (hsluv->hex (rotate (hex->hsluv (palette :red)) 144)))
  (.. (palette :red) " "
      (hsluv->hex (rotate (hex->hsluv (palette :red)) 90)) " "
      (hsluv->hex (rotate (hex->hsluv (palette :red)) 180)) " "
      (hsluv->hex (rotate (hex->hsluv (palette :red)) 270)))
  (hsluv->hex (rotate (hex->hsluv (palette :red)) 180))
  (hsluv->hex (lighten (hex->hsluv (palette :red)) 0.25))
  (hsluv->hex (darken (hex->hsluv (palette :red)) 0.25))
  (hsluv->hex (saturate (hex->hsluv (palette :red)) 0.25))
  (hsluv->hex (desaturate (hex->hsluv (palette :red)) 0.25)))

(dbg!
  (transform-h (hex->hsluv (palette :red)) #(* $ 2))
  (transform-s (hex->hsluv (palette :red)) #(* $ 1.1))
  (transform-l (hex->hsluv (palette :red)) #(* $ 1.1))
  (palette :red)
  (gradient-n (palette :green) "#2a2621" 36)
  (gradient "#d65c71" "#2a2621")
  ; (tostring ((. (lush.hsluv (palette :red)) :mix) (lush.hsluv (palette :green)) 50))
  (tostring (blend (lush.hsl (palette :red)) (lush.hsl (palette :green)) 0.5))
  (. (blend (lush.hsl "#ff7e7e") (lush.hsl "#4a4a4a")) :hex)
  (. (u.blend (lush.hsl "#ff7e7e") (lush.hsl "#4a4a4a")) :hex)
  (blend-hex "#ff7e7e" "#4a4a4a")
  (u.blend_hex "#ff7e7e" "#4a4a4a")
  (hsluv.hsluv_to_hex (blend-hsluv (hsluv.hex_to_hsluv "#ff7e7e") (hsluv.hex_to_hsluv "#4a4a4a")))
  (hsluv.hsluv_to_hex (u.blend_hsluv (hsluv.hex_to_hsluv "#ff7e7e") (hsluv.hex_to_hsluv "#4a4a4a"))))

