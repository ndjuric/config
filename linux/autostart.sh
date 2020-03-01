#!/bin/bash
for line in `xrandr | grep "connected primary 3840x2160"`; do
	`echo $line | cut -f 1 -d ' '`
done
