#!/usr/bin/env bash
#
# Behavior:
#  * if no argument is passed, will zip the MODNAME directory into
#    MODNAME.zip
#  * if an argument is passed, will assume it to be the deploy directory
#    and rsync current mod folder into the remote res/mods/.
#
# This script will assume being located into the utils/ subfolder of the
# mod.

MODNAME="bicobus"
WORKINGDIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

DESTINATION=""
if [[ -n "$@" ]]; then
    if [[ -d $@ ]]; then
        DESTINATION=$@
        DEPLOYDIR="${DESTINATION}/res/mods"
    else
        echo >&2 "WARNING: Couldn't find target directory, or isn't a directory. Ignoring."
    fi
fi

cd "${WORKINGDIRECTORY}/.."

if [[ -n "${DESTINATION}" ]]; then
    rsync -vcru "${MODNAME}/" "${DEPLOYDIR}/${MODNAME}"
    exit 0
fi

if [[ -f "${MODNAME}.zip" ]]; then
    mv "${MODNAME}.zip" "${MODNAME}.zip.bak"
fi
zip -r "${MODNAME}.zip" "${MODNAME}"
