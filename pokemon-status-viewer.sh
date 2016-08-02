#!/bin/bash

data="pokemon.json"
user="a.json"

PYTHONPATH=$PWD/pgoapi ./get-inventory.py $@ > $user
if [ $? -ne 0 ]; then
    exit $?
fi

US=`jq '.responses.GET_PLAYER.player_data.currencies[] | select(.name | contains("STARDUST")) | .amount' $user`

PM_CLAUSE='.responses.GET_INVENTORY.inventory_delta.inventory_items[].inventory_item_data.pokemon_data | select(. != null) | select (.is_egg != true)'

count=`jq "$PM_CLAUSE | .id" $user | wc -l`

for ((i=0; i<$count;i++)); do 

    SINGLE_PM_CLAUSE="[$PM_CLAUSE] | .[$i]"

    # Extract directly from user file
    Id=`jq "$SINGLE_PM_CLAUSE | .pokemon_id" $user`
    Weight=`jq "$SINGLE_PM_CLAUSE | .weight_kg" $user`
    Height=`jq "$SINGLE_PM_CLAUSE | .height_m" $user`
    HP=`jq "$SINGLE_PM_CLAUSE | .stamina" $user`
    MaxHP=`jq "$SINGLE_PM_CLAUSE | .stamina_max" $user`
    CP=`jq "$SINGLE_PM_CLAUSE | .cp" $user`
    Favorite="☆"
    if [ "`jq "$SINGLE_PM_CLAUSE | .favorite" $user`" = "1" ]; then
        Favorite="★"
    fi

    # Needs lookup from static data file
    _id=$((Id-1))
    Name=`jq -r ".[$_id].Name" $data`
    TypeI=`jq -r ".[$_id].\"Type I\" | .[0]" $data`
    TypeII=`jq -r ".[$_id].\"Type II\" | .[0]" $data`
    if [ $TypeII = "null" ]; then
        Type="    $TypeI"
    else
        Type="$TypeI / $TypeII"
    fi
    UC="3"
    S="1000"
    C="1"

    # Formatted printout with pictures
    printf "\n"
    printf "                           CP %-4d                          %s\n" $CP $Favorite
    img2txt -f utf8 -d fstein data/$Id.png
    printf "                         %-12s                         \n" "$Name"
    printf "                         %4d/%-4d                         \n" "$HP" "$MaxHP"
    printf "\n"
    printf " %15s | Weight % 8.2f kg | Height % 8.2f m\n" "$Type" "$Weight" "$Height"
    printf -- "-------------------------------------------------------------\n"
    printf "            Stardust                         Candy           \n"
    printf "            (S) %-7d                      (C) %-5d             \n" "$US" "$UC"
    printf "\n"
    printf " +---------------------+                                     \n"
    printf " |                     |                                     \n"
    printf " |      POWER UP       |       (S) %-4d      (C) %-4d \n" "$S" "$C"
    printf " |                     |                                     \n"
    printf " +---------------------+                                     \n"

    echo "Press ENTER to continue ..."
    read a
    if [ "$a" = 'q' ]; then
        exit
    fi

done
