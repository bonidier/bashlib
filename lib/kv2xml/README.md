# description #

this library convert key value input file or variable to XML

# input line format #
key_with_separator=value

# variables to set
 _KV2XML_SEP_PATH  # separator between key'tree and value
 _KV2XML_SEP_KV    # separator betwenn key and value

# usage #

you should call kv2xml over a pipe, no argument required


echo $string | kv2xml

your_script | kv2xml

kv2xml < input-file



