REPO  ?= tch285
IMAGE ?= roounfold
TAG   ?= 310

build:
	docker build -t $(REPO)/$(IMAGE):$(TAG) .
push:
	docker push $(REPO)/$(IMAGE):$(TAG)
run:
	docker run -it --rm $(REPO)/$(IMAGE):$(TAG)

.PHONY: build push run