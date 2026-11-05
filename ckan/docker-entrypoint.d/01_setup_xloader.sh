#!/bin/bash

if [[ $CKAN__PLUGINS == *"xloader"* ]]; then
   # XLoader settings have been configured in the .env file
   # Set API token if necessary
   if [ -z "$CKANEXT__XLOADER__API_TOKEN" ] ; then
      echo "Set up ckanext.xloader.api_token in the CKAN config file"
      ckan config-tool $CKAN_INI "ckanext.xloader.api_token=$(ckan -c $CKAN_INI user token add ${CKAN_SYSADMIN_NAME:-ckan_admin} xloader | tail -n 1 | tr -d '\t')"
   fi
else
   echo "Not configuring XLoader"
fi
