#!/bin/bash

# Run CKAN's background jobs (e.g. XLoader loading files into the DataStore)
# next to the web app, so they share its ckan.ini, secrets and XLoader token.
# Restarted if it exits; it stops together with the container.
echo "Starting the CKAN jobs worker"
(
   while true; do
      ckan -c $CKAN_INI jobs worker
      echo "CKAN jobs worker exited, restarting in 5 seconds"
      sleep 5
   done
) &
