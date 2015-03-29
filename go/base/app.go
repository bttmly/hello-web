package main

import (
  "fmt"
  "net/http"
  "encoding/json"
)

func handler(res http.ResponseWriter, req *http.Request) {
  // fmt.Println(req.URL)

  response := map[string]string{}

  if req.URL.String() == "/" {
    response["message"] = "Hello, World!"
  } else {
    response["error"] = "Not Found"
  }

  var str, _ = json.Marshal(response)
  res.Write([]byte(str))
}

func main() {
  http.HandleFunc("/", handler)
  http.ListenAndServe(":8080", nil)
}
