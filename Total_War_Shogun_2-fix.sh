#!/bin/sh
[ "$1" ] || set -- "/Applications/Total War SHOGUN 2.app"
[ -w "$1" ] && unset sudo || sudo=sudo
find "$1"/Contents/Resources/Data/data/help -depth -type f -name \*.html -execdir sh -c 'egrep -o "(href|src)=\"([^#\"]*)[^\"]*\"" "{}" | sed -n "s:.*=\"\([^#\"]*\)[^\"]*\".*:\1:p" | sort -u | while read file; do [ -f "$file" ] || echo "$file"; done | awk "{ print \",s:\\\"\" \$0 \"\\\([#\\\"]\\\):\\\"\" tolower(\$0) \"\\\1:g\" }; END { if (NR > 0) print \"w\" }" | '"$sudo "'ed -s "{}"' \;
