# Specify the shell for executing commands
SHELL=/usr/bin/bash

# Docker image and tag names
IMAGE_NAME = url_shortener-url-shortener
TARGET_TAG = latest
DESTINATION_TAG = shanumbra/url_shortener

# Declare the targets that don't correspond to files
.PHONY: start capture_tag tag_image push_image clean

# Target: Start Docker Compose services
start:
	docker-compose up -d

# Target: Capture the ID of the latest image
capture_tag:
	latest_image_id=$$(docker images $(IMAGE_NAME) --format "{{.ID}}" | head -n 1); \
	echo "Latest Image ID: $$latest_image_id"; \
	echo "$$latest_image_id" > latest_image_id.txt

# Target: Tag the latest image
tag_image:
	latest_image_id=$$(cat latest_image_id.txt); \
	echo "Tagging Image ID: $$latest_image_id"; \
	docker tag "$$latest_image_id" $(DESTINATION_TAG):$(TARGET_TAG)

# Target: Push the tagged image to Docker Hub
push_image:
	docker push $(DESTINATION_TAG):$(TARGET_TAG)

# Target: Clean up intermediate files
clean:
	rm -f latest_image_id.txt

# Target: Chain the steps together by specifying dependencies
all: start capture_tag tag_image push_image clean

# Add .ONESHELL to execute all commands in a single shell, necessary for preserving variable values
.ONESHELL:
