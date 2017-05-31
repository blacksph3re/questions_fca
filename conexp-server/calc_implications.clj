(require 'org.httpkit.server)
(use 'org.httpkit.server)
(require 'conexp.main)
(use 'conexp.main)

(defn random-filename
        ([] (random-filename 8))
        ([n]
           (let [chars (map char (range 97 122))
                 password (take n (repeatedly #(rand-nth chars)))]
             (reduce str password))))      


(defn handler [req]
  (with-channel req channel              ; get the channel
    ;; communicate with client using method defined above
    (on-close channel (fn [status]
                        (println "channel closed")))
    (if (websocket? channel)
      (println "WebSocket channel")
      (println "HTTP channel"))
    (on-receive channel (fn [data]       ; data received from client
          (def file (str "/tmp/clojure-implications-" (random-filename 40)))
          (spit file data)
          (def ctx (read-context file))


           ;; An optional param can pass to send!: close-after-send?
           ;; When unspecified, `close-after-send?` defaults to true for HTTP channels
           ;; and false for WebSocket.  (send! channel data close-after-send?)
                          (send! channel (apply str (canonical-base ctx))))))) ; data is sent directly to the client
(run-server handler {:port 4001})
