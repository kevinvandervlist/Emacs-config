#!/bin/bash
if [ $# -ne 1 ]; then
	echo "Copy the emacs config to a certain directory."
	echo "The old emacs config is backed up."
	echo "Usage: `basename $0` /path/to/dest."
	exit 1
fi

DEST=$1
CWD=$(pwd)
TMPDIR=$(mktemp -d)

mkdir -p ${DEST}

if [ -f "${DEST}/.emacs" ]; then
	cp -r ${DEST}/.emacs.d ${TMPDIR}/.emacs
fi

if [ -d "${DEST}/.emacs.d" ]; then
	cp -r ${DEST}/.emacs.d ${TMPDIR}/.emacs.d
fi

cp -r ${CWD}/.emacs.d ${DEST}/.emacs.d
cp ${CWD}/.emacs ${DEST}/.emacs

echo "Copied files to ${DEST}/."
echo "Backup is in ${TMPDIR}"
exit 0
