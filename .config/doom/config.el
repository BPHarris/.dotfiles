;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;;; General
(setq user-full-name "Brandon Harris"
      user-mail-address "bpharris@pm.me")

(setq doom-font (font-spec :family "FiraCode Nerd Font Mono" :size 16)
      doom-theme 'doom-badger)

(setq display-line-numbers-type 'relative)

(setq org-directory "~/org/")

;; Save with C-s
;; Doom already has vim-style search on /
(map! :nvi "C-s" #'save-buffer)


;;; Titlebar
(setq frame-title-format "Doom Emacs")


;; Hide titlebar when maximised
(defun my-hide-decoration-when-maximized (frame)
  (modify-frame-parameters
   frame
   `((undecorated .
      ,(eq (frame-parameter frame 'fullscreen)
           'maximized)))))

(add-hook 'window-size-change-functions
          #'my-hide-decoration-when-maximized)


;;; In-line git blame
(use-package! blamer
  :demand t

  :custom
  (blamer-idle-time 0.05)
  (blamer-min-offset 50)
  (blamer-prettify-time-p t)
  (blamer-type 'both)
  (blamer-author-formatter " %s • ")
  (blamer-datetime-formatter "%s • ")
  (blamer-commit-formatter "%s")

  :config
  (global-blamer-mode 1))

(map! :leader
      :desc "Toggle inline blame"
      "t b" #'blamer-mode)


;;; Enable breadcrumbs
(use-package! breadcrumb
  :demand t
  :config
  (setq breadcrumb-imenu-crumb-separator " › "
        breadcrumb-imenu-max-length 0.8)

  (defun my/code-breadcrumb ()
    (let* ((path
            (if buffer-file-name
                (if-let ((project (project-current nil)))
                    (file-relative-name
                     buffer-file-name
                     (project-root project))
                  (file-name-nondirectory buffer-file-name))
              (buffer-name)))
           (crumbs (breadcrumb-imenu-crumbs)))
      (concat
       path
       (when (and crumbs (not (string-empty-p crumbs)))
         (concat " : " crumbs)))))

  (defun my/code-breadcrumb-enable ()
    (setq-local
     header-line-format
     '(" "
       (:eval (my/code-breadcrumb))
       "  %l:%c")))

  (add-hook 'prog-mode-hook #'my/code-breadcrumb-enable))


;;; Ghostel
(map! :leader
      :prefix "o"

      :desc "Ghostel project terminal" "g"
      #'ghostel-project

      :desc "Pick project Ghostel" "G"
      #'ghostel-project-list-buffers

      :desc "Next project Ghostel" "]"
      #'ghostel-project-next

      :desc "Previous project Ghostel" "["
      #'ghostel-project-previous)


;;; Ghostel control groups
(defvar ghostel-buffer-name)

(defun my-ghostel-project-root ()
  "Return the current project root, or report that there is no project."
  (or (doom-project-root)
      (user-error "Not in a project")))

(defun my-ghostel-name (n)
  (let ((root (file-truename (my-ghostel-project-root))))
    (format "*ghostel-scratchpad:%s:%s:%d*"
            (file-name-nondirectory (directory-file-name root))
            (substring (secure-hash 'sha256 root) 0 12)
            n)))

(defun my-ghostel-create (n &optional cmd)
  (let ((default-directory (my-ghostel-project-root))
        (ghostel-buffer-name (my-ghostel-name n)))
    (ghostel)

    (when cmd
      (ghostel-send-string cmd)
      (ghostel-send-key "return"))))

(defun my-ghostel-new ()
  (interactive)
  (let ((n 1))
    (while (get-buffer (my-ghostel-name n))
      (setq n (1+ n)))
    (my-ghostel-create n)))

(defun my-ghostel-jump (n)
  (interactive)
  (let ((buf (get-buffer (my-ghostel-name n))))
    (if buf
        (switch-to-buffer buf)
      (user-error "No terminal %d for this project" n))))

(map! :leader
      :prefix "o"
      :desc "New project terminal" "n" #'my-ghostel-new

      "1" (cmd! (my-ghostel-jump 1))
      "2" (cmd! (my-ghostel-jump 2))
      "3" (cmd! (my-ghostel-jump 3))
      "4" (cmd! (my-ghostel-jump 4))
      "5" (cmd! (my-ghostel-jump 5))
      "6" (cmd! (my-ghostel-jump 6))
      "7" (cmd! (my-ghostel-jump 7))
      "8" (cmd! (my-ghostel-jump 8))
      "9" (cmd! (my-ghostel-jump 9)))

;; Ignore ghostel control groups in SPC ,
(after! consult
  (add-to-list 'consult-buffer-filter
               "\\`\\*ghostel-scratchpad:"))

;; Search ghostel scratchpads
(defun my-ghostel-scratchpads ()
  (interactive)
  (let* ((buffers
          (seq-filter
           (lambda (buf)
             (string-prefix-p "*ghostel-scratchpad:"
                              (buffer-name buf)))
           (buffer-list)))
         (names (mapcar #'buffer-name buffers)))
    (if names
        (switch-to-buffer
         (completing-read "Ghostel scratchpad: " names nil t))
      (user-error "No Ghostel scratchpads"))))

(map! :leader
      :prefix "o"
      :desc "Scratchpad terminals" "s"
      #'my-ghostel-scratchpads)

;;; Ghostel control-group defaults
(after! projectile
  (defun my-project-terminals ()
    (let ((defaults
           (cond
            ((file-equal-p (doom-project-root)
                           (expand-file-name "~/services/feature/"))
             '((1 nil)
               (2 "figlet 'hello there'")
               (3 nil)))

            ((file-equal-p (doom-project-root)
                           (expand-file-name "~/services/master/"))
             '((1 nil))))))

      (dolist (term defaults)
        (let* ((n (car term))
               (cmd (cadr term))
               (buf (my-ghostel-name n)))
          (unless (get-buffer buf)
            (my-ghostel-create n cmd))))))

  (add-hook 'projectile-after-switch-project-hook
            #'my-project-terminals))


;; ;;; vterm control groups
;; (defun my-vterm-name (n)
;;   (format "*vterm-scratchpad:%s:%d*"
;;           (file-name-nondirectory
;;            (directory-file-name (doom-project-root)))
;;           n))

;; (after! projectile
;;   (defun my-project-terminals ()
;;     (let ((defaults
;;            (cond
;;             ((file-equal-p (doom-project-root)
;;                            (expand-file-name "~/services/feature/"))
;;              '((1 nil)
;;                (2 "figlet 'hello there'")
;;                (3 nil)))

;;             ((file-equal-p (doom-project-root)
;;                            (expand-file-name "~/services/master/"))
;;              '((1 nil))))))

;;       (dolist (term defaults)
;;         (let* ((n (car term))
;;                (cmd (cadr term))
;;                (buf (my-vterm-name n))
;;                (default-directory (doom-project-root)))
;;           (unless (get-buffer buf)
;;             (save-window-excursion
;;               (my-vterm-create n cmd)))))))

;;   (add-hook 'projectile-after-switch-project-hook
;;             #'my-project-terminals))

;; (defun my-vterm-create (n &optional cmd)
;;   (let ((default-directory (doom-project-root)))
;;     (+vterm/here nil)
;;     (rename-buffer (my-vterm-name n) t)
;;     (when cmd
;;       (vterm-send-string cmd)
;;       (vterm-send-return))))

;; (defun my-vterm-new ()
;;   (interactive)
;;   (let ((n 1))
;;     (while (get-buffer (my-vterm-name n))
;;       (setq n (1+ n)))
;;     (my-vterm-create n)))

;; (defun my-vterm-jump (n)
;;   (interactive)
;;   (let ((buf (get-buffer (my-vterm-name n))))
;;     (if buf
;;         (switch-to-buffer buf)
;;       (user-error "No terminal %d for this project" n))))

;; (map! :leader
;;       :prefix "o"
;;       :desc "New project terminal" "n" #'my-vterm-new

;;       "1" (cmd! (my-vterm-jump 1))
;;       "2" (cmd! (my-vterm-jump 2))
;;       "3" (cmd! (my-vterm-jump 3))
;;       "4" (cmd! (my-vterm-jump 4))
;;       "5" (cmd! (my-vterm-jump 5))
;;       "6" (cmd! (my-vterm-jump 6))
;;       "7" (cmd! (my-vterm-jump 7))
;;       "8" (cmd! (my-vterm-jump 8))
;;       "9" (cmd! (my-vterm-jump 9)))

;; ;; Hides vterm-scratchpad terminals from SPC ,
;; (after! consult
;;   (add-to-list 'consult-buffer-filter
;;                "\\`\\*vterm-scratchpad:"))


;;; Python
;; Python LSP: ty only
(defun my-work-monorepo-p (&optional directory)
  "Return non-nil if DIRECTORY is in either work monorepo checkout."
  (let ((directory (file-name-as-directory
                    (file-truename (or directory default-directory)))))
    (seq-some
     (lambda (root)
       (let ((root (file-name-as-directory
                    (file-truename (expand-file-name root)))))
         (string-prefix-p root directory)))
     '("~/services/feature/" "~/services/master/"))))

(defun my-work-eglot-settings-h ()
  "Apply buffer-local Eglot performance settings in work checkouts."
  (when (my-work-monorepo-p)
    (setq-local eglot-autoshutdown t
                eglot-events-buffer-config '(:size 0 :format short)
                ;; Batch edits a little longer before notifying the server.
                eglot-send-changes-idle-time 1.0
                ;; Don't proactively ask for code actions at point.
                eglot-code-action-indications nil)))

;; Run before Doom starts Eglot, including on its first lazy load.
(add-hook 'prog-mode-hook #'my-work-eglot-settings-h)

(after! eglot
  ;; Also cover buffers whose modes do not derive from prog-mode.
  (add-hook 'eglot-managed-mode-hook #'my-work-eglot-settings-h)

  (defclass my-eglot-ty (eglot-lsp-server) ()
    :documentation "Eglot server with ty-specific client capabilities.")

  (setf (alist-get '(python-mode python-ts-mode)
                    eglot-server-programs
                    nil nil #'equal)
        '(my-eglot-ty "ty" "server"))

  ;; Disable dynamic filesystem watching only for ty in work checkouts.
  (cl-defmethod eglot-client-capabilities :around ((server my-eglot-ty))
    (let* ((caps (cl-call-next-method))
            (workspace (plist-get caps :workspace)))
      (when (and workspace
                 (my-work-monorepo-p
                  (project-root (eglot--project server))))
        (plist-put workspace
                   :didChangeWatchedFiles
                   '(:dynamicRegistration :json-false)))
      caps))

  ;; Watcher requests are asynchronous: scope these limits using the server's
  ;; project, not whichever buffer happens to be current when a request arrives.
  (cl-defmethod eglot-register-capability :around
    (server (method (eql workspace/didChangeWatchedFiles)) id &rest _params)
    (if (my-work-monorepo-p (project-root (eglot--project server)))
        (let ((eglot-max-file-watches 500)
              (eglot-watch-files-outside-project-root nil))
          (cl-call-next-method))
      (cl-call-next-method))))

;; Python formatting/import sorting: Ruff outside LSP
(after! apheleia
  (setf (alist-get 'python-mode apheleia-mode-alist)
        '(ruff-isort ruff))
  (setf (alist-get 'python-ts-mode apheleia-mode-alist)
        '(ruff-isort ruff)))


;;; Odin
(setq-hook! '(odin-mode-hook odin-ts-mode-hook)
  indent-tabs-mode t
  tab-width 4)
