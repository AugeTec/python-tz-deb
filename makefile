PYTZ_VERSION=2023.3

all:
	make download_sources
	make extract_sources
	make build

install_build_deps:
	pip3 install stdeb requests

download_sources:
	pypi-download pytz --release=${PYTZ_VERSION}

extract_sources:
	tar -xvf pytz-${PYTZ_VERSION}.tar.gz

build:
	# clean previous build
	rm -rf pytz-${PYTZ_VERSION}/deb_dist

	# backup setup.cfg if required
	if [ ! -f pytz-${PYTZ_VERSION}/setup.cfg.bak ]; then cp pytz-${PYTZ_VERSION}/setup.cfg pytz-${PYTZ_VERSION}/setup.cfg.bak; fi
	cat pytz-${PYTZ_VERSION}/setup.cfg.bak stdeb.cfg > pytz-${PYTZ_VERSION}/setup.cfg
	cd pytz-${PYTZ_VERSION} && python3 setup.py --command-packages=stdeb.command bdist_deb
	cp -r pytz-${PYTZ_VERSION}/deb_dist/python3-tz_*.deb ./python3-tz_${PYTZ_VERSION}.deb
	

version:
	@echo ${PYTZ_VERSION}

clean:
	rm -rf pytz-*
	rm -rf python3-tz*.deb
