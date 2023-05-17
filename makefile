all:
	make install_build_deps
	make download_sources
	make extract_sources
	make build

install_build_deps:
	pip install stdeb

download_sources:
	pypi-download pytz --release=${PYTZ_VERSION}

extract_sources:
	tar -xvf pytz-${PYTZ_VERSION}.tar.gz

build:
	cd pytz-${PYTZ_VERSION} && python3 setup.py --command-packages=stdeb.command bdist_deb 
	mv pytz-${PYTZ_VERSION}/deb_dist .
	

clean:
	rm -rf pytz-*