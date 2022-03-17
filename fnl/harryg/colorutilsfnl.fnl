(local lush (require :lush))
(local hsluv (require :hsluv))



(local concat vim.list_extend)
(local map vim.tbl_map)

(local deg math.deg)
(local rad math.rad)

(local hex->hsluv hsluv.hex_to_hsluv)
(local hsluv->hex hsluv.hsluv_to_hex)
(fn lush->hsluv [c]
  (hex->hsluv c.hex))
(fn hsluv->lush [c]
  (lush.hsl (hsluv->hex c)))

(fn transform-h [c f]
  [(f (. c 1)) (. c 2)     (. c 3)])
(fn transform-s [c f]
  [(. c 1)     (f (. c 2)) (. c 3)])
(fn transform-l [c f]
  [(. c 1)     (. c 2)     (f (. c 3))])

(fn linear-tween [start stop]
  (fn [i] (+ start (* i (- stop start)))))

(fn radial-tween [x y]
  (let [start (rad x)
        stop (rad y)
        delta (math.atan2 (math.sin (- stop start)) (math.cos (- stop start)))]
    (fn [i] (% (+ 360 (deg (+ start (* delta i)))) 360))))


(fn blend-hsluv [start stop ratio]
  (let [ratio (or ratio 0.5)
        h (radial-tween (. start 1) (. stop 1))
        s (linear-tween (. start 2) (. stop 2))
        l (linear-tween (. start 3) (. stop 3))]
    [(h ratio) (s ratio) (l ratio)]))

(fn blend-old [start stop ratio]
  (let [c1 (hsluv.hex_to_hsluv start.hex)
        c2 (hsluv.hex_to_hsluv stop.hex)]
    (lush.hsl (hsluv.hsluv_to_hex (blend-hsluv c1 c2 ratio)))))

(fn blend-lush [c1 c2 r]
  (-> (blend-hsluv (hsluv.hex_to_hsluv c1.hex) (hsluv.hex_to_hsluv c2.hex) r)
      (hsluv.hsluv_to_hex)
      (lush.hsl)))

(fn blend-hex [c1 c2 r]
  (-> (blend-hsluv (hsluv.hex_to_hsluv c1) (hsluv.hex_to_hsluv c2) r)
      (hsluv.hsluv_to_hex)))


(fn lighten [c n]
  (let [l (linear-tween (. c 3) 100)]
    [(. c 1) (. c 2) (l n)]))
(fn darken [c n]
  (let [l (linear-tween (. c 3) 0)]
    [(. c 1) (. c 2) (l n)]))
(fn saturate [c n]
  (let [s (linear-tween (. c 2) 100)]
    [(. c 1) (s n) (. c 3)]))
(fn desaturate [c n]
  (let [s (linear-tween (. c 2) 0)]
    [(. c 1) (s n) (. c 3)]))
(fn rotate [c n]
  [(% (+ n (. c 1)) 360) (. c 2) (. c 3)])

(fn lush_lighten [c n]
  (hsluv->lush (lighten (lush->hsluv c) n)))
(fn lush_darken [c n]
  (hsluv->lush (darken (lush->hsluv c) n)))
(fn lush_saturate [c n]
  (hsluv->lush (saturate (lush->hsluv c) n)))
(fn lush_desaturate [c n]
  (hsluv->lush (desaturate (lush->hsluv c) n)))
(fn lush_rotate [c n]
  (hsluv->lush (rotate (lush->hsluv c) n)))

;; in progress functions

(fn gradient [c1 c2]
  (var ls [])
  (for [i 0.00 1.01 0.02]
    (set ls (concat ls [i])))
  (map #(blend-hex c1 c2 $1) ls))

(fn gradient-n [c1 c2 n]
  (var ls [])
  (let [step (/ 1 (+ n 1))]
    (for [i 1 n 1]
      (set ls (concat ls [(* i step)]))))
  (concat [c1] (map #(blend-hex c1 c2 $1) ls) [c2]))

(fn palette [c]
  (. (. (require :melange.colors) :Melange :lush c) :hex))
(fn palette-lush [c]
  (. (require :melange.colors) :Melange :lush c))



{: blend-hex
 : blend-hsluv
 : blend-lush
 :blend blend-lush
 : lush_darken
 : lush_desaturate
 : lush_lighten
 : lush_rotate
 : lush_saturate}

