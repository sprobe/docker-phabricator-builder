#!/bin/sh
set -e

# no arguments passed
# or first arg is `-f` or `--some-option`
if [ "$#" -eq 0 -o "${1#-}" != "$1" ]; then
	# add our default arguments
	set -- dockerd \
		--host=unix:///var/run/docker.sock \
		--host=tcp://0.0.0.0:2375 \
		--storage-driver=vfs \
		"$@"
fi

if [ "$1" = 'dockerd' ]; then
	# if we're running Docker, let's pipe through dind
	# (and we'll run dind explicitly with "sh" since its shebang is /bin/bash)
	set -- sh "$(which dind)" "$@"
fi

ssh-keygen -A
/usr/sbin/sshd

mkdir /root/.ssh
mkdir /var/drydock

echo "$USER_KEY" > /root/.ssh/id_rsa
chmod 600 /root/.ssh/id_rsa

echo "$HOST_KEY" > /root/.ssh/authorized_keys
chmod 644 /root/.ssh/authorized_keys

ssh-keyscan -t rsa -p "$PHABRICATOR_HOST_PORT" "$PHABRICATOR_HOST" >> /root/.ssh/known_hosts

exec "$@"
