#!/bin/bash
# This is a smaple shellcheck file - PLEASE ADJUST
set -e
set -o pipefail

print_in_color() {
    printf "%b" \
        "$(tput setaf "$2" 2> /dev/null)" \
        "$1" \
        "$(tput sgr0 2> /dev/null)"
}

print_in_green() {
    print_in_color "$1" 2
}


print_in_red() {
    print_in_color "$1" 1
}

print_success() {
    print_in_green "   [✔] $1\n"
}

print_error(){
    print_in_red "   [✘] $1\n"
}

print_error_stream() {
    while read -r line; do
        print_in_red "↳ ERROR: $line"
    done
}


ERRORS=()

# find all executables and run `shellcheck`
for f in $(find . -type f -not -path '*.git*' | sort -u); do
	if file "$f" | grep --quiet shell; then
		{
			shellcheck "$f"  && print_success "[OK]: successfully linted $f"
		} || {
			# add to errors
			ERRORS+=("$f")
            print_error "[ERROR]: found lining error $f"
		}
	fi
done

if [ ${#ERRORS[@]} -eq 0 ]; then
	print_in_green "No errors, hooray"
else
	print_in_red "These files failed shellcheck: ${ERRORS[*]}"
	exit 1
fi