IMAGE=moorara/lamp
VERSION=latest

build:
	docker build -t $(IMAGE):$(VERSION) .

run:
	docker run -d -p 80:80 -p 3306:3306 $(IMAGE):$(VERSION)

.PHONY: build run
