;;; ob-skynet.el --- Org-babel functions for skynet  -*- lexical-binding: t; -*-

;; Copyright (C) 2024 lyt0628

;; Author: lyt0628
;; Maintainer: lyt0628
;; Created: 13 April 2024
;; Keywords: lua, skynet, org, babel
;; Homepage: https://github.com/lyt0628/ob-skynet
;; Version: 0.0.1

;;; License:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;;; Requirements:

;;; Code:

(defun lyt-mvn-clean ()
  "Run commandline `mvn clean`."
  (interactive)
  (async-shell-command "mvn clean"))

(defun lyt-mvn-package ()
  "Run commandline `mvn clean package`."
  (interactive)
  (async-shell-command "mvn clean package"))


(defhydra hydra-maven (nil nil)
  ""
  ("c" lyt-mvn-clean "clean" :color blue)
  ("p" lyt-mvn-package "package" :color blue)
  ("q" nil "quit" :color blue))

(global-set-key (kbd "C-z m") 'hydra-maven/body)



(provide 'init-maven)

;;; init-maven.el ends here
