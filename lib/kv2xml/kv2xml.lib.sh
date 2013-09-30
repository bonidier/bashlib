#!/usr/bin/env bash
_KV2XML_SEP_PATH=""
_KV2XML_SEP_KV=""

#
# kv2xml converts key/value input format to XML
#
# input ine format : key_with_separator=value
#
## variables to set ##
# _KV2XML_SEP_PATH  # separator between key'tree and value
# _KV2XML_SEP_KV    # separator betwenn full key and value
#
## usage ##
# echo $string | k2xml
# your_script | k2xml
# kv2xml < input-file
#
function kv2xml
{
  local key_value key_tree key_tree_part key_depth dupkey
  local newline tmp
  local level j c
  local first_level=1
  #previous level depth
  local old_kd=0

  # separator between key's tree members
  local kp_sep=$_KV2XML_SEP_PATH
  # separator between key'tree and value
  local kv_sep=$_KV2XML_SEP_KV

  # we end on bad variables setting
  if [ -z  "$kp_sep" ] || [ -z "$kv_sep" ]; then
  	echo "_KV2XML_SEP_PATH / _KV2XML_SEP_KV empty" && return 1
  elif [ "$kp_sep" == "$kv_sep" ]; then
  	echo "_KV2XML_SEP_PATH / _KV2XML_SEP_KV should be different" && return 1
  fi

  local tag_closed

  while read newline; do
    key_tree=$(echo $newline | awk -F"$kv_sep" '{print $1}')
    key_value=$(echo $newline | awk -F"$kv_sep" '{print $2}')

	# tips : xml did not accept tag with numeric value only,
	# we merge numeric  key_tree with parent key
	key_tree=$(echo $key_tree | sed "s|${kp_sep}\([0-9]\)|_\\1|g")

	# we replace 'kp_sep' value with a space, to loop into key_tree variable
    key_tree_part=${key_tree//${kp_sep}/ }
	# we get key count
	key_depth=$(echo $key_tree_part | wc -w)
	# the last key is value's parameter, we remove it from key_depth
	let key_depth=key_depth-1

	# store key level into tree
    level=$first_level
	
	# flag for closing tag process
	tag_closed=0

	# this flag is used to notify user if current key is the same as precedent
    # in this case, line will be ignored
    dupkey=1

	# for each key in tree
    for k in $key_tree_part
    do

	  # if key is different from older stored at same position
      if [ "$k" != "${tmp[level]}" ]; then
	    # we disable duplicate key notification
	    dupkey=0
		# if current tree level is lower or same as previous level
	    if  [ $tag_closed -eq 0 ] && [ $level -le $old_kd ]; then
		   # that's the first level with a new value,
		   # we need to close tags from him to previous key_depth value
		   for ((c=old_kd;c>=level;c--))
		   do
			 printf "%${c}s";  echo "</${tmp[c]}>"
		   done
		   tag_closed=1
	    fi

		 # different key value, we destroy all key values > current
		 # if not, the tree will not display subkey with same key value
		 for ((j=key_depth;j>level;j--)); do tmp[$j]="";  done

      	 tmp[$level]=$k
		 printf "%${level}s"

		 # we build tags tree 
		 if [ $level -le $key_depth ]; then
		   echo "<$k>"
		 else
		   # that's the last tag
		   echo "<$k>$key_value</$k>"
		 fi
	  fi
	  # next key position
      let level=level+1

    done
	# we notify about ignored duplicate key
	if [ $dupkey -eq 1 ]; then
	  echo "the key '$key_tree' for value '$key_value' as been ignored, because same as previous line" >&2
    fi

	# we store level depth progression
	let old_kd=key_depth
  done

	# closing remaining opened tag to root level
   for ((c=key_depth;c>=first_level;c--))
   do
	 printf "%${c}s";  echo "</${tmp[c]}>"
   done
}

