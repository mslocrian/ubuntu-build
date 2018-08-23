export DOCKERHUB_USER = mslocrian
export DOCKERHUB_REPO = ubuntu-build
export DOCKERHUB_VERSION = bionic-go1.10.3

help:
	@echo "base				runs build-docker-base and push-docker-base"
	@echo "build-docker-base		builds the docker image"
	@echo "push-docker-base		pushes the docker image to dockerhub"

base: build-docker-base push-docker-base

build-docker-base:
	docker build -f Dockerfile-base -t $(DOCKERHUB_REPO):$(DOCKERHUB_VERSION) .

push-docker-base: export DOCKER_IMAGE_ID = $(shell docker images -q $(DOCKERHUB_REPO):$(DOCKERHUB_VERSION))
push-docker-base:
	@printf "Enter DockerHub "
	@docker login -u $(DOCKERHUB_USER)
	docker tag $(DOCKER_IMAGE_ID) $(DOCKERHUB_USER)/$(DOCKERHUB_REPO):$(DOCKERHUB_VERSION)
	docker push $(DOCKERHUB_USER)/$(DOCKERHUB_REPO):$(DOCKERHUB_VERSION)
