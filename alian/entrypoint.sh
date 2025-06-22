#!/usr/bin/bash

. /etc/profile.d/z00_lmod.sh
module use /opt/yasp/software/modules
module load yasp heppyy alian

# Run the main container command
echo "Command to be run: $*"
bash -c "$*"