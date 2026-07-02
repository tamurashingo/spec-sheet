(in-package #:spec-sheet)

;; -------------------------------------------------------
;; CSS
;; -------------------------------------------------------

(defvar *spec-sheet-css*
  (concatenate 'string
    ".spec-sheet-root *{box-sizing:border-box;margin:0;padding:0;}"
    ".spec-sheet-root{"
    "display:grid;"
    "grid-template-columns:var(--ss-sidebar-width,240px) 4px 1fr;"
    "height:100vh;overflow:hidden;"
    "font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',Roboto,sans-serif;"
    "font-size:14px;color:var(--ss-text,#1a1a1a);}"

    ;; Resize handle
    ".spec-sheet-resize-handle{"
    "width:4px;cursor:col-resize;background:transparent;"
    "transition:background .15s;}"
    ".spec-sheet-resize-handle:hover,"
    ".spec-sheet-resize-handle--active{"
    "background:var(--ss-accent,#3b82f6);}"

    ;; Sidebar
    ".spec-sheet-sidebar{"
    "background:var(--ss-sidebar-bg,#f4f4f5);"
    "border-right:1px solid var(--ss-border,#e4e4e7);"
    "overflow-y:auto;display:flex;flex-direction:column;}"
    ".spec-sheet-sidebar__header{"
    "padding:16px 12px 8px;font-weight:700;font-size:12px;"
    "letter-spacing:.06em;text-transform:uppercase;"
    "color:var(--ss-muted,#71717a);border-bottom:1px solid var(--ss-border,#e4e4e7);"
    "cursor:pointer;}"
    ".spec-sheet-sidebar__spec{padding:2px 0;}"
    ".spec-sheet-sidebar__spec-title{"
    "padding:6px 12px;cursor:pointer;font-weight:600;"
    "border-radius:4px;margin:1px 4px;user-select:none;"
    "color:var(--ss-text,#1a1a1a);}"
    ".spec-sheet-sidebar__spec-title:hover{background:var(--ss-hover,#e4e4e7);}"
    ".spec-sheet-sidebar__spec-title--active{color:var(--ss-accent,#3b82f6);}"
    ".spec-sheet-sidebar__sheets{padding-bottom:4px;}"
    ".spec-sheet-sidebar__sheet{"
    "padding:4px 12px 4px 24px;cursor:pointer;"
    "border-radius:4px;margin:1px 4px;color:var(--ss-sheet-color,#52525b);"
    "user-select:none;}"
    ".spec-sheet-sidebar__sheet:hover{background:var(--ss-hover,#e4e4e7);}"
    ".spec-sheet-sidebar__sheet--active{"
    "background:var(--ss-accent-bg,#eff6ff);"
    "color:var(--ss-accent,#3b82f6);font-weight:600;}"
    ".spec-sheet-sidebar__sheet--playground{font-style:italic;}"

    ;; Main panel
    ".spec-sheet-main{overflow-y:auto;padding:24px 32px;}"
    ".spec-sheet-main--empty{"
    "display:flex;align-items:center;justify-content:center;"
    "color:var(--ss-muted,#a1a1aa);font-size:16px;}"

    ;; Sheet panel
    ".spec-sheet-panel{}"
    ".spec-sheet-panel__header{margin-bottom:20px;}"
    ".spec-sheet-panel__title{font-size:20px;font-weight:700;margin-bottom:4px;}"
    ".spec-sheet-panel__desc{color:var(--ss-muted,#71717a);}"

    ;; Preview box
    ".spec-sheet-panel__preview{"
    "border:1px solid var(--ss-border,#e4e4e7);"
    "border-radius:8px;overflow:hidden;margin-bottom:24px;"
    "background:var(--ss-preview-bg,#fff);}"
    ".spec-sheet-preview-frame{"
    "width:100%;height:400px;border:none;display:block;}"

    ;; Render source
    ".spec-sheet-render-source{margin-top:8px;margin-bottom:24px;}"
    ".spec-sheet-render-source h3{font-size:14px;font-weight:600;margin-bottom:12px;"
    "color:var(--ss-muted,#71717a);text-transform:uppercase;letter-spacing:.05em;}"
    ".spec-sheet-render-source pre{"
    "background:var(--ss-code-bg,#f4f4f5);padding:12px 16px;"
    "border-radius:6px;overflow-x:auto;"
    "font-family:monospace;font-size:12px;line-height:1.6;"
    "white-space:pre;}"

    ;; Params table
    ".spec-sheet-params{margin-top:8px;margin-bottom:24px;}"
    ".spec-sheet-params h3{font-size:14px;font-weight:600;margin-bottom:12px;"
    "color:var(--ss-muted,#71717a);text-transform:uppercase;letter-spacing:.05em;}"
    ".spec-sheet-params-table{width:100%;border-collapse:collapse;font-size:13px;}"
    ".spec-sheet-params-table th{"
    "text-align:left;padding:8px 12px;"
    "border-bottom:2px solid var(--ss-border,#e4e4e7);"
    "color:var(--ss-muted,#71717a);font-weight:600;}"
    ".spec-sheet-params-table td{"
    "padding:8px 12px;border-bottom:1px solid var(--ss-border,#e4e4e7);}"
    ".spec-sheet-params-table code{"
    "background:var(--ss-code-bg,#f4f4f5);padding:1px 5px;"
    "border-radius:3px;font-family:monospace;font-size:12px;}"

    ;; Playground
    ".spec-sheet-playground{"
    "display:grid;grid-template-columns:1fr 300px;gap:24px;height:100%;}"
    ".spec-sheet-playground__preview{}"
    ".spec-sheet-playground__preview h3{"
    "font-size:14px;font-weight:600;margin-bottom:12px;"
    "color:var(--ss-muted,#71717a);text-transform:uppercase;letter-spacing:.05em;}"
    ".spec-sheet-playground__controls{"
    "border-left:1px solid var(--ss-border,#e4e4e7);padding-left:24px;}"
    ".spec-sheet-playground__controls h3{"
    "font-size:14px;font-weight:600;margin-bottom:16px;"
    "color:var(--ss-muted,#71717a);text-transform:uppercase;letter-spacing:.05em;}"

    ;; Form fields
    ".spec-sheet-field{margin-bottom:16px;}"
    ".spec-sheet-field__label{"
    "display:block;font-weight:600;font-size:12px;"
    "color:var(--ss-muted,#71717a);text-transform:uppercase;"
    "letter-spacing:.05em;margin-bottom:4px;}"
    ".spec-sheet-field__desc{"
    "display:block;font-size:11px;color:var(--ss-muted,#a1a1aa);margin-top:3px;}"
    ".spec-sheet-input,.spec-sheet-select{"
    "width:100%;padding:6px 8px;"
    "border:1px solid var(--ss-border,#e4e4e7);"
    "border-radius:4px;font-size:14px;"
    "background:#fff;color:var(--ss-text,#1a1a1a);}"
    ".spec-sheet-input:focus,.spec-sheet-select:focus{"
    "outline:none;border-color:var(--ss-accent,#3b82f6);}"
    ".spec-sheet-apply-btn{"
    "width:100%;padding:8px 16px;"
    "background:var(--ss-accent,#3b82f6);"
    "color:#fff;border:none;border-radius:4px;"
    "cursor:pointer;font-size:14px;font-weight:600;}"
    ".spec-sheet-apply-btn:hover{background:var(--ss-accent-hover,#2563eb);}"

    ;; Preview wrapper (inside iframe)
    ".spec-preview-root{padding:16px;}"
    ".spec-preview-error{padding:16px;color:#dc2626;"
    "background:#fef2f2;border-radius:4px;font-family:monospace;font-size:13px;}"))

;; -------------------------------------------------------
;; URL sync: update browser URL when selected-spec/selected-sheet changes.
;; Uses MutationObserver on data-state — no HTML-special characters (<>&).
;; -------------------------------------------------------

(defvar *url-sync-js*
  (concatenate 'string
    "(function(){"
    "function syncUrl(state){"
    "var s=state['SELECTED-SPEC']||'';"
    "var sh=state['SELECTED-SHEET']||'';"
    "var u=new URL(window.location.href);"
    "if(s){u.searchParams.set('spec',s);}else{u.searchParams.delete('spec');}"
    "if(sh){u.searchParams.set('sheet',sh);}else{u.searchParams.delete('sheet');}"
    "history.replaceState(null,'',u.toString());}"
    "new MutationObserver(function(ms){"
    "ms.forEach(function(m){"
    "if(m.attributeName==='data-state'){"
    "if(m.target.getAttribute('data-component')==='spec-page'){"
    "try{syncUrl(JSON.parse(m.target.getAttribute('data-state')||'{}'));}catch(e){}"
    "}}});}).observe(document.body,{subtree:true,attributes:true,attributeFilter:['data-state']});"
    "})();"))

;; -------------------------------------------------------
;; Highlight.js initialization (inline — no HTML-special characters)
;; -------------------------------------------------------

(defvar *hljs-init-js*
  (concatenate 'string
    "(function(){"
    "function h(){"
    "document.querySelectorAll('pre code.language-commonlisp:not(.hljs)').forEach("
    "function(e){hljs.highlightElement(e);});"
    "}"
    "if(document.readyState==='loading'){"
    "document.addEventListener('DOMContentLoaded',h);}else{h();}"
    "new MutationObserver(h).observe(document.body,{childList:true,subtree:true});"
    "})();"))

;; -------------------------------------------------------
;; Layout
;; -------------------------------------------------------

(defvar *extra-head-nodes* nil
  "List of additional S-expression nodes to inject into <head>.
Each element should be a valid cl-s3r S-expression, e.g.:
  '(:link (@ (rel \"icon\") (type \"image/svg+xml\") (href \"/favicon.svg\")))")

(define-layout spec-sheet-layout (&key children &allow-other-keys)
  `(:html (@ (lang "en"))
     (:head
       (:meta (@ (charset "UTF-8")))
       (:title "spec-sheet")
       (:link (@ (rel "stylesheet") (href ,(asset-path "/css/github.css"))))
       (:script (@ (src ,(asset-path "/script/highlight.min.js"))))
       (:script (@ (src ,(asset-path "/script/lisp.js"))))
       (:script (@ (src ,(asset-path "/script/resize.js"))))
       ,@*extra-head-nodes*)
     (:body (@ (style "margin:0;padding:0"))
       ,children
       (:script ,*hljs-init-js*)
       (:script ,*url-sync-js*))))

;; -------------------------------------------------------
;; Path prefix (set by configure-spec-sheet)
;; -------------------------------------------------------

(defvar *spec-sheet-path* "/spec-sheet")

;; -------------------------------------------------------
;; Helper functions
;; -------------------------------------------------------

(defun spec-default-params (spec)
  "Return a plist of default values from SPEC's :props definition."
  (loop for prop-def in (spec-entry-props spec)
        for prop-kw = (make-keyword (string-upcase (string (car prop-def))))
        for default = (or (getf (cdr prop-def) :default) "")
        collect prop-kw
        collect default))

(defun filter-params-by-props (params props)
  "Keep only plist keys that appear in PROPS definition."
  (loop for prop-def in props
        for prop-kw = (make-keyword (string-upcase (string (car prop-def))))
        collect prop-kw
        collect (or (getf params prop-kw) (getf (cdr prop-def) :default) "")))

(defun percent-encode (string)
  "Percent-encode a string for safe use as a URL query parameter value."
  (with-output-to-string (out)
    (loop for char across (or string "")
          for code = (char-code char)
          do (if (or (and (>= code 65) (<= code 90))
                     (and (>= code 97) (<= code 122))
                     (and (>= code 48) (<= code 57))
                     (member char '(#\- #\_ #\. #\~)))
                 (write-char char out)
                 (format out "%~2,'0X" code)))))

(defun plist-to-query-string (plist)
  "Convert a plist to a URL query string fragment, e.g. '&default=sbcl&mode=single'."
  (with-output-to-string (out)
    (loop for (k v) on plist by #'cddr
          do (format out "&~(~A~)=~A" k (percent-encode (or v ""))))))

(defun invoke-render-sexp (render-fn params)
  "Call RENDER-FN with PARAMS (a keyword plist). Returns an S-expression."
  (when render-fn
    (handler-case
        (apply render-fn (or params nil))
      (error (e)
        `(:div (@ (class "spec-preview-error"))
           "Render error: " ,(princ-to-string e))))))

