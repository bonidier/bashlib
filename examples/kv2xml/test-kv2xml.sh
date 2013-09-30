#!/bin/bash
. ../../lib/kv2xml/kv2xml.lib.sh

_KV2XML_SEP_PATH="/"
_KV2XML_SEP_KV="="

test_string="level1/level2/level3 = value1"
echo "== simple test with variable =="
echo $test_string | kv2xml

echo "== test with file content =="
echo "<first-tag>" > out.xml
kv2xml < input-kv-file.txt >> out.xml
echo "</first-tag>" >> out.xml

