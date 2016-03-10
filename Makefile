DOCKER_IMAGE_VERSION=0.14.2-1
DOCKER_IMAGE_NAME=hmarc/rpi-homeassistant
DOCKER_IMAGE_TAGNAME=$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_VERSION)

default: build

build:
	wget "https://raw.githubusercontent.com/balloob/home-assistant/master/requirements_all.txt"
	docker build -t $(DOCKER_IMAGE_TAGNAME) .
	docker tag  $(DOCKER_IMAGE_TAGNAME) $(DOCKER_IMAGE_NAME):latest

push:
	docker push $(DOCKER_IMAGE_NAME)

test:
	mkdir -p /var/local/homeassistant/config
	cp configuration.yaml /var/local/homeassistant/config
	docker run -d --name="home-assistant" --device /dev/ttyACM0:/dev/zwave -v /var/local/homeassistant/config:/config -v /etc/localtime:/etc/localtime:ro --net=host hmarc/rpi-homeassistant