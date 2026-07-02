(in-package #:spec-sheet)

(defun configure-spec-sheet (&key (path "/spec-sheet"))
  "Register spec-sheet routes with cl-s3r.
Registers two routes:
  PATH/          - main spec-sheet UI (spec-page component with spec-sheet-layout)
  PATH/preview/  - isolated component preview (spec-preview component, no layout)

Also configures public/ in the spec-sheet system directory as the static asset
directory, serving highlight.min.js and lisp.js from public/script/.

Call this after defining your specs and before starting the server.

Example:
  (configure-spec-sheet :path \"/spec-sheet\")"
  (setf *spec-sheet-path* path)
  (configure-static-dir
   (asdf:system-relative-pathname :spec-sheet "public/"))
  (configure-route :path path
                   :component "spec-page"
                   :props '()
                   :layout 'spec-sheet::spec-sheet-layout)
  (configure-route :path (format nil "~A/preview" path)
                   :component "spec-preview"
                   :props '()
                   :layout nil))

(defun add-head-element (node)
  "Append NODE to the list of extra <head> elements rendered by spec-sheet-layout.
NODE must be a valid cl-s3r S-expression.

Example:
  (add-head-element
    '(:link (@ (rel \"icon\") (type \"image/svg+xml\") (href \"/favicon.svg\"))))"
  (setf *extra-head-nodes*
        (append *extra-head-nodes* (list node))))

(defun load-spec-file (path)
  "Load a spec definition file at PATH.
The file should contain defspec/defsheet forms.

Example:
  (load-spec-file \"/path/to/accordion.sheet.lisp\")"
  (load path))

(defun load-spec-directory (dir)
  "Load all .lisp files in DIR (non-recursively) in alphabetical order.
Useful for loading an entire directory of spec definition files.

Example:
  (load-spec-directory \"/path/to/specs/\")"
  (let* ((dirpath (uiop:ensure-directory-pathname dir))
         (files   (sort (uiop:directory-files dirpath "*.lisp")
                        #'string<
                        :key #'namestring)))
    (dolist (file files)
      (load file))))
