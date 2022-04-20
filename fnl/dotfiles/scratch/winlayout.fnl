
;; single window
[:leaf 2001]

;; two windows, vsplit
[:row
 [[:leaf 2001]
  [:leaf 2006]]]

;; two windows, hsplit
[:col
 [[:leaf 2001]
  [:leaf 2017]]]

;; 3 windows. 1 on top, two split vertically below
[:col
 [[:leaf 2001]
  [:row
   [[:leaf 2017]
    [:leaf 2019]]]]]

;; 4 windows, grid. not sure if this matters but the i split horizontal,
;; vertical on bottom row, then vertical on top row.
[:col
 [[:row
   [[:leaf 2001]
    [:leaf 2021]]]
  [:row
   [[:leaf 2017]
    [:leaf 2019]]]]]

;; 4 windows, same arrangement. vertically split first. turns out the
;; order things are split in does matter. that's kinda annoying
[:row
 [[:col
   [[:leaf 2001]
    [:leaf 2025]]]
  [:col
   [[:leaf 2023]
    [:leaf 2024]]]]]

;; this is a shorter syntax created by me
[:col
 [:row
  [:leaf 2001]
  [:leaf 2021]]
 [:row
  [:leaf 2017]
  [:leaf 2019]]]

