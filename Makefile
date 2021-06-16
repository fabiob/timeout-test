.PHONY: build test

DOCKER_TAG = timeout-test
TEST_PORT = 8888

build:
	docker build -t $(DOCKER_TAG) .

test: build
	docker run -d --name timeout-test -p $(TEST_PORT):80 $(DOCKER_TAG)
	sleep 5
	time curl --verbose --progress-meter http://localhost:$(TEST_PORT)
	docker stop timeout-test
	docker rm timeout-test
