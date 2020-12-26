(comp::compile-file-if-src-newer "qp-bspline-optimization.l")
(setq *motion-choice* "backhand-volley-step")
(load "qp-bspline-optimization.so")
(qp-motion-optimize  :x-max 2.0 :x-hit 1.0 :maxvel-weight 1e-2 :minjerk-weight 3e0 :x-step 0.02 :id-max 14 :recursive-order 5 :use-margin 30 :use-all-joint t :use-append-root-joint t)
(setq *x-max-of-p-orig* 2.0)
(setq *p-orig* (concatenate float-vector *ret* (float-vector 0.4 0.8 1.0)))
(with-open-file (f "/userdir/logs/p-orig.l" :direction :output :if-exists :new-version) (format f "~a" *p-orig*))
(format t "(boundp '*p-orig*) => ~A~%" (boundp '*p-orig*))
(comp::compile-file-if-src-newer "nlopt_bspline_optimization.l")
(load "nlopt_bspline_optimization.so")
(nlopt-init :x-max 2.0 :x-hit 1.0 :id-max 14 :recursive-order 5 :use-all-joint t :use-append-root-joint t :support-polygon-margin (list 50.1 50.1 0 100 50) :epsilon-c 30 :mu 0.3 :use-final-pose nil :default-switching-list nil :use-6dof-p t)
(nlopt-motion-optimize :x-max 2.0 :x-hit 1.0 :id-max 14 :recursive-order 5 :max-eval 10000000000 :alg CCSA :delta (deg2rad 0.01) :eqthre 1e-8 :xtol 1e-10 :ftol 1e-15 :use-all-joint t :use-margin 0.5 :use-append-root-joint t :maxvel-weight 1 :minjerk-weight 5e-4 :modify-ec t :p *p* :interval-num 20 :title "maximize-speed" :max-time (* 14 24 60 60) :file-path "/userdir/logs/motion-planning")