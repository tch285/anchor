REPO  ?= tch285
IMAGE ?= alian
TAG   ?= latest

build:
	docker build -t $(IMAGE):$(TAG) .
push:
	docker push $(REPO)/$(IMAGE):$(TAG)
run:
	docker run -it --rm $(REPO)/$(IMAGE):$(TAG)

.PHONY: build push run