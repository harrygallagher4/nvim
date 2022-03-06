(local uv (require :luv))

(fn work-callback [a b]
  (+ a b))

(fn after-work-callback [c]
  (print (string.format "the result is: %s" c)))

(local work (uv.new_work
              work-callback
              after-work-callback))

; can't canel in lua :(
; (uv.cancel work)

(work:queue 1 2)