(defun render-source-to-string (source)
  "Pretty-print SOURCE as a lowercase string without package qualifiers.
Custom pprint-dispatch entries:
  symbol — prints symbol-name in lowercase, no package qualifier
  lambda — keeps the arglist on the same line as lambda"
  (when source
    (let* ((table (copy-pprint-dispatch))
           (*print-pretty* t)
           (*print-pprint-dispatch* table))
      ;; Symbols: lowercase, no package qualifier.
      (set-pprint-dispatch 'symbol
        (lambda (stream obj)
          (when (keywordp obj) (write-char #\: stream))
          (write-string (string-downcase (symbol-name obj)) stream))
        1 table)
      ;; Lambda: arglist stays on the same line as lambda regardless of length.
      ;; Without this, the default pprint handler breaks the arglist onto a new
      ;; line when it exceeds *print-right-margin*.
      (set-pprint-dispatch '(cons (eql lambda) t)
        (lambda (stream form)
          (pprint-logical-block (stream form :prefix "(" :suffix ")")
            (write-string "lambda" stream)
            (write-char #\space stream)
            ;; Disable right-margin for just the arglist so it never wraps.
            (let ((*print-right-margin* most-positive-fixnum))
              (write (cadr form) :stream stream))
            (pprint-indent :block 2 stream)
            (dolist (body-form (cddr form))
              (pprint-newline :mandatory stream)
              (write body-form :stream stream))))
        1 table)
      (with-output-to-string (out)
        (write source :stream out)))))

(defun render-render-source-block (spec sheet)
  "Return a render-source code block, or nil if no source is available."
  (let* ((source (or (sheet-entry-render-source sheet)
                     (spec-entry-render-source spec)))
         (str    (render-source-to-string source)))
    (when str
      `(:div (@ (class "spec-sheet-render-source"))
         (:h3 "Render")
         (:pre (:code (@ (class "language-commonlisp")) ,str))))))

(defun render-sidebar (selected-spec selected-sheet)
  `(:nav (@ (class "spec-sheet-sidebar"))
     (:div (@ (class "spec-sheet-sidebar__header")
              (onclick (select-spec "")))
       "spec-sheet")
     ,@(mapcar
         (lambda (spec)
           (let* ((spec-name-str (string-downcase (string (spec-entry-name spec))))
                  (is-selected   (string= spec-name-str selected-spec)))
             `(:div (@ (class "spec-sheet-sidebar__spec"))
                (:div (@ (class ,(if is-selected
                                     "spec-sheet-sidebar__spec-title spec-sheet-sidebar__spec-title--active"
                                     "spec-sheet-sidebar__spec-title"))
                         (onclick (select-spec ,spec-name-str)))
                  ,spec-name-str)
                ,@(when is-selected
                    (list
                     `(:div (@ (class "spec-sheet-sidebar__sheets"))
                        ,@(mapcar
                            (lambda (sheet)
                              (let ((sname (string-downcase (string (sheet-entry-sheet-name sheet)))))
                                `(:div (@ (class ,(if (string= sname selected-sheet)
                                                      "spec-sheet-sidebar__sheet spec-sheet-sidebar__sheet--active"
                                                      "spec-sheet-sidebar__sheet"))
                                         (onclick (select-sheet ,sname)))
                                   ,(or (sheet-entry-title sheet) sname))))
                            (spec-entry-sheets spec))
                        (:div (@ (class ,(if (string= "__playground__" selected-sheet)
                                             "spec-sheet-sidebar__sheet spec-sheet-sidebar__sheet--playground spec-sheet-sidebar__sheet--active"
                                             "spec-sheet-sidebar__sheet spec-sheet-sidebar__sheet--playground"))
                                 (onclick (select-sheet "__playground__")))
                          "Playground")))))))
         *spec-registry*)))

(defun build-preview-url (spec-name &key sheet-name params)
  (format nil "~A/preview/?spec-name=~A~A"
          *spec-sheet-path*
          spec-name
          (cond
            (sheet-name (format nil "&sheet-name=~A" sheet-name))
            (params     (plist-to-query-string params))
            (t          ""))))

(defun render-params-table (spec params)
  `(:div (@ (class "spec-sheet-params"))
     (:h3 "Parameters")
     (:table (@ (class "spec-sheet-params-table"))
       (:thead
         (:tr
           (:th "Prop") (:th "Type") (:th "Default") (:th "Value") (:th "Description")))
       (:tbody
         ,@(mapcar
             (lambda (prop-def)
               (let* ((prop-name (car prop-def))
                      (prop-kw   (make-keyword (string-upcase (string prop-name))))
                      (type-spec (getf (cdr prop-def) :type))
                      (default   (or (getf (cdr prop-def) :default) ""))
                      (desc      (or (getf (cdr prop-def) :description) ""))
                      (value     (or (getf params prop-kw) default)))
                 `(:tr
                    (:td (:code ,(string-downcase (string prop-name))))
                    (:td ,(format nil "~A" type-spec))
                    (:td (:code ,default))
                    (:td (:code ,value))
                    (:td ,desc))))
             (spec-entry-props spec))))))

(defun render-prop-input (prop-name type-spec current-value)
  (let ((field-name (string-downcase (string prop-name))))
    (cond
      ((and (symbolp type-spec)
            (string= "BOOLEAN" (string type-spec)))
       `(:select (@ (name ,field-name) (class "spec-sheet-select"))
          ,@(mapcar
              (lambda (option)
                `(:option (@ (value ,option)
                             ,@(when (string= option (or current-value "false"))
                                 '((selected "selected"))))
                   ,option))
              '("true" "false"))))
      ((and (symbolp type-spec)
            (string= "NUMBER" (string type-spec)))
       `(:input (@ (type "number")
                   (name ,field-name)
                   (value ,(or current-value ""))
                   (class "spec-sheet-input"))))
      ((and (listp type-spec)
            (symbolp (car type-spec))
            (string= "MEMBER" (string (car type-spec))))
       `(:select (@ (name ,field-name) (class "spec-sheet-select"))
          ,@(mapcar
              (lambda (option)
                `(:option (@ (value ,option)
                             ,@(when (string= option (or current-value ""))
                                 '((selected "selected"))))
                   ,option))
              (cdr type-spec))))
      (t
       `(:input (@ (type "text")
                   (name ,field-name)
                   (value ,(or current-value ""))
                   (class "spec-sheet-input")))))))

(defun render-playground-form (props params)
  `(:form (@ (class "spec-sheet-playground__form")
             (onsubmit (update-playground-params)))
     ,@(mapcar
         (lambda (prop-def)
           (let* ((prop-name  (car prop-def))
                  (prop-kw    (make-keyword (string-upcase (string prop-name))))
                  (type-spec  (getf (cdr prop-def) :type))
                  (desc       (or (getf (cdr prop-def) :description) ""))
                  (current    (or (getf params prop-kw)
                                  (getf (cdr prop-def) :default) "")))
             `(:div (@ (class "spec-sheet-field"))
                (:label (@ (class "spec-sheet-field__label"))
                  ,(string-downcase (string prop-name)))
                ,(render-prop-input prop-name type-spec current)
                (:small (@ (class "spec-sheet-field__desc")) ,desc))))
         props)
     (:button (@ (class "spec-sheet-apply-btn") (type "submit"))
       "Apply")))

(defun render-sheet-panel (spec sheet)
  (let ((preview-url (build-preview-url
                      (string-downcase (string (spec-entry-name spec)))
                      :sheet-name (string-downcase (string (sheet-entry-sheet-name sheet))))))
    `(:div (@ (class "spec-sheet-panel"))
       (:div (@ (class "spec-sheet-panel__header"))
         (:h2 (@ (class "spec-sheet-panel__title"))
           ,(or (sheet-entry-title sheet) ""))
         (:p (@ (class "spec-sheet-panel__desc"))
           ,(or (spec-entry-description spec) "")))
       (:div (@ (class "spec-sheet-panel__preview"))
         (:iframe (@ (src ,preview-url)
                     (class "spec-sheet-preview-frame"))))
       ,(render-params-table spec (sheet-entry-params sheet))
       ,@(let ((block (render-render-source-block spec sheet)))
           (when block (list block))))))

(defun render-playground-panel (spec playground-params-json)
  (let* ((props  (spec-entry-props spec))
         (params (if (or (string= playground-params-json "")
                         (string= playground-params-json "{}")
                         (string= playground-params-json "null"))
                     (spec-default-params spec)
                     (filter-params-by-props
                      (normalize-state-keys (jonathan:parse playground-params-json))
                      props)))
         (preview-url (build-preview-url
                       (string-downcase (string (spec-entry-name spec)))
                       :params params)))
    `(:div (@ (class "spec-sheet-playground"))
       (:div (@ (class "spec-sheet-playground__preview"))
         (:h3 "Preview")
         (:div (@ (class "spec-sheet-panel__preview"))
           (:iframe (@ (src ,preview-url)
                       (class "spec-sheet-preview-frame")))))
       (:div (@ (class "spec-sheet-playground__controls"))
         (:h3 "Props")
         ,(render-playground-form props params)))))

(defun render-main-panel (selected-spec selected-sheet playground-params-json)
  (cond
    ((string= selected-spec "")
     `(:main (@ (class "spec-sheet-main spec-sheet-main--empty"))
        (:p "Select a spec")))
    ((string= selected-sheet "")
     `(:main (@ (class "spec-sheet-main spec-sheet-main--empty"))
        (:p "Select a sheet")))
    (t
     (let ((spec (find-spec selected-spec)))
       (if (null spec)
           `(:main (@ (class "spec-sheet-main spec-sheet-main--empty"))
              (:p "Spec not found: " ,selected-spec))
           (if (string= selected-sheet "__playground__")
               `(:main (@ (class "spec-sheet-main"))
                  ,(render-playground-panel spec playground-params-json))
               (let ((sheet (find-sheet spec selected-sheet)))
                 (if (null sheet)
                     `(:main (@ (class "spec-sheet-main spec-sheet-main--empty"))
                        (:p "Sheet not found: " ,selected-sheet))
                     `(:main (@ (class "spec-sheet-main"))
                        ,(render-sheet-panel spec sheet))))))))))

;; -------------------------------------------------------
;; spec-preview component
;; Renders just the spec component for embedding in an iframe.
;; Props come from URL query string:
;;   ?spec-name=accordion&sheet-name=default  (sheet view)
;;   ?spec-name=accordion&default=sbcl&...    (playground view, no sheet-name)
;; -------------------------------------------------------

(define-component spec-preview (&rest all-props)
  (let* ((spec-name  (getf all-props :spec-name ""))
         (sheet-name (getf all-props :sheet-name ""))
         (spec       (find-spec spec-name)))
    (if (null spec)
        `(:div (@ (style "padding:16px;color:#999"))
           "No spec: " ,spec-name)
        (let* ((sheet (when (and sheet-name (not (string= sheet-name "")))
                        (find-sheet spec sheet-name)))
               (render-params
                (if sheet
                    ;; Sheet view: use sheet's params
                    (sheet-entry-params sheet)
                    ;; Playground view: use props directly, excluding spec-name
                    (remove-from-plist all-props :spec-name :sheet-name)))
               (render-fn (or (when sheet (sheet-entry-render-fn sheet))
                              (spec-entry-render-fn spec)))
               (component-sexp (invoke-render-sexp render-fn render-params)))
          `(:div (@ (class "spec-preview-root"))
             ,component-sexp)))))

;; -------------------------------------------------------
;; spec-page component
;; Main spec-sheet UI: sidebar + content panel.
;; -------------------------------------------------------

(define-component spec-page (&key (spec "") (sheet "") &allow-other-keys)
  (let-component-state
      ((selected-spec          (string-downcase (or spec "")))
       (selected-sheet         (string-downcase (or sheet "")))
       (playground-params-json
        (if (string= (string-downcase (or sheet "")) "__playground__")
            (let ((init-spec (find-spec (string-downcase (or spec "")))))
              (if init-spec (jonathan:to-json (spec-default-params init-spec)) "{}"))
            "{}")))
    (let-function
        ((select-spec (spec-name)
           (setf selected-spec          (string-downcase spec-name)
                 selected-sheet         ""
                 playground-params-json "{}"))
         (select-sheet (sheet-name)
           (setf selected-sheet (string-downcase sheet-name))
           (when (string= selected-sheet "__playground__")
             (let ((spec (find-spec selected-spec)))
               (when spec
                 (setf playground-params-json
                       (jonathan:to-json (spec-default-params spec)))))))
         (update-playground-params (form-data)
           (let* ((normalized (normalize-state-keys form-data))
                  (spec       (find-spec selected-spec))
                  (props      (when spec (spec-entry-props spec))))
             (when props
               (setf playground-params-json
                     (jonathan:to-json (filter-params-by-props normalized props)))))))
      `(:div (@ (class "spec-sheet-root"))
         (:style ,*spec-sheet-css*)
         ,(render-sidebar selected-spec selected-sheet)
         (:div (@ (class "spec-sheet-resize-handle")))
         ,(render-main-panel selected-spec selected-sheet playground-params-json)))))
