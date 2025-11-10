#!/usr/bin/env bash
PROJECT_ROOT=$1

echo "formatting for project $PROJECT_ROOT"
# exclude all hidden files
for i in $(find $PROJECT_ROOT -type f -not -path '*/.*'); do
	if [[ $i == *.nix ]]; then
		echo "formatting nix file $i"
		nixfmt $i
	fi
done
