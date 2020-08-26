# Dockerfile should pass hadolint
# (Optional) Build a simple integration test

lint:
	# See local hadolint install instructions:   https://github.com/hadolint/hadolint
	# This is linter for Dockerfiles
	hadolint Dockerfile

all: lint
