#!/bin/bash

hyprdots=$HOME/SideProjects/Scripts/syncdots.sh

echo "===> Syncing Hyprdots"
bash $hyprdots

cloud=$HOME/SideProjects/Scripts/rsync.sh

echo "===> Syncing Clouds"
bash $cloud