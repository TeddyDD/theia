#!/bin/sh
set -eu

CUT_LENGTH="${CUT_LENGTH:-6}"

if [ ! "$REQUEST_METHOD" = "POST" ]; then
	echo "Status: 405"
	echo "Allow: POST"
	echo
	exit 0
fi

mkdir /tmp/shortener-lock/ || (
	echo "Status: 500"
	echo
	exit 0
)
trap "rm -rf /tmp/shortener-lock" INT EXIT

# shellcheck disable=SC2154
sum="$(echo "$v_url" | sha512sum | cut -c -"$CUT_LENGTH")"
res="$sum $v_url"

echo "$res" >>sums.wa
sort sums.wa | uniq >sums
cp sums sums.wa

echo "$sum"
