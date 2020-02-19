#!/bin/sh

set -eu

CUT_LENGTH="${CUT_LENGTH:-6}"

sum="$(echo "${REQUEST_URI#/}" | cut -c -"$CUT_LENGTH")"
url="$(grep "${sum}" sums | cut -d ' ' -f 2)"

[ -n "$url" ] || exit
echo "Location: $url"
echo
