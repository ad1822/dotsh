#!/bin/bash

hyprdots=$HOME/SideProjects/Scripts/syncdots.sh

echo "===> Syncing Hyprdots"
bash $hyprdots

repo=$HOME/SideProjects/Scripts/pushDots.sh

echo "===> Pushing to Github"
bash $repo

cloud=$HOME/SideProjects/Scripts/rsync.sh

echo "===> Syncing Clouds"
bash $cloud