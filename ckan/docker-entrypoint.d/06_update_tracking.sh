#!/bin/bash

# Summarise the raw tracking data and update the search index, so views and
# "popular" sorting are up to date. Runs once at start-up, then every interval.
if [[ $CKAN__PLUGINS == *"tracking"* ]]; then
   echo "Starting the tracking update loop"
   (
      while true; do
         ckan -c $CKAN_INI tracking update || echo "Tracking update failed"
         sleep "${CKAN_TRACKING_UPDATE_INTERVAL:-86400}"
      done
   ) &
else
   echo "Not updating tracking data"
fi
