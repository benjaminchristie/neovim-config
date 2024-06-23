;; extends
; (list
;    (list_item
;    (list_marker_minus) @conceal (#set! conceal "")
;     (task_list_marker_checked)
;  )) 

;  (list
;   (list_item
;     (list_marker_minus) @conceal (#set! conceal "")
;     (task_list_marker_unchecked)
;  )) 


; (atx_heading [
;    (atx_h1_marker)
;    (atx_h2_marker)
;    (atx_h3_marker)
;    (atx_h4_marker)
;    (atx_h5_marker)
; ] @heading_conceal (#set! conceal "#"))

(atx_heading [
   (atx_h1_marker)
   (atx_h2_marker)
   (atx_h3_marker)
   (atx_h4_marker)
   (atx_h5_marker)
] @heading_conceal (#set! conceal "|"))

; (list
;   (list_item
;     (list_marker_minus) @marker_conceal (#set! conceal "•")
; ))
([
 (task_list_marker_checked)
] @conceal (#set! conceal "✔"))

([
  (task_list_marker_unchecked)
] @conceal (#set! conceal "☐"))

(fenced_code_block)
