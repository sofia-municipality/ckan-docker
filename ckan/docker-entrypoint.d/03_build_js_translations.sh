#!/bin/bash

# Build the translations CKAN sends to the browser (/api/i18n/<lang>), including
# those of extensions such as ckanext-sofia. Only the development server builds
# them by itself; without this, texts in CKAN's JavaScript (e.g. the table
# view's buttons) stay in English whatever the site's language.
echo "Building the JavaScript translations"
ckan -c $CKAN_INI translation js
