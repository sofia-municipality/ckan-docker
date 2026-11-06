#!/bin/bash

# Create or upgrade the database tables of enabled plugins that ship
# migrations (e.g. ckanext-pages, ckanext-showcase). CKAN's start-up runs
# only "db init", which covers CKAN core.
echo "Applying pending plugin migrations"
ckan -c $CKAN_INI db pending-migrations --apply
