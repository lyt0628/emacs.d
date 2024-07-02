;;; init-chinese.el --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; 

;;; Code:

(set-language-environment "UTF-8")

(set-default-coding-systems 'utf-8)

(setq default-file-name-coding-system "utf-8")

(prefer-coding-system 'utf-8)

(set-fontset-font t 'han (font-spec :family "Microsoft YaHei" :size 25))

(provide 'init-chinese)

;;; init-chinese.el ends here

