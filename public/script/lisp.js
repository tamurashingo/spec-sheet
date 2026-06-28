/*!
 * Common Lisp grammar for Highlight.js — context-aware version.
 *
 * Context rules:
 *   (...)          code context  — identifiers classified as keyword/built_in
 *   '(...)         data context  — identifiers classified as symbol
 *   #'(...)        code context  — function quote pointing to a lambda form
 *   'atom          data context  — quoted atom = symbol
 */
(function () {
  'use strict';

  function commonLisp(hljs) {
    const IDENT_RE = '[a-zA-Z*+\\-!?<>=\\/][a-zA-Z0-9*+\\-!?<>=\\/]*';
    const NUMBER_RE =
      '(-|\\+)?\\d+(\\.\\d+|\\/\\d+)?((d|e|f|l|s|D|E|F|L|S)(\\+|-)?\\d+)?';

    const SPECIAL_FORMS = [
      'block', 'catch', 'eval-when', 'flet', 'function', 'go', 'if',
      'labels', 'lambda', 'let', 'let*', 'load-time-value', 'locally',
      'macrolet', 'multiple-value-call', 'multiple-value-prog1', 'progn',
      'progv', 'quote', 'return-from', 'setq', 'symbol-macrolet',
      'tagbody', 'the', 'throw', 'unwind-protect'
    ];

    const MACROS = [
      'and', 'assert', 'case', 'ccase', 'check-type', 'cond', 'ctypecase',
      'decf', 'declaim', 'defclass', 'defconstant', 'defgeneric',
      'define-compiler-macro', 'define-condition', 'define-method-combination',
      'define-modify-macro', 'define-setf-expander', 'define-symbol-macro',
      'defmacro', 'defmethod', 'defpackage', 'defparameter', 'defsetf',
      'defstruct', 'deftype', 'defun', 'defvar',
      'destructuring-bind', 'do', 'do*', 'do-all-symbols',
      'do-external-symbols', 'do-symbols', 'dolist', 'dotimes',
      'ecase', 'etypecase',
      'handler-bind', 'handler-case', 'ignore-errors', 'in-package', 'incf',
      'loop',
      'multiple-value-bind', 'multiple-value-list', 'multiple-value-setq',
      'or', 'pop', 'print-unreadable-object',
      'prog', 'prog*', 'prog1', 'prog2',
      'pushnew', 'push', 'remf',
      'restart-bind', 'restart-case', 'rotatef',
      'setf', 'shiftf', 'step', 'time', 'trace', 'typecase',
      'unless', 'untrace', 'when',
      'with-accessors', 'with-compilation-unit', 'with-condition-restarts',
      'with-hash-table-iterator', 'with-input-from-string', 'with-open-file',
      'with-open-stream', 'with-output-to-string', 'with-package-iterator',
      'with-slots', 'with-standard-io-syntax',
      // spec-sheet DSL
      'defspec', 'defsheet',
      'let-component-state', 'let-function',
      'define-component', 'define-layout'
    ];

    const BUILTINS = [
      'abort', 'abs', 'acons', 'acos', 'acosh', 'adjoin', 'adjust-array',
      'adjustable-array-p', 'alpha-char-p', 'alphanumericp',
      'append', 'apply', 'aref', 'arrayp',
      'assoc', 'assoc-if', 'assoc-if-not', 'atom',
      'bit', 'boundp', 'butlast',
      'call-next-method',
      'car', 'cdr',
      'caar', 'cadr', 'cdar', 'cddr',
      'caaar', 'caadr', 'cadar', 'caddr',
      'cdaar', 'cdadr', 'cddar', 'cdddr',
      'char', 'char-code', 'char-downcase', 'char-name', 'char-upcase',
      'characterp', 'class-name', 'class-of',
      'close', 'code-char', 'coerce', 'compile',
      'complement', 'concatenate', 'cons', 'consp', 'constantly',
      'copy-alist', 'copy-list', 'copy-seq', 'copy-tree',
      'count', 'count-if', 'count-if-not',
      'delete', 'delete-duplicates', 'delete-if', 'delete-if-not',
      'endp', 'eq', 'eql', 'equal', 'equalp',
      'error', 'eval',
      'fboundp', 'find', 'find-class', 'find-if', 'find-if-not',
      'find-package', 'find-symbol',
      'first', 'second', 'third', 'fourth', 'fifth',
      'floor', 'ceiling', 'truncate', 'round',
      'format', 'fresh-line', 'funcall',
      'gensym', 'gethash', 'hash-table-count', 'hash-table-p',
      'identity', 'intern', 'integerp',
      'last', 'length',
      'list', 'list*', 'listp',
      'make-array', 'make-hash-table', 'make-instance',
      'make-list', 'make-sequence', 'make-string',
      'mapc', 'mapcan', 'mapcar', 'mapcon', 'mapl', 'maplist',
      'max', 'min', 'mod',
      'member', 'member-if', 'member-if-not',
      'nconc', 'not', 'nreverse', 'nth', 'nthcdr', 'null', 'numberp',
      'package-name', 'parse-integer', 'pathname',
      'position', 'position-if', 'position-if-not',
      'prin1', 'princ', 'print', 'probe-file',
      'rassoc', 'read', 'read-char', 'read-from-string', 'read-line',
      'reduce', 'rem', 'remhash',
      'remove', 'remove-duplicates', 'remove-if', 'remove-if-not',
      'rest', 'reverse',
      'set-difference', 'signal', 'slot-value',
      'sort', 'stable-sort',
      'string', 'string-downcase', 'string-upcase',
      'string-trim', 'string-left-trim', 'string-right-trim',
      'string=', 'string/=', 'string<', 'string>', 'string<=', 'string>=',
      'string-equal', 'string-not-equal',
      'string-lessp', 'string-greaterp', 'string-not-lessp', 'string-not-greaterp',
      'char=', 'char/=', 'char<', 'char>', 'char<=', 'char>=',
      'char-equal', 'char-not-equal',
      'stringp', 'subseq', 'subsetp',
      'symbol-name', 'symbol-package', 'symbol-value', 'symbolp',
      'type-of', 'typep',
      'union', 'values', 'warn', 'write', 'write-char', 'write-string',
      'zerop'
    ];

    const KW_OBJECT = {
      $pattern: IDENT_RE,
      keyword:  [...SPECIAL_FORMS, ...MACROS].join(' '),
      built_in: BUILTINS.join(' '),
      literal:  't nil'
    };

    // Atoms that appear in any context
    const ATOMS = [
      hljs.COMMENT(';', '$', { relevance: 0 }),
      hljs.COMMENT('#\\|', '\\|#', { relevance: 0 }),
      hljs.inherit(hljs.QUOTE_STRING_MODE, { illegal: null }),
      {
        className: 'number',
        variants: [
          { begin: NUMBER_RE,                       relevance: 0 },
          { begin: '#[bB][01]+(/[01]+)?'                         },
          { begin: '#[oO][0-7]+(/[0-7]+)?'                       },
          { begin: '#[xX][0-9a-fA-F]+(/[0-9a-fA-F]+)?'          }
        ]
      },
      // :keyword-symbols (:render :key :description etc.) → title class
      { className: 'title', begin: ':[a-zA-Z][a-zA-Z0-9*+\\-!?<>=\\/]*' },
      // &key / &rest / &optional / &allow-other-keys → keyword class
      { className: 'keyword', begin: '&[a-zA-Z][a-zA-Z0-9*+\\-!?<>=\\/]*' },
      // ,@ (unquote-splicing) → built_in class
      { className: 'built_in', begin: ',@' },
      // Character literals: #\a  #\space  #\newline
      { className: 'string', begin: '#\\\\[\\S]+', relevance: 10 }
    ];

    // ----------------------------------------------------------------
    // Data context: 'atom → symbol class
    // ----------------------------------------------------------------
    const DATA_SYMBOL = { className: 'symbol', begin: IDENT_RE, relevance: 0 };

    // ----------------------------------------------------------------
    // Code context: (...) — all identifiers matched against KW_OBJECT
    // 'self' enables arbitrary nesting
    // ----------------------------------------------------------------
    const CODE_LIST = {
      begin: '\\(',
      end: '\\)',
      beginScope: 'punctuation',
      endScope: 'punctuation',
      keywords: KW_OBJECT,
      contains: ['self', ...ATOMS],
      relevance: 0
    };

    // ----------------------------------------------------------------
    // Data context: '(...) and `(...) — identifiers are symbols, not keywords
    // 'self' handles nested lists like '((a b) (c d))
    // ----------------------------------------------------------------
    const QUOTED_LIST = {
      begin: "['\`]\\(",
      end: '\\)',
      beginScope: 'punctuation',
      endScope: 'punctuation',
      contains: ['self', ...ATOMS, DATA_SYMBOL],
      relevance: 0
    };

    // ----------------------------------------------------------------
    // Data context: 'atom and `atom (single quoted/quasiquoted symbol)
    // ----------------------------------------------------------------
    const QUOTED_ATOM = {
      begin: "['\`]" + IDENT_RE,
      className: 'symbol',
      relevance: 0
    };

    // ----------------------------------------------------------------
    // #'(lambda ...) — function quote pointing to a lambda form.
    // This MUST be tried before QUOTED_LIST so that #'( is captured
    // here (code context) rather than having '( swallowed as data.
    // Contains CODE_LIST for the body so nesting works correctly.
    // ----------------------------------------------------------------
    const FUNC_QUOTE_LIST = {
      begin: "#'\\(",
      end: '\\)',
      beginScope: 'punctuation',
      endScope: 'punctuation',
      keywords: KW_OBJECT,
      contains: [CODE_LIST, ...ATOMS],
      relevance: 0
    };

    return {
      name: 'Common Lisp',
      aliases: ['cl'],
      case_insensitive: true,
      keywords: KW_OBJECT,       // fallback for top-level bare identifiers
      contains: [
        ...ATOMS,
        FUNC_QUOTE_LIST,           // #'(lambda ...)  ← before QUOTED_LIST
        QUOTED_LIST,               // '(data list)
        QUOTED_ATOM,               // 'symbol
        CODE_LIST                  // (fn args ...)
      ]
    };
  }

  hljs.registerLanguage('commonlisp', commonLisp);
})();
