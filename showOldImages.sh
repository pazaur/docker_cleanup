#!/bin/bash

#author: Pawel Zarzycki.
#
#Script is showing images that are older than current one. As an argument it possible to specify how many of images are treated like "current".
#For example: if there are images with tags 1.0.1 (oldest), 1.0.2, 1.0.3 (newest) . If you pass argument 1 the script will show 1.0.1 and 1.0.2 .
#If argument = 2 them the script will show only 1.0.1 .

cli_args=("$@")

#How many images should be ignored as "current" ones.

cur_images=${cli_args[0]}

if [ $cur_images -eq 0 ]
	then
	cur_images=1
fi

# loop through stored images.
for img_id in $( docker images --format "{{.ID}}:{{.Repository}}" | grep -v REPOSITORY); do
 	image_rep=$(echo $img_id | cut -d":" -f2);
	image_id=$(echo $img_id | cut -d":" -f1);
    for img in $( docker images --format "{{.ID}}:{{.Repository}}:{{.Tag}}" --filter before=$(docker images | grep $image_id | awk '{print $3}' | uniq) | grep $image_rep | head -$cur_images); do
		echo $img;
	done;
done | sort -t ":" -k 2;
