FROM ubuntu

MAINTAINER Jake Burkhead "jakelauburkhead@gmail.com"

RUN apt-get update -qq && apt-get install -yqq golang

ADD . /server
WORKDIR /server

EXPOSE 8080

CMD go run app.go
