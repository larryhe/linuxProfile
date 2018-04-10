#!/bin/bash
find . -path ./dist -prune -name '*.jpg' -o -name '*.png' -o -name '*.gif' -o -name '*.svg' -o -name '*.jpeg' > ~/tmp/images.txt
