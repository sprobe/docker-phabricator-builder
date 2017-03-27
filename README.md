# Docker Phabricator Builder

This will setup a Docker container which contains the following tools:
- Docker
- Git
- OpenSSH
- OpenSSH Client

An entry point is also included to configure the container and add the necessary SSH keys so that the builder can connect with the Phabricator server and vice versa.

### Environment Variables
<table>
  <thead>
    <th>Variable</th>
    <th>Value</th>
    <th>Description</th>
  </thead>
  <tbody>
    <tr>
      <td>PHABRICATOR_HOST</td>
      <td>phabricator.sprobe.ph</td>
      <td>The Phabricator host URL</td>
    </tr>
    <tr>
      <td>PHABRICATOR_HOST_PORT</td>
      <td>22</td>
      <td>The Phabricator host SSH port</td>
    </tr>
    <tr>
      <td>HOST_KEY</td>
      <td>ssh-rsa AAAAB3NzaC1yc2EAAAA...</td>
      <td>The generated public SSH key</td>
    </tr>
    <tr>
      <td>USER_KEY</td>
      <td>
      -----BEGIN RSA PRIVATE KEY-----<br>
      AAABAFPZNuvGou6u044mK...<br>
      -----END RSA PRIVATE KEY-----
      </td>
      <td>The generated private SSH key</td>
    </tr>
  </tbody>
</table>

### Docker Compose File for the Builder
```YAML
version: '2'
services:
  phabricator-builder:
    privileged: true
    image: sprobe/phabricator-builder
    environment:
      PHABRICATOR_HOST: phabricator.sprobe.ph
      PHABRICATOR_HOST_PORT: '22'
      HOST_KEY: ssh-rsa AAAAB3NzaC1yc2EAAAA...
      USER_KEY: |-
        -----BEGIN RSA PRIVATE KEY-----
        AAABAFPZNuvGou6u044mK...
        -----END RSA PRIVATE KEY-----
    dns:
    - 10.17.1.6
    - 8.8.8.8
    ports:
    - 2221:22/tcp
```
