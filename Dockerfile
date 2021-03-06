FROM debian:stretch

ENV	DEBIAN_FRONTEND noninteractive
COPY	locale.gen /etc/locale.gen-docker
RUN	dpkg-divert /etc/locale.gen \
&&      echo tzdata tzdata/Zones/Etc select UTC | debconf-set-selections \
&&      echo debconf debconf/priority select critical | debconf-set-selections \
&&      echo debconf debconf/frontend select readline | debconf-set-selections \
&&      echo debconf debconf/frontend seen false | debconf-set-selections \
&&	apt-get update -y \
&&	apt-get dist-upgrade -fy \
&&	apt-get -y install locales texlive-full texlive-latex-extra \
&&	apt-get clean \
&&	rm -rf /var/lib/apt/lists/* \
&&	mv /etc/locale.gen-docker /etc/locale.gen \
&&	locale-gen \
&&	dpkg-reconfigure locales \
&&	dpkg-reconfigure tzdata
CMD	[ "/bin/bash", "-li" ]
ENV	DEBIAN_FRONTEND readline
