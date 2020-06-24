;; make capsule for collision
(require "package://tennis/euslisp/robot-interface.l")

(defclass capsule
  :super cascaded-link
  :slots ())

(defmethod capsule
  (:init (&key (radius 50) (height 200) (color #f(0.0 0.6 0.9)) (segments 60) (gdome 2))
   (send-super :init)
   (let ((bds (send self :make-capsule :radius radius :height height :color color :segments segments :gdome gdome)))
     (setq l0 (instance bodyset-link :init (make-cascoords)
                        :bodies bds)))
   (setq links (list l0))
   (send self :assoc (elt links 0))
   (send self :init-ending)
   (send self :name "capsule"))

  (:make-capsule (&key (radius 50) (height 200) (color #f(0.0 0.6 0.9)) (segments 60) (gdome 2))
    (let* (cylinder sphere-top sphere-bottom)
      (setq cylinder (make-cylinder radius height :segments segments))
      (setq sphere-top (make-sphere radius))
      (dotimes (i gdome)
        (setq sphere-top (make-gdome sphere-top)))

      (send sphere-top :locate (float-vector 0 0 height) :world)
      (setq sphere-bottom (make-sphere radius))
      (dotimes (i gdome)
        (setq sphere-bottom (make-gdome sphere-bottom)))

      (send cylinder :set-color color)
      (send sphere-top :set-color color)
      (send sphere-bottom :set-color color)
      (send cylinder :assoc sphere-top)
      (send cylinder :assoc sphere-bottom)
      (list cylinder sphere-top sphere-bottom))))


;; capsules are set for collision check (for jaxon)
(let ((segments 48) (gdome 2))
  (when (not (boundp '*body-capsule*)) ;; ルートリンク
    (let ((radius 220)
          (height 30))
      (setq *body-capsule* (instance capsule :init :radius radius :height height :segments segments :gdome gdome))
      (send *body-capsule* :move-to (send (send *robot* :body_lk) :copy-worldcoords) :world)
      (send *body-capsule* :rotate (deg2rad 90) :x)
      (send *body-capsule* :translate (float-vector -110 -55 -15))
      (send *body-capsule* :put :radius radius)
      (send *body-capsule* :put :height height)
      (send *body-capsule* :put :name "body")
      (send (send *robot* :body_lk) :assoc *body-capsule*)
      )
    )
  (when (not (boundp '*rleg-femur-capsule*)) ;; 右大腿部
    (let ((radius 115)
          (height 335))
      (setq *rleg-femur-capsule* (instance capsule :init :radius radius :height height :segments segments :gdome gdome))
      (send *rleg-femur-capsule* :move-to (send (send *robot* :rleg_link2_lk) :copy-worldcoords) :world)
      (send *rleg-femur-capsule* :translate (float-vector 5 -20 -360))
      (send *rleg-femur-capsule* :put :radius radius)
      (send *rleg-femur-capsule* :put :height height)
      (send *rleg-femur-capsule* :put :name "rleg-femur")
      (send (send *robot* :rleg_link2_lk) :assoc *rleg-femur-capsule*)
      )
    )
  (when (not (boundp '*rleg-knee-capsule*)) ;; 右膝部
    (let ((radius 105)
          (height 140))
      (setq *rleg-knee-capsule* (instance capsule :init :radius radius :height height :segments segments :gdome gdome))
      (send *rleg-knee-capsule* :move-to (send (send *robot* :rleg_link2_lk) :copy-worldcoords) :world)
      (send *rleg-knee-capsule* :translate (float-vector 5 -20 -360))
      (send *rleg-knee-capsule* :put :radius radius)
      (send *rleg-knee-capsule* :put :height height)
      (send *rleg-knee-capsule* :put :name "rleg-knee")
      (send (send *robot* :rleg_link2_lk) :assoc *rleg-knee-capsule*)
      )
    )
  (when (not (boundp '*rleg-cruris-capsule*)) ;; 右下腿部
    (let ((radius 95)
          (height 330))
      (setq *rleg-cruris-capsule* (instance capsule :init :radius radius :height height :segments segments :gdome gdome))
      (send *rleg-cruris-capsule* :move-to (send (send *robot* :rleg_link3_lk) :copy-worldcoords) :world)
      (send *rleg-cruris-capsule* :translate (float-vector 8 0 -405))
      (send *rleg-cruris-capsule* :rotate (deg2rad 6) :y)
      (send *rleg-cruris-capsule* :put :radius radius)
      (send *rleg-cruris-capsule* :put :height height)
      (send *rleg-cruris-capsule* :put :name "rleg-cruris")
      (send (send *robot* :rleg_link3_lk) :assoc *rleg-cruris-capsule*)
      )
    )
  (when (not (boundp '*rleg-foot-capsule*)) ;; 右足部
    (let ((radius 80)
          (height 85))
      (setq *rleg-foot-capsule* (instance capsule :init :radius radius :height height :segments segments :gdome gdome))
      (send *rleg-foot-capsule* :move-to (send (send *robot* :rleg_link5_lk) :copy-worldcoords) :world)
      (send *rleg-foot-capsule* :rotate (deg2rad 90) :y)
      (send *rleg-foot-capsule* :translate (float-vector 60 0 -40))
      (send *rleg-foot-capsule* :put :radius radius)
      (send *rleg-foot-capsule* :put :height height)
      (send *rleg-foot-capsule* :put :name "rleg-foot")
      (send (send *robot* :rleg_link5_lk) :assoc *rleg-foot-capsule*)
      )
    )
  (when (not (boundp '*lleg-femur-capsule*)) ;; 左大腿部
    (let ((radius 115)
          (height 335))
      (setq *lleg-femur-capsule* (instance capsule :init :radius radius :height height :segments segments :gdome gdome))
      (send *lleg-femur-capsule* :move-to (send (send *robot* :lleg_link2_lk) :copy-worldcoords) :world)
      (send *lleg-femur-capsule* :translate (float-vector 5 20 -360))
      (send *lleg-femur-capsule* :put :radius radius)
      (send *lleg-femur-capsule* :put :height height)
      (send *lleg-femur-capsule* :put :name "lleg-femur")
      (send (send *robot* :lleg_link2_lk) :assoc *lleg-femur-capsule*)
      )
    )
  (when (not (boundp '*lleg-knee-capsule*)) ;; 左膝部
    (let ((radius 105)
          (height 140))
      (setq *lleg-knee-capsule* (instance capsule :init :radius radius :height height :segments segments :gdome gdome))
      (send *lleg-knee-capsule* :move-to (send (send *robot* :lleg_link2_lk) :copy-worldcoords) :world)
      (send *lleg-knee-capsule* :translate (float-vector 5 20 -360))
      (send *lleg-knee-capsule* :put :radius radius)
      (send *lleg-knee-capsule* :put :height height)
      (send *lleg-knee-capsule* :put :name "lleg-knee")
      (send (send *robot* :lleg_link2_lk) :assoc *lleg-knee-capsule*)
      )
    )
  (when (not (boundp '*lleg-cruris-capsule*)) ;; 左下腿部
    (let ((radius 95)
          (height 330))
      (setq *lleg-cruris-capsule* (instance capsule :init :radius radius :height height :segments segments :gdome gdome))
      (send *lleg-cruris-capsule* :move-to (send (send *robot* :lleg_link3_lk) :copy-worldcoords) :world)
      (send *lleg-cruris-capsule* :translate (float-vector 8 0 -405))
      (send *lleg-cruris-capsule* :rotate (deg2rad 6) :y)
      (send *lleg-cruris-capsule* :put :radius radius)
      (send *lleg-cruris-capsule* :put :height height)
      (send *lleg-cruris-capsule* :put :name "lleg-cruris")
      (send (send *robot* :lleg_link3_lk) :assoc *lleg-cruris-capsule*)
      )
    )
  (when (not (boundp '*lleg-foot-capsule*)) ;; 左足部
    (let ((radius 80)
          (height 85))
      (setq *lleg-foot-capsule* (instance capsule :init :radius radius :height height :segments segments :gdome gdome))
      (send *lleg-foot-capsule* :move-to (send (send *robot* :lleg_link5_lk) :copy-worldcoords) :world)
      (send *lleg-foot-capsule* :rotate (deg2rad 90) :y)
      (send *lleg-foot-capsule* :translate (float-vector 60 0 -40))
      (send *lleg-foot-capsule* :put :radius radius)
      (send *lleg-foot-capsule* :put :height height)
      (send *lleg-foot-capsule* :put :name "lleg-foot")
      (send (send *robot* :lleg_link5_lk) :assoc *lleg-foot-capsule*)
      )
    )
  (when (not (boundp '*torso-abdomen-capsule*)) ;; 体幹腹部
    (let ((radius 240)
          (height 18))
      (setq *torso-abdomen-capsule* (instance capsule :init :radius radius :height height :segments segments :gdome gdome))
      (send *torso-abdomen-capsule* :move-to (send (send *robot* :chest_link1_lk) :copy-worldcoords) :world)
      (send *torso-abdomen-capsule* :translate (float-vector -103 0 20))
      (send *torso-abdomen-capsule* :put :radius radius)
      (send *torso-abdomen-capsule* :put :height height)
      (send *torso-abdomen-capsule* :put :name "torso-abdomen")
      (send (send *robot* :chest_link1_lk) :assoc *torso-abdomen-capsule*)
      )
    )
  (when (not (boundp '*torso-chest-capsule*)) ;; 体幹胸部
    (let ((radius 285)
          (height 85))
      (setq *torso-chest-capsule* (instance capsule :init :radius radius :height height :segments segments :gdome gdome))
      (send *torso-chest-capsule* :move-to (send (send *robot* :chest_link2_lk) :copy-worldcoords) :world)
      (send *torso-chest-capsule* :translate (float-vector -100 0 -145))
      (send *torso-chest-capsule* :put :radius radius)
      (send *torso-chest-capsule* :put :height height)
      (send *torso-chest-capsule* :put :name "torso-chest")
      (send (send *robot* :chest_link2_lk) :assoc *torso-chest-capsule*)
      )
    )
  (when (not (boundp '*head-capsule*)) ;; 頭部
    (let ((radius 135)
          (height 90))
      (setq *head-capsule* (instance capsule :init :radius radius :height height :segments segments :gdome gdome))
      (send *head-capsule* :move-to (send (send *robot* :head_link1_lk) :copy-worldcoords) :world)
      (send *head-capsule* :translate (float-vector 0 0 20))
      (send *head-capsule* :put :radius radius)
      (send *head-capsule* :put :height height)
      (send *head-capsule* :put :name "head")
      (send (send *robot* :head_link1_lk) :assoc *head-capsule*)
      )
    )
  (when (not (boundp '*rarm-upper-capsule*)) ;; 右上腕部
    (let ((radius 80)
          (height 290))
      (setq *rarm-upper-capsule* (instance capsule :init :radius radius :height height :segments segments :gdome gdome))
      (send *rarm-upper-capsule* :move-to (send (send *robot* :rarm_link2_lk) :copy-worldcoords) :world)
      (send *rarm-upper-capsule* :translate (float-vector 0 0 -310))
      (send *rarm-upper-capsule* :put :radius radius)
      (send *rarm-upper-capsule* :put :height height)
      (send *rarm-upper-capsule* :put :name "rarm-upper")
      (send (send *robot* :rarm_link2_lk) :assoc *rarm-upper-capsule*)
      )
    )
  (when (not (boundp '*rarm-elbow-capsule*)) ;; 右肘部
    (let ((radius 80)
          (height 145))
      (setq *rarm-elbow-capsule* (instance capsule :init :radius radius :height height :segments segments :gdome gdome))
      (send *rarm-elbow-capsule* :move-to (send (send *robot* :rarm_link2_lk) :copy-worldcoords) :world)
      (send *rarm-elbow-capsule* :translate (float-vector 0 0 -310))
      (send *rarm-elbow-capsule* :put :radius radius)
      (send *rarm-elbow-capsule* :put :height height)
      (send *rarm-elbow-capsule* :put :name "rarm-elbow")
      (send (send *robot* :rarm_link2_lk) :assoc *rarm-elbow-capsule*)
      )
    )
  (when (not (boundp '*rarm-forearm-capsule*)) ;; 右前腕部
    (let ((radius 75)
          (height 285))
      (setq *rarm-forearm-capsule* (instance capsule :init :radius radius :height height :segments segments :gdome gdome))
      (send *rarm-forearm-capsule* :move-to (send (send *robot* :rarm_link4_lk) :copy-worldcoords) :world)
      (send *rarm-forearm-capsule* :translate (float-vector 0 0 -280))
      (send *rarm-forearm-capsule* :put :radius radius)
      (send *rarm-forearm-capsule* :put :height height)
      (send *rarm-forearm-capsule* :put :name "rarm-forearm")
      (send (send *robot* :rarm_link4_lk) :assoc *rarm-forearm-capsule*)
      )
    )
  (when (not (boundp '*rarm-hand-capsule*)) ;; 右手部
    (let ((radius 88)
          (height 80))
      (setq *rarm-hand-capsule* (instance capsule :init :radius radius :height height :segments segments :gdome gdome))
      (send *rarm-hand-capsule* :move-to (send (send *robot* :rarm_link7_lk) :copy-worldcoords) :world)
      (send *rarm-hand-capsule* :translate (float-vector 0 -5 -160))
      (send *rarm-hand-capsule* :put :radius radius)
      (send *rarm-hand-capsule* :put :height height)
      (send *rarm-hand-capsule* :put :name "rarm-hand")
      (send (send *robot* :rarm_link7_lk) :assoc *rarm-hand-capsule*)
      )
    )
  (when (not (boundp '*larm-upper-capsule*)) ;; 左上腕部
    (let ((radius 80)
          (height 290))
      (setq *larm-upper-capsule* (instance capsule :init :radius radius :height height :segments segments :gdome gdome))
      (send *larm-upper-capsule* :move-to (send (send *robot* :larm_link2_lk) :copy-worldcoords) :world)
      (send *larm-upper-capsule* :translate (float-vector 0 0 -310))
      (send *larm-upper-capsule* :put :radius radius)
      (send *larm-upper-capsule* :put :height height)
      (send *larm-upper-capsule* :put :name "larm-upper")
      (send (send *robot* :larm_link2_lk) :assoc *larm-upper-capsule*)
      )
    )
  (when (not (boundp '*larm-elbow-capsule*)) ;; 左肘部
    (let ((radius 80)
          (height 145))
      (setq *larm-elbow-capsule* (instance capsule :init :radius radius :height height :segments segments :gdome gdome))
      (send *larm-elbow-capsule* :move-to (send (send *robot* :larm_link2_lk) :copy-worldcoords) :world)
      (send *larm-elbow-capsule* :translate (float-vector 0 0 -310))
      (send *larm-elbow-capsule* :put :radius radius)
      (send *larm-elbow-capsule* :put :height height)
      (send *larm-elbow-capsule* :put :name "larm-elbow")
      (send (send *robot* :larm_link2_lk) :assoc *larm-elbow-capsule*)
      )
    )
  (when (not (boundp '*larm-forearm-capsule*)) ;; 左前腕部
    (let ((radius 75)
          (height 285))
      (setq *larm-forearm-capsule* (instance capsule :init :radius radius :height height :segments segments :gdome gdome))
      (send *larm-forearm-capsule* :move-to (send (send *robot* :larm_link4_lk) :copy-worldcoords) :world)
      (send *larm-forearm-capsule* :translate (float-vector 0 0 -280))
      (send *larm-forearm-capsule* :put :radius radius)
      (send *larm-forearm-capsule* :put :height height)
      (send *larm-forearm-capsule* :put :name "larm-forearm")
      (send (send *robot* :larm_link4_lk) :assoc *larm-forearm-capsule*)
      )
    )
  (when (not (boundp '*larm-hand-capsule*)) ;; 左手部
    (let ((radius 88)
          (height 80))
      (setq *larm-hand-capsule* (instance capsule :init :radius radius :height height :segments segments :gdome gdome))
      (send *larm-hand-capsule* :move-to (send (send *robot* :larm_link7_lk) :copy-worldcoords) :world)
      (send *larm-hand-capsule* :translate (float-vector 0 5 -160))
      (send *larm-hand-capsule* :put :radius radius)
      (send *larm-hand-capsule* :put :height height)
      (send *larm-hand-capsule* :put :name "larm-hand")
      (send (send *robot* :larm_link7_lk) :assoc *larm-hand-capsule*)
      )
    )


  ;; (objects (list *robot* *body-capsule* *rleg-knee-capsule* *rleg-cruris-capsule* *rleg-foot-capsule* *lleg-femur-capsule* *lleg-cruris-capsule* *lleg-foot-capsule* *torso-abdomen-capsule* *torso-chest-capsule* *head-capsule* *rarm-elbow-capsule* *rarm-forearm-capsule* *rarm-hand-capsule* *larm-upper-capsule* *larm-forearm-capsule* *larm-hand-capsule*))
  )


;; ;; convex-hull model
;; ;; When *robot* is *jaxon_red*, convex-hull model is replaced with raw model in some of the links. This is because unknown errows occur when making convex-hull model of those links.
;; (when (not (boundp '*body-link-convex-hull*))
;;   (setq *body-link-convex-hull* (convex-hull-3d (flatten (send-all (send (send *robot* :body_lk) :bodies) :vertices))))
;;   (send (send *robot* :body_lk) :assoc *body-link-convex-hull*)
;;   )
;; (when (not (boundp '*rleg-link2-convex-hull*))
;;   (setq *rleg-link2-convex-hull* (convex-hull-3d (flatten (send-all (send (send *robot* :rleg_link2_lk) :bodies) :vertices))))
;;   (send (send *robot* :rleg_link2_lk) :assoc *rleg-link2-convex-hull*)
;;   )
;; (if (boundp '*jaxon*)
;;     (progn ;; for jaxon
;;       (when (not (boundp '*rleg-link3-convex-hull*))
;;         (setq *rleg-link3-convex-hull* (convex-hull-3d (flatten (send-all (send (send *robot* :rleg_link3_lk) :bodies) :vertices))))
;;         (send (send *robot* :rleg_link3_lk) :assoc *rleg-link3-convex-hull*)
;;         )
;;       (when (not (boundp '*rleg-link5-convex-hull*))
;;         (setq *rleg-link5-convex-hull* (convex-hull-3d (flatten (send-all (send (send *robot* :rleg_link5_lk) :bodies) :vertices))))
;;         (send (send *robot* :rleg_link5_lk) :assoc *rleg-link5-convex-hull*)
;;         )
;;       )
;;   (progn ;; for jaxon_red
;;     (when (not (boundp '*rleg-link3-convex-hull*))
;;       (setq *rleg-link3-convex-hull* (convex-hull-3d (subseq (flatten (send-all (send (send *robot* :rleg_link3_lk) :bodies) :vertices)) 130 728)))
;;       (send (send *robot* :rleg_link3_lk) :assoc *rleg-link3-convex-hull*)
;;       ;; (setq *rleg-link3-convex-hull* (send *robot* :rleg_link3_lk))
;;       )
;;     (when (not (boundp '*rleg-link5-convex-hull*))
;;       (setq *rleg-link5-convex-hull* (convex-hull-3d (reverse (flatten (send-all (send (send *robot* :rleg_link5_lk) :bodies) :vertices)))))
;;       (send (send *robot* :rleg_link5_lk) :assoc *rleg-link5-convex-hull*)
;;       ;; (setq *rleg-link5-convex-hull* (send *robot* :rleg_link5_lk))
;;       )
;;     )
;;   )
;; (when (not (boundp '*lleg-link2-convex-hull*))
;;   (setq *lleg-link2-convex-hull* (convex-hull-3d (flatten (send-all (send (send *robot* :lleg_link2_lk) :bodies) :vertices))))
;;   (send (send *robot* :lleg_link2_lk) :assoc *lleg-link2-convex-hull*)
;;   )
;; (when (not (boundp '*lleg-link3-convex-hull*))
;;   (setq *lleg-link3-convex-hull* (convex-hull-3d (flatten (send-all (send (send *robot* :lleg_link3_lk) :bodies) :vertices))))
;;   (send (send *robot* :lleg_link3_lk) :assoc *lleg-link3-convex-hull*)
;;   )
;; (if (boundp '*jaxon*)
;;     (progn ;; for jaxon
;;       (when (not (boundp '*lleg-link5-convex-hull*))
;;         (setq *lleg-link5-convex-hull* (convex-hull-3d (flatten (send-all (send (send *robot* :lleg_link5_lk) :bodies) :vertices))))
;;         (send (send *robot* :lleg_link5_lk) :assoc *lleg-link5-convex-hull*)
;;         )
;;       (when (not (boundp '*chest-link1-convex-hull*))
;;         (setq *chest-link1-convex-hull* (convex-hull-3d (flatten (send-all (send (send *robot* :chest_link1_lk) :bodies) :vertices))))
;;         (send (send *robot* :chest_link1_lk) :assoc *chest-link1-convex-hull*)
;;         )
;;       (when (not (boundp '*chest-link2-convex-hull*))
;;         (setq *chest-link2-convex-hull* (convex-hull-3d (flatten (send-all (send (send *robot* :chest_link2_lk) :bodies) :vertices))))
;;         (send (send *robot* :chest_link2_lk) :assoc *chest-link2-convex-hull*)
;;         )
;;       )
;;   (progn ;; for jaxon_red
;;     (when (not (boundp '*lleg-link5-convex-hull*))
;;       (setq *lleg-link5-convex-hull* (convex-hull-3d (reverse (flatten (send-all (send (send *robot* :lleg_link5_lk) :bodies) :vertices)))))
;;       (send (send *robot* :lleg_link5_lk) :assoc *lleg-link5-convex-hull*)
;;       ;; (setq *lleg-link5-convex-hull* (send *robot* :lleg_link5_lk))
;;       )
;;     (when (not (boundp '*chest-link1-convex-hull*))
;;       (setq *chest-link1-convex-hull* (convex-hull-3d (subseq (flatten (send-all (send (send *robot* :chest_link1_lk) :bodies) :vertices)) 330 4020)))
;;       (send (send *robot* :chest_link1_lk) :assoc *chest-link1-convex-hull*)
;;       ;; (setq *chest-link1-convex-hull* (send *robot* :chest_link1_lk))
;;       )
;;     (when (not (boundp '*chest-link2-convex-hull*))
;;       ;; (setq *chest-link2-convex-hull* (convex-hull-3d (subseq (flatten (send-all (send (send *robot* :chest_link2_lk) :bodies) :vertices)) 210 12124)))
;;       ;; (send (send *robot* :chest_link2_lk) :assoc *chest-link2-convex-hull*)
;;       (setq *chest-link2-convex-hull* (send *robot* :chest_link2_lk))
;;       )
;;     )
;;   )
;; (when (not (boundp '*head-link1-convex-hull*))
;;   (setq *head-link1-convex-hull* (convex-hull-3d (flatten (send-all (send (send *robot* :head_link1_lk) :bodies) :vertices))))
;;   (send (send *robot* :head_link1_lk) :assoc *head-link1-convex-hull*)
;;   )
;; (when (not (boundp '*rarm-link3-convex-hull*))
;;   (setq *rarm-link3-convex-hull* (convex-hull-3d (flatten (send-all (send (send *robot* :rarm_link3_lk) :bodies) :vertices))))
;;   (send (send *robot* :rarm_link3_lk) :assoc *rarm-link3-convex-hull*)
;;   )
;; (when (not (boundp '*rarm-link4-convex-hull*))
;;   (setq *rarm-link4-convex-hull* (convex-hull-3d (flatten (send-all (send (send *robot* :rarm_link4_lk) :bodies) :vertices))))
;;   (send (send *robot* :rarm_link4_lk) :assoc *rarm-link4-convex-hull*)
;;   )
;; (when (not (boundp '*rarm-link5-convex-hull*))
;;   (setq *rarm-link5-convex-hull* (convex-hull-3d (flatten (send-all (send (send *robot* :rarm_link5_lk) :bodies) :vertices))))
;;   (send (send *robot* :rarm_link5_lk) :assoc *rarm-link5-convex-hull*)
;;   )
;; (when (not (boundp '*rarm-link7-convex-hull*))
;;   (setq *rarm-link7-convex-hull* (convex-hull-3d (flatten (send-all (send (send *robot* :rarm_link7_lk) :bodies) :vertices))))
;;   (send (send *robot* :rarm_link7_lk) :assoc *rarm-link7-convex-hull*)
;;   )
;; (when (not (boundp '*larm-link3-convex-hull*))
;;   (setq *larm-link3-convex-hull* (convex-hull-3d (flatten (send-all (send (send *robot* :larm_link3_lk) :bodies) :vertices))))
;;   (send (send *robot* :larm_link3_lk) :assoc *larm-link3-convex-hull*)
;;   )
;; (if (boundp '*jaxon*)
;;     (when (not (boundp '*larm-link4-convex-hull*)) ;; for jaxon
;;       (setq *larm-link4-convex-hull* (convex-hull-3d (flatten (send-all (send (send *robot* :larm_link4_lk) :bodies) :vertices))))
;;       (send (send *robot* :larm_link4_lk) :assoc *larm-link4-convex-hull*)
;;       )
;;   (when (not (boundp '*larm-link4-convex-hull*)) ;; for jaxon_red
;;     (setq *larm-link4-convex-hull* (send *robot* :larm_link4_lk))
;;     )
;;   )
;; (when (not (boundp '*larm-link5-convex-hull*))
;;   (setq *larm-link5-convex-hull* (convex-hull-3d (flatten (send-all (send (send *robot* :larm_link5_lk) :bodies) :vertices))))
;;   (send (send *robot* :larm_link5_lk) :assoc *larm-link5-convex-hull*)
;;   )
;; (when (not (boundp '*larm-link7-convex-hull*))
;;   (setq *larm-link7-convex-hull* (convex-hull-3d (flatten (send-all (send (send *robot* :larm_link7_lk) :bodies) :vertices))))
;;   (send (send *robot* :larm_link7_lk) :assoc *larm-link7-convex-hull*)
;;   )


(let ((segments 48) (gdome 2))
  (when (not (boundp '*racket-capsule-list*))
    (let ((stick-radius 75) (frame-radius 20) stick (stick-height 560) frame1 (frame1-height 320) frame2 (frame2-height 320) frame3 (frame3-height 240) frame4 (frame4-height 240))
      (setq stick (instance capsule :init :radius stick-radius :height stick-height :segments segments :gdome gdome))
      (send stick :move-to (send *racket-model* :copy-worldcoords) :world)
      (send stick :rotate (deg2rad 90) :x)
      (send stick :translate (float-vector 0 15 -150))
      (send stick :put :radius stick-radius)
      (send stick :put :height stick-height)
      (send stick :put :name "racket-stick")
      (send *racket-model* :assoc stick)
      (setq frame1 (instance capsule :init :radius frame-radius :height frame1-height :segments segments :gdome gdome))
      (send frame1 :move-to (send *racket-model* :copy-worldcoords) :world)
      (send frame1 :rotate (deg2rad 90) :x)
      (send frame1 :translate (float-vector 125 15 -150))
      (send frame1 :put :radius frame-radius)
      (send frame1 :put :height frame1-height)
      (send frame1 :put :name "racket-frame1")
      (send *racket-model* :assoc frame1)
      (setq frame2 (instance capsule :init :radius frame-radius :height frame2-height :segments segments :gdome gdome))
      (send frame2 :move-to (send *racket-model* :copy-worldcoords) :world)
      (send frame2 :rotate (deg2rad 90) :x)
      (send frame2 :translate (float-vector -125 15 -150))
      (send frame2 :put :radius frame-radius)
      (send frame2 :put :height frame2-height)
      (send frame2 :put :name "racket-frame2")
      (send *racket-model* :assoc frame2)
      (setq frame3 (instance capsule :init :radius frame-radius :height frame3-height :segments segments :gdome gdome))
      (send frame3 :move-to (send *racket-model* :copy-worldcoords) :world)
      (send frame3 :rotate (deg2rad 90) :x)
      (send frame3 :rotate (deg2rad 90) :y)
      (send frame3 :translate (float-vector 165 15 -120))
      (send frame3 :put :radius frame-radius)
      (send frame3 :put :height frame3-height)
      (send frame3 :put :name "racket-frame3")
      (send *racket-model* :assoc frame3)
      (setq frame4 (instance capsule :init :radius frame-radius :height frame4-height :segments segments :gdome gdome))
      (send frame4 :move-to (send *racket-model* :copy-worldcoords) :world)
      (send frame4 :rotate (deg2rad 90) :x)
      ;; forehand-step
      (send frame4 :rotate (deg2rad 90) :y)
      (send frame4 :translate (float-vector -165 15 -120))
      (send frame4 :put :radius frame-radius)
      (send frame4 :put :height frame4-height)
      (send frame4 :put :name "racket-frame4")
      (send *racket-model* :assoc frame4)
      (setq *racket-capsule-list* (list stick frame1 frame2 frame3 frame4))))


  (when (not (boundp '*bat-capsule*))
    (let ((radius 30)
          (height 750))
      (setq *bat-capsule* (instance capsule :init :radius radius :height height :segments segments :gdome gdome))
      (send *bat-capsule* :move-to (send *bat-model* :copy-worldcoords) :world)
      (send *bat-capsule* :rotate (deg2rad -90) :x)
      (send *bat-capsule* :translate (float-vector 0 -15 -520))
      (send *bat-capsule* :put :radius radius)
      (send *bat-capsule* :put :height height)
      (send *bat-capsule* :put :name "bat")
      (send *bat-model* :assoc *bat-capsule*))))

;; (objects (list *robot* *body-capsule* *rleg-knee-capsule* *rleg-cruris-capsule* *rleg-foot-capsule* *lleg-femur-capsule* *lleg-cruris-capsule* *lleg-foot-capsule* *torso-abdomen-capsule* *torso-chest-capsule* *head-capsule* *rarm-elbow-capsule* *rarm-forearm-capsule* *rarm-hand-capsule* *larm-upper-capsule* *larm-forearm-capsule* *larm-hand-capsule*))



;; collision model
(setq *body/torso-collision* (list *body-capsule* *torso-abdomen-capsule*)) ;; (list *body-link-convex-hull* *chest-link1-convex-hull*)
(setq *rleg-collision* (list *rleg-femur-capsule* *rleg-cruris-capsule* *rleg-foot-capsule*)) ;; (list *rleg-link2-convex-hull* *rleg-link3-convex-hull* *rleg-link5-convex-hull*)
(setq *rleg-no-groin-collision* (list *rleg-knee-capsule* *rleg-cruris-capsule* *rleg-foot-capsule*)) ;; (list *rleg-link3-convex-hull* *rleg-link5-convex-hull*)
(setq *rleg-no-foot-collision* (list *rleg-femur-capsule* *rleg-cruris-capsule*)) ;; (list *rleg-link2-convex-hull* *rleg-link3-convex-hull*)
(setq *rleg-no-groin-foot-collision* (list *rleg-knee-capsule* *rleg-cruris-capsule*)) ;; (list *rleg-link3-convex-hull*)
(setq *lleg-collision* (list *lleg-femur-capsule* *lleg-cruris-capsule* *lleg-foot-capsule*)) ;; (list *lleg-link2-convex-hull* *lleg-link3-convex-hull* *lleg-link5-convex-hull*)
(setq *lleg-no-groin-collision* (list *lleg-knee-capsule* *lleg-cruris-capsule* *lleg-foot-capsule*)) ;; (list *lleg-link3-convex-hull* *lleg-link5-convex-hull*)
(setq *lleg-no-foot-collision* (list *lleg-femur-capsule* *lleg-cruris-capsule*)) ;; (list *lleg-link2-convex-hull* *lleg-link3-convex-hull*)
(setq *lleg-no-groin-collision* (list *lleg-knee-capsule* *lleg-cruris-capsule* *lleg-foot-capsule*)) ;; (list *lleg-link3-convex-hull* *lleg-link5-convex-hull*)
(setq *lleg-no-groin-foot-collision* (list *lleg-knee-capsule* *lleg-cruris-capsule*)) ;; (list *lleg-link3-convex-hull*)
(setq *chest/head-collision* (list *torso-chest-capsule* *head-capsule*)) ;; (list *chest-link2-convex-hull* *head-link1-convex-hull*)
(setq *rarm-collision* (list *rarm-upper-capsule* *rarm-forearm-capsule* *rarm-hand-capsule*)) ;; (list *rarm-link3-convex-hull* *rarm-link4-convex-hull* *rarm-link5-convex-hull* *rarm-link7-convex-hull*)
(setq *rarm-no-shoulder-collision* (list *rarm-elbow-capsule* *rarm-forearm-capsule* *rarm-hand-capsule*))
(setq *rarm-no-upper-collision* (list *rarm-forearm-capsule* *rarm-hand-capsule*)) ;; (list *rarm-link4-convex-hull* *rarm-link5-convex-hull* *rarm-link7-convex-hull*)
(setq *larm-collision* (list *larm-upper-capsule* *larm-forearm-capsule* *larm-hand-capsule*)) ;; (list *larm-link3-convex-hull* *larm-link4-convex-hull* *larm-link5-convex-hull* *larm-link7-convex-hull*)
(setq *larm-no-shoulder-collision* (list *larm-elbow-capsule* *larm-forearm-capsule* *larm-hand-capsule*))
(setq *larm-no-upper-collision* (list *larm-forearm-capsule* *larm-hand-capsule*)) ;; (list *larm-link4-convex-hull* *larm-link5-convex-hull* *larm-link7-convex-hull*)