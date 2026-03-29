#!/usr/bin/env bash
set -uo pipefail
if (( $# > 0 )); then
	args=("$@")
else
	args=(
		sea
		scales
		2
		red
		orange
		yellow
	)
fi
printf 'Environment: %s\nTexture: %s\nWings: %s\nColours: (%s, %s, %s)\n' \
	"${args[0]}" \
	"${args[1]}" \
	"${args[2]}" \
	"${args[@]:3:3}"
swipl \
	-s src/main.pro \
	-g "validate($(printf '%s,' "${args[@]}" | perl -pe 's|,$||g'))" \
	-t halt
