package main

import (
	"encoding/json"
	"net/http"
)

func handler(res http.ResponseWriter, req *http.Request) {
	response := map[string]string{}

	res.Header().Set("Content-Type", "application/json")

	if req.URL.String() == "/" {
		response["message"] = "Hello, World!"
		res.WriteHeader(200)
	} else {
		response["error"] = "Not found"
		res.WriteHeader(404)
	}

	str, _ := json.Marshal(response)
	res.Write([]byte(str))
}

func main() {
	http.HandleFunc("/", handler)
	http.ListenAndServe(":8080", nil)
}
