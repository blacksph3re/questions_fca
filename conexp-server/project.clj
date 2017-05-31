;; Copyright ⓒ the conexp-clj developers; all rights reserved.
;; The use and distribution terms for this software are covered by the
;; Eclipse Public License 1.0 (http://opensource.org/licenses/eclipse-1.0.php)
;; which can be found in the file LICENSE at the root of this distribution.
;; By using this software in any fashion, you are agreeing to be bound by
;; the terms of this license.
;; You must not remove this notice, or any other, from this software.

;;;

(defproject conexp-clj "2.0.0-SNAPSHOT"
  :min-lein-version "2.0.0"
  :description "A ConExp rewrite in clojure"
  :url "http://github.com/exot/conexp-clj/"
  :license {:name "Eclipse Public License"
            :url "http://www.eclipse.org/legal/epl-v10.html"}
  :dependencies [[org.clojure/clojure             "1.8.0"]
                 [org.clojure/tools.cli           "0.3.5"]
                 [org.clojure/math.combinatorics  "0.1.3"]
                 [org.clojure/math.numeric-tower  "0.0.4"]
                 [org.apache.commons/commons-math "2.2"]
                 [seesaw                          "1.4.5"]
                 [reply                           "0.3.7"
                  :exclusions [org.clojure/clojure
                               com.cemerick/drawbridge]]
                 [org.clojure/data.xml            "0.0.8"]
                 [org.clojure/core.async          "0.2.391"]
                 [http-kit "2.2.0"]]
  :plugins [[lein-exec "0.3.6"]]
  :main conexp.main
  :aot [conexp.main]
  :keep-non-project-classes true
  :source-paths ["src/main/clojure" "src/test/clojure"]
  :java-source-paths ["src/main/java"]
  :test-paths ["src/test/clojure"]
  :resource-paths ["src/main/resources"]
  :target-path "builds/%s"
  :compile-path "%s/classes/"
  :scm {:url "git@github.com:exot/conexp-clj.git"}
  :java-opts ["-Dawt.useSystemAAFontSettings=on"])

;;;

nil
