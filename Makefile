PHONY: build test install

build:
	mkdir -p /tmp/bundles
	cd blockami && tar czvf /tmp/bundles/blockami-bundle.tar.gz ./ && cd -

test: build
	opa test --bundle /tmp/bundles/blockami-bundle.tar.gz

install:
	sudo wget -O /usr/bin/opa https://github.com/open-policy-agent/opa/releases/download/v0.43.0/opa_linux_amd64
	sudo chmod +x /usr/bin/opa