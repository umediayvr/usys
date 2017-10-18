#!/bin/bash

# getting current script folder
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# fonts that should be loaded to the x session
dpi75="$dir/data/fonts/75dpi"
dpi100="$dir/data/fonts/100dpi"

# adding fonts fonts
xset +fp "$dpi75"
xset +fp "$dpi100"

# refreshing fonts
xset fp rehash
