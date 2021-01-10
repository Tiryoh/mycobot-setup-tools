#!/usr/bin/env bash
set -eu

SRC_DIR=$(cd $(dirname ${BASH_SOURCE:-$0})/../; pwd)

git_patch_apply() {
	git apply $1 || git apply $1 -R --check 2>/dev/null && { echo "git patch already applied" ; echo "the 'patch does not apply' error shown above can be ignored" ; }
}

fix_pymycobot() {
	pushd ${SRC_DIR}/elephantrobotics-mycobot > /dev/null
	if [ "$(git rev-parse HEAD)" = "c2d4acd1e1c63dd5b1a62724f57e11808fa16359" ]; then
		curl -Ss https://patch-diff.githubusercontent.com/raw/elephantrobotics/myCobot/pull/4.patch > ${SRC_DIR}/patch/4.patch
		git_patch_apply ${SRC_DIR}/patch/4.patch
	fi
	popd > /dev/null
}
