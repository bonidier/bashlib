# Introduction

this lib is a bundle a functions to simulate associative array, useful on older bash release

(tested under Bash >=3.2)

# using the library

**define your keys and an uniq numeric value**
```
keyX=123
keyY=456
keyZ=789

array_mapset keyX keyY keyZ
```

**add a value for your keys**

```
array_add myarray keyX "value for keyX"
array_add myarray keyY "value for keyY in myarray1"
array_add myarray keyZ "valueZ for keyZ"

array_add myarray2 keyY "valueY for keyY in myarray2"
```

**acces to your array key's value**

```
array_get myarray keyX
```

# other features

**show all your keys**

```
array_mapget
```

**show your filled arrays**

```
array_dump myarray
array_dump myarray2
```

# Debug

if variable ARRAY_DEBUG defined to 1,
display verbose output for array_add/array_get functions
