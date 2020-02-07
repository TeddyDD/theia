#!/bin/sh
set -euf
# License: Unlicense

log() {
	printf '\033[32m->\033[m %s\n' "$*"
}

dbg() {
	printf '\033[31m->\033[m %s\n' "$*"
}

die() {
	log "$*" >&2
	exit 1
}

usage() {
	echo "${0##*/} LIST
    install tools from LIST file
    "
	exit 0
}

main() {
	case "${1:-}" in
	h | help | -h | --help | '')
		usage
		;;
	esac

	for D in $(grep -v "#" "$1"); do
		tmp="$(mktemp -d)"
		(
			git clone "https://${D%cmd/*}" "${tmp}"
			cd "$tmp"
			cd "cmd/${D##*/}" || :
			go get
			GO111MODULE=on CGO_ENABLED=0 go build -ldflags "-w -s"
			rm -rf "$tmp"
		)
	done
}

main "$@"
