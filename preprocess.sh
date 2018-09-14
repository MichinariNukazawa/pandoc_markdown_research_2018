#!/bin/bash
#

set -eu
set -o pipefail

trap 'echo "error:$0($LINENO) \"$BASH_COMMAND\" \"$@\""' ERR

[ 2 -eq $# ]

OBJECT_DIR=$1
SOURCE_FILE=$2

SOURCE_FILENAME=`basename ${SOURCE_FILE}`

cat ${SOURCE_FILE}		> ${OBJECT_DIR}/${SOURCE_FILENAME}
# 文中埋め込みリンク
sed -i 's/\([^!]\)\[\(.\+\)\](\(.\+\))\(.\+\)  /\1\\[[\2](\3)\\](\3)\4  /g' ${OBJECT_DIR}/${SOURCE_FILENAME}
# 行リンク
sed -i 's/^\[\(.\+\)\](\(.\+\))  $/\\[[\1](\2)\\]\n(\2)/g' ${OBJECT_DIR}/${SOURCE_FILENAME}

