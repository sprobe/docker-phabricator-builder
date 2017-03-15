FROM docker:17.03-dind

RUN apk add --no-cache \
		git \
		openssh-client
