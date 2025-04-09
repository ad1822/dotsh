#!/bin/bash

hyprdots=$HOME/SideProjects/Scripts/sync/syncdots.sh

echo "===> Syncing Hyprdots"
bash $hyprdots

repo=$HOME/SideProjects/Scripts/sync/pushDots.sh

echo "===> Pushing to Github"
bash $repo

cloud=$HOME/SideProjects/Scripts/sync/rsync.sh

echo "===> Syncing Clouds"
bash $cloud