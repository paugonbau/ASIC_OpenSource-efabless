#!/bin/bash


apt update -y
apt upgrade -y
apt install software-properties-common -y
add-apt-repository ppa:deadsnakes/ppa -y

apt install -y \
	wget \
	autoconf \
	automake \
	bison \
	bzip2 \
	clang \
	csh \
	curl \
	flex \
	gawk \
	gcc \
	gdb \
	gettext \
	git \
	graphviz \
	help2man \
	libxml2-dev \
	libxslt-dev \
	make \
	python3.10 \
	python3-pip \
	ncurses-dev \
	ninja-build \
	patch \
	strace \
	tcl \
	tcl-dev \
	tcllib \
	tclx \
	texinfo \
	tk \
	tk-dev \
	vim-common \
	wget \
	xdot 


pip3 install --no-cache-dir --upgrade pip

pip install --no-cache-dir \
	matplotlib \
	"jinja2<3.0.0" \
	pandas \
	install \
	XlsxWriter
