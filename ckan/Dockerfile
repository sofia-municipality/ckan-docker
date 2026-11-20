FROM ckan/ckan-base:2.11 AS base


USER root

# Install any extensions needed by your CKAN instance
# See Dockerfile.dev for more details and examples

### XLoader ###
RUN pip install -e 'git+https://github.com/ckan/ckanext-xloader.git@2.6.0#egg=ckanext-xloader'

### Geoview - map previews for GeoJSON resources (geojson_view) ###
RUN pip install -e 'git+https://github.com/ckan/ckanext-geoview.git@v0.3.1#egg=ckanext-geoview'

### Scheming - dataset and organisation schemas (ckan/schemas) ###
RUN pip install -e 'git+https://github.com/ckan/ckanext-scheming.git@release-3.1.0#egg=ckanext-scheming'
COPY --chown=ckan-sys:ckan-sys schemas ${APP_DIR}/schemas
### Pages - static pages and blog ("Актуално", news) ###
# Pinned to a master commit: v0.5.2 (latest release) fails on CKAN 2.11 and has no migrations
RUN pip install -e 'git+https://github.com/ckan/ckanext-pages.git@28eba99ad85d3b9037f5aaddad1f083300c69041#egg=ckanext-pages'

# Copy custom initialization scripts
COPY --chown=ckan-sys:ckan-sys docker-entrypoint.d/* /docker-entrypoint.d/

# Apply any patches needed to CKAN core or any of the built extensions (not the
# runtime mounted ones)
COPY --chown=ckan-sys:ckan-sys patches ${APP_DIR}/patches

USER ckan

RUN for d in $APP_DIR/patches/*; do \
        if [ -d $d ]; then \
            for f in `ls $d/*.patch | sort -g`; do \
                cd $SRC_DIR/`basename "$d"` && echo "$0: Applying patch $f to $SRC_DIR/`basename $d`"; patch -p1 < "$f" ; \
            done ; \
        fi ; \
    done


# Local development: ckanext-sofia from the checkout in ../src/ckanext-sofia
# (passed in as the "ckanext-sofia" build context by docker-compose.local.yml)
FROM base AS local

USER root
COPY --chown=ckan:ckan-sys --from=ckanext-sofia . ${SRC_DIR}/ckanext-sofia
RUN pip install --no-cache-dir -e ${SRC_DIR}/ckanext-sofia && \
    if [ -f ${SRC_DIR}/ckanext-sofia/requirements.txt ]; then \
        pip install --no-cache-dir -r ${SRC_DIR}/ckanext-sofia/requirements.txt; fi
USER ckan


# Production (default target): ckanext-sofia from GitHub
FROM base AS production

USER root
RUN pip install --no-cache-dir -e \
    git+https://github.com/sofia-municipality/ckanext-sofia.git@main#egg=ckanext-sofia
USER ckan
