#!/usr/bin/env bash
set -uo pipefail
get() {
	local -n _out=$1
	local msg
	msg=$2
	shift 2
	local args
	args=("$@")
	while true; do
		echo "$msg"
		for i in "${!args[@]}"; do
			echo "$((i + 1)). ${args[$i]}"
		done
		# shellcheck disable=SC2162
		read -n 1 -s sel
		if (( sel >= 1 && sel <= 3)); then
			_out=${args[$((sel - 1))]}
			break
		else
			clear
			echo "'$sel' is invalid. Try again." >&2
		fi
	done
}
get env 'Choose an environment:' Land Sea Sky
# shellcheck disable=2154
echo "<$env>"
