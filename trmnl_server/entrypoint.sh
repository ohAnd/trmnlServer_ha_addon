#!/bin/sh
set -e

SHARED_FOLDER="/app/addon_config"
CONFIG_FOLDER="/app"

CONFIG_FILE="$CONFIG_FOLDER/config.yaml"
CONFIG_FILE_SHARED="$SHARED_FOLDER/config.yaml"
CONFIG_FILE_HA="/data/options.json"

# LOAD_PROFILE="$CONFIG_FOLDER/load_profile.csv"
# LOAD_PROFILE_DEFAULT="$CONFIG_FOLDER/load_profile_default.csv"
# LOAD_PROFILE_SHARED="$SHARED_FOLDER/load_profile.csv"

# LOG_FILE="/data/batcontrol.log"

# use custom config file, if available
if test -e $CONFIG_FILE_SHARED ; then
  echo "Using Config file found in addon config folder."
  ln -sf $CONFIG_FILE_SHARED $CONFIG_FILE
else
  echo "Config file tmrnlServer_config.yaml not found in addon config folder. Proceeding with data from HA Addon configuration"
  ln -sf $CONFIG_FILE_HA $CONFIG_FILE
fi

# Check if logfile exists. If not create an empty log file.
# if test ! -e $LOG_FILE ; then
#   echo "Creating log file at $LOG_FILE"
#   touch $LOG_FILE
# fi
# Create a symlink to /app/log/batcontrol.log
# ln -sf $LOG_FILE /app/logs/batcontrol.log

# Start batcontrol.py
exec python trmnl_server.py /app/addon_config
