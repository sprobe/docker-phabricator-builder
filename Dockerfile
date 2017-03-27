FROM docker:17.03-dind

RUN apk add --no-cache \
		git \
		openssh-client \
        openssh
        
COPY dockerd-entrypoint.sh /usr/local/bin/

RUN chmod uog+x /usr/local/bin/dockerd-entrypoint.sh