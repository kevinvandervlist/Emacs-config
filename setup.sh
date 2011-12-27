#!/bin/bash
if [ $# -ne 1 ]; then
	echo "Copy the emacs config to a certain directory."
	echo "Usage: `basename $0` /path/to/dest."
	exit 1
fi

DEST=$1
CWD=$(pwd)

mkdir -p ${DEST}

cp -r ${CWD}/.emacs.d ${DEST}/.emacs.d
cp ${CWD}/.emacs ${DEST}/.emacs

echo "Copied files to ${DEST}/."
exit 0
