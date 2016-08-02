#!/bin/bash

function xmlext() {
    python -c 'import lxml.etree;from sys import stdin,argv;print "\n".join(lxml.etree.HTML(stdin.read()).xpath(argv[1]))' "$1"
}

mkdir data
cd data

# Image URLs 
# Raw url is like /sites/default/files/styles/pokemon_small/public/2016-07/151.png?itok=svLOdfoN
curl -Ls http://pokemongo.gamepress.gg/pokemon-list |
xmlext "//img[@class='image-style-pokemon-small']/@src" |
cut -d? -f1 | sed 's@^@http://pokemongo.gamepress.gg@' |
wget -nv -i -

# Fix filenames (some filename has _0 in filename)
for i in *_0.png; do 
    mv $i ${i%_0.png}.png
done


