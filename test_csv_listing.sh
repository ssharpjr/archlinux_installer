#!/usr/bin/env bash

tmpdir=$(mktemp -d)
pacprogs=$tmpdir/"pacman_progs.txt"
aurprogs=$tmpdir/"aur_progs.txt"
gitprogs=$tmpdir/"git_progs.txt"

rm -rf $tmpfile $pacprogs $aurprogs $gitprogs
touch {$tmpfile,$pacprogs,$aurprogs,$gitprogs}

# Remove header line
cat progs.csv | sed '/^#/d' > /tmp/progs.csv

while IFS=, read -r tag program comment; do
	case "$tag" in
		"") echo -n "$program " | tee -a $pacprogs > /dev/null 2&>1 ;;
		"A") echo -n "$program " | tee -a $aurprogs > /dev/null 2&>1 ;;
		"G") echo -n "$program " | tee -a $gitprogs > /dev/null 2&>1 ;;
  esac
done < /tmp/progs.csv

echo ===
echo pacman programs
echo ---
cat $pacprogs
echo
echo ===
echo aur programs
echo ---
cat $aurprogs
echo
echo ===
echo git programs
echo ---
cat $gitprogs
echo

