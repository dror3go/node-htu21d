#!/bin/make -f
# -*- makefile -*-
# SPDX-License-Identifier: MIT

default: help all
	@echo "log: $@: $^"

tmp_dir ?= tmp
runtime ?= iotjs
export runtime

main_src ?= htudemo.js

iotjs_modules_dir?=${CURDIR}/iotjs_modules

color-sensor-js_url?=https://github.com/rzr/color-sensor-js
color-sensor-js_revision?=master
iotjs_modules_dirs+=${iotjs_modules_dir}/color-sensor-js


help:
	@echo "## Usage: "
	@echo "# make start"


${iotjs_modules_dir}/color-sensor-js:
	mkdir -p ${@D}
	git clone --recursive --depth 1 ${color-sensor-js_url} -b ${color-sensor-js_revision} $@
	-rm -rf ${@}/.git

build:

modules/${runtime}: ${iotjs_modules_dirs}

modules: modules/${runtime}

start/%: ${main_src} build modules
	${@F} $< ${run_args}

start: start/${runtime}

