#!/bin/bash

# Important for logging stack traces.
exec 2>&1

source /etc/mbs_constants.sh

cd $MBS_ROOT

export HOME=$MBS_HOME
export MUSICBRAINZ_USE_PROXY=1

exec chpst -u musicbrainz:musicbrainz \
    carton exec -- \
        start_server --port 5000 -- \
            plackup \
                -Ilib \
                --server Starlet \
                --env deployment \
                --max-workers ${STARLET_MAX_WORKERS:-10} \
                --min-reqs-per-child 30 \
                --max-reqs-per-child 90 \
                app.psgi
