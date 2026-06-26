(in-package #:spec-sheet)

;; -------------------------------------------------------
;; Data structures
;; -------------------------------------------------------

(defstruct spec-entry
  name          ; symbol  e.g. 'accordion
  description   ; string
  component     ; function object
  render-fn     ; lambda (&key ...) => S-expression
  props         ; list of (prop-name :type T :default V :description S)
  sheets)       ; ordered list of sheet-entry

(defstruct sheet-entry
  spec-name     ; symbol
  sheet-name    ; symbol
  title         ; string
  render-fn     ; lambda (&key ...) => S-expression, or nil to use spec's render-fn
  params)       ; plist e.g. '(:default "sbcl")

(defvar *spec-registry* nil
  "Ordered list of spec-entry structs. Entries appear in defspec declaration order.")

;; -------------------------------------------------------
;; Registry mutation
;; -------------------------------------------------------

(defun find-spec (name)
  "Return spec-entry whose name matches NAME (string, case-insensitive), or nil."
  (when (and name (not (string= name "")))
    (find (string-downcase name) *spec-registry*
          :key (lambda (s) (string-downcase (string (spec-entry-name s))))
          :test #'string=)))

(defun find-sheet (spec sheet-name)
  "Return the sheet-entry named SHEET-NAME in SPEC, or nil."
  (when (and spec sheet-name
             (not (string= sheet-name ""))
             (not (string= sheet-name "__playground__")))
    (find (string-downcase sheet-name) (spec-entry-sheets spec)
          :key (lambda (s) (string-downcase (string (sheet-entry-sheet-name s))))
          :test #'string=)))

(defun %register-spec (name description component render props)
  (let ((existing (find (string-downcase (string name)) *spec-registry*
                        :key (lambda (s) (string-downcase (string (spec-entry-name s))))
                        :test #'string=)))
    (if existing
        ;; Update in place, preserving list position; reset sheets
        (setf (spec-entry-description existing) description
              (spec-entry-component   existing) component
              (spec-entry-render-fn   existing) render
              (spec-entry-props       existing) props
              (spec-entry-sheets      existing) nil)
        (setf *spec-registry*
              (append *spec-registry*
                      (list (make-spec-entry :name name
                                             :description description
                                             :component component
                                             :render-fn render
                                             :props props
                                             :sheets nil)))))))

(defun %register-sheet (spec-name sheet-name title render params)
  (let ((spec (find (string-downcase (string spec-name)) *spec-registry*
                    :key (lambda (s) (string-downcase (string (spec-entry-name s))))
                    :test #'string=)))
    (unless spec
      (error "defsheet: spec ~S not registered (call defspec first)" spec-name))
    (let ((existing (find (string-downcase (string sheet-name))
                          (spec-entry-sheets spec)
                          :key (lambda (s) (string-downcase (string (sheet-entry-sheet-name s))))
                          :test #'string=)))
      (if existing
          ;; Update in place, preserving order
          (setf (sheet-entry-title     existing) title
                (sheet-entry-render-fn existing) render
                (sheet-entry-params    existing) params)
          (setf (spec-entry-sheets spec)
                (append (spec-entry-sheets spec)
                        (list (make-sheet-entry :spec-name  spec-name
                                                :sheet-name sheet-name
                                                :title      title
                                                :render-fn  render
                                                :params     params))))))))

;; -------------------------------------------------------
;; Public macros
;; -------------------------------------------------------

(defmacro defspec (name &key description component render props)
  "Register a component specification.

Example:
  (defspec accordion
    :description \"Accordion component\"
    :component #'my-package:accordion
    :render #'(lambda (&key default mode duration)
                `(accordion (@ (default ,default) ...) ...))
    :props '((default :type string :default \"\" :description \"Initially open items\")
             (mode :type (member \"single\" \"multiple\") :default \"single\" ...)))"
  `(%register-spec ',name ,description ,component ,render ,props))

(defmacro defsheet (spec-name sheet-name &key title render params)
  "Register a parameter variation (sheet) for a spec.
If :render is omitted, the spec's own render function is used.

Example:
  (defsheet accordion init
    :title \"Initially open\"
    :params '(:default \"sbcl\"))

  (defsheet accordion custom
    :title \"Custom render\"
    :render #'(lambda (&key default &allow-other-keys)
                `(accordion (@ (default ,default)) ...))
    :params '(:default \"sbcl\"))"
  `(%register-sheet ',spec-name ',sheet-name ,title ,render ,params))
