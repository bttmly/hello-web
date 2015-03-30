(ns app.core
  (:use org.httpkit.server))

(defn handler [ring-request]
  (with-channel ring-request channel
    (send! channel {:status 200
                    :headers {"Content-Type" "text/plain"}
                    :body    "hello world"})))

(defn -main [& args]
  (run-server handler {:port 8080})) ; Ring server
