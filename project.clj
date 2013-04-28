(defproject lein-as-resource "0.1.0-SNAPSHOT"
  :description "Provide leiningen as a resource jar on the classpath."
  :url "https://github.com/pallet/lein-as-resource"
  :license {:name "Eclipse Public License"
            :url "http://www.eclipse.org/legal/epl-v10.html"}
  :dependencies [[org.clojure/clojure "1.5.1"]
                 [leiningen "2.1.3"]]
  ;; :uberjar-exclusions [#"^clojure/.*$" #"META-INF/maven/org.clojure/clojure.*"]
  ;; we put the uberjar in classes, which means it will be included
  ;; in the final jar
  :uberjar-name "classes/lein-standalone.jar"
  :aliases {"jar" ["do" "uberjar," "jar"]
            "install" ["do" "uberjar," "install"]
            "deploy" ["do" "uberjar," "deploy"]}
  :resource {:resource-paths ["target"]
             :includes [#".*lein-standalone.jar"]})
