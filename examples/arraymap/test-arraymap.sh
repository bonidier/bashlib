#!/bin/bash

. ../../lib/arraymap/arraymap.lib.sh

keyX=123
keyY=456
keyZ=789

echo "- defining my keys"
array_mapset keyX keyY keyZ

echo "- adding some values for each keys in myarray"
array_add myarray keyX "value for keyX"
array_add myarray keyY "value for keyY in myarray1"
array_add myarray keyZ "valueZ for keyZ"

echo "- same for myarray2"
array_add myarray2 keyY "valueY for keyY in myarray2"

echo "- get value for keyX in myarray"
array_get myarray keyX
echo "- get value for keyY in myarray2"
array_get myarray2 keyY

echo "other features"
echo "- show keys"
array_mapget

echo "- show your filled arrays"
array_dump myarray
array_dump myarray2
