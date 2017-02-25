FROM debian:testing
ENV DEBIAN_FRONTEND noninteractive

COPY	locale.get /etc/locale.gen-docker
RUN	dpkg-divert /etc/locale.gen \
&&      echo tzdata tzdata/Zones/Etc select UTC | debconf-set-selections \
&&      echo debconf debconf/priority select critical | debconf-set-selections \
&&      echo debconf debconf/frontend select readline | debconf-set-selections \
&&      echo debconf debconf/frontend seen false | debconf-set-selections \
&&	apt-get update -qqy \
&&	apt-get dist-upgrade -fyqq
&&	apt-get -yqq locales install texlive-full texlive-latex-extra \
&&	apt-get clean \
&&	rm -rf /var/lib/apt/lists/* \
&&	/etc/locale.gen-docker /etc/locale.gen \
&&	locale-gen \
&&	dpkg-reconfigure locales \
&&	dpkg-reconfigure tzdata
CMD	[ "/bin/bash", "-li" ]