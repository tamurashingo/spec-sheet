(defsystem "spec-sheet"
  :version "0.1.0"
  :author "tamurashingo"
  :license "MIT"
  :depends-on ("cl-s3r")
  :components ((:module "src"
                :components
                ((:file "packages")
                 (:file "registry"    :depends-on ("packages"))
                 (:file "components"  :depends-on ("packages" "registry"))
                 (:file "spec-loader" :depends-on ("packages" "registry" "components")))))
  :description "An interactive UI component catalog and dynamic spec-sheet for cl-s3r")
