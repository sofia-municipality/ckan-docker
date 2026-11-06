#!/bin/bash

# Send the activity email digests (ckan.activity_streams_email_notifications)
# periodically, next to the web app. Needs the activity plugin and SMTP settings.
if [[ $CKAN__PLUGINS == *"activity"* ]] && [[ "${CKAN__ACTIVITY_STREAMS_EMAIL_NOTIFICATIONS,,}" == "true" ]]; then
   echo "Starting the activity email notifications loop"
   (
      while true; do
         sleep "${CKAN_EMAIL_NOTIFICATIONS_INTERVAL:-3600}"
         ckan -c $CKAN_INI notify send_emails || echo "Sending email notifications failed"
      done
   ) &
else
   echo "Not sending activity email notifications"
fi
