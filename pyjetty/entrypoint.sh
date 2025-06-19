#!/usr/bin/bash

. /etc/profile.d/z00_lmod.sh
module use /opt/pyjetty/modules/
module load pyjetty

# Run the main container command
echo "Command to be run: $*"
bash -c "$*"