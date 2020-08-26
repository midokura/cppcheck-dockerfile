DOCKER_REPO ?= yamt
DOCKER_IMAGE ?= cppcheck-static-2.1
DOCKER_TAG ?= latest
DOCKER_NAME ?= $(DOCKER_REPO)/$(DOCKER_IMAGE):$(DOCKER_TAG)

build_with_docker:
	docker build -f Dockerfile -t $(DOCKER_NAME) .

push:
	docker push $(DOCKER_NAME)
