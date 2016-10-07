# Inotify Docker Image

## Description

This docker image runs a [inotify](https://github.com/rvoicilas/inotify-tools/wiki) service based on [Alpine Linux](https://hub.docker.com/_/alpine/).

[![](https://images.microbadger.com/badges/image/pstauffer/inotify.svg)](https://microbadger.com/images/pstauffer/inotify)

## Usage

If you like to use this image, please use a specific version tag like `v1.0.0` or the branches `latest`, `stable`. The other branches are only temporary and will be deleted after the merge into the other branches.

* Link docker socket into container `-v /var/run/docker.sock:/var/run/docker.sock:ro`
* Link one or more directories, which you would like to monitor with inotifywait into the docker container. As example: `-v /var/lib/docker/data/bind/config:/config`.
* Set container variable `CONTAINER=<id|name>`, which will be notified.
* Define the volume variable to define the container internal paths to the monitored directories.


### Docker Run

```
docker run -d --name inotify -v /var/run/docker.sock:/var/run/docker.sock:ro \
-v /var/lib/docker/data/bind/config:/config \
-e "CONTAINER=bind" -e "VOLUMES=/config" \
pstauffer/inotify:stable
```


### Docker Compose
Check out the docker-compose file in the [git repo](https://raw.githubusercontent.com/pstauffer/docker-inotify/master/docker-compose.yml) and create your own file. After that run this `docker-compose` command.
```
docker-compse up -d
```


### Curl Options
For debug propose it's possible to pass additional curl options into the container. Just set the environment variable `CURL_OPTIONS=-v`.


### Signal
The default signal is `SIGHUP`. This behaviour can be overwritten, if you set the environment variable `SIGNAL=<signal>`.


### Inotify Events
The default inotify events are `create,delete,modify,move`. This behaviour can be overwritten, if you set the environment variable `INOTIFY_EVENTS=<events>`.

### Inotify Options
To define your own inotify options, overwrite the variable `INOTIFY_OPTONS=<your options>`.


## Security
Please be aware that the Docker Socket is mounted inside this Docker Container and with that you can manipulate all containers. So don't expose ports or use this image for external services!


## Debugging

### Docker API Requests
Here are some sample API requests. Just exec the shell and try out the commands. Check out the [Docker API Documentation](https://docs.docker.com/engine/reference/api/docker_remote_api_v1.22/) for more calls.
```
# get all containers
curl --unix-socket /var/run/docker.sock http:/containers/json

# stop a container
curl -X POST --unix-socket /var/run/docker.sock http:/containers/bind/stop

# send a signal to a container
curl -X POST --unix-socket /var/run/docker.sock http:/containers/bind/kill?signal=SIGHUP
```


## License
This project is licensed under `MIT <http://opensource.org/licenses/MIT>`_.
