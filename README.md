# Pokemon Go status viewer
## written in bash
This is a stub program written for "Shell Competition" in our Lab Camp in 2016.
The program use pgoapi to fetch user and inventory data and output in json format, then process it with jq, finally output in format.
Additionally, img2txt is used to generate ascii art.

## Dependencies
* pgoapi (Shipped by submodule) with its own dependencies
* python-lxml
* jq version > 1.5
* img2txt (A part of libcaca)

## Install
    git clone http://github.com/Tydus/pmgo-status-viewer.sh
    cd pmgo-status-viewer.sh
    git submodule update --init --recursive
    cd pgoapi
    python setup.py install
    cd ..

## Usage
    ./pokemon-status-viewer.sh -a google -u yourname@gmail.com [-p T0p$EcRE7] -l Sapporo

## Screenshot
    ![CLI](/screenshots/2.jpg?raw=true)
    ![Original](/screenshots/1.jpg?raw=true)

## TODO
* Calculate dummy variables(Powerup cost, etc.)
* Try to draw the arc
* 256-color term support

## Acknowledgement
Specially thanks to https://github.com/tejado/ for his outstanding contributions on the project [pgoapi](https://github.com/tejado/pgoapi/).
Also thanks to all the pioneers for tools / libraies / data for us to easily explore the game further.
Yet WITHOUT any authors and users of *CHEATING / FARMING* tools.
*THEY SHOULD GO TO THE HELL!*
