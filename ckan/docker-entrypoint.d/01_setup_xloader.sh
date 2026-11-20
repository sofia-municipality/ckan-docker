#!/bin/bash

if [[ $CKAN__PLUGINS == *"xloader"* ]]; then
   # XLoader settings have been configured in the .env file
   # Set API token if necessary
   if [ -z "$CKANEXT__XLOADER__API_TOKEN" ] ; then
      echo "Set up ckanext.xloader.api_token in the CKAN config file"
      TOKEN=$(ckan -c $CKAN_INI user token add ${CKAN_SYSADMIN_NAME:-ckan_admin} xloader | tail -n 1 | tr -d '\t')
      # An empty token makes every later ckan command fail the config check,
      # including this one on the next start: keep the old value instead
      if [ -n "$TOKEN" ] && [[ "$TOKEN" != *" "* ]]; then
         ckan config-tool $CKAN_INI "ckanext.xloader.api_token=$TOKEN"
      else
         echo "Could not create the XLoader API token; ckanext.xloader.api_token left unchanged"
      fi
   fi
else
   echo "Not configuring XLoader"
fi
