# githook-hashtag
manage hashtags in gitea database.

githook-hashtag.conf  githook-hashtag-deploy.sh  install.sh  README.md  test.sh  update
The following files are part of the application
- githook-hashtag-deploy.sh - Read all ubn repository names from database then copy "update" to their respective server side hooks directory. This script could be made a cron job to keep repos synced. This is expected to be run by cron
- githook-hashtag.conf      - Server config values. These are changed when server environment changes.
- install.sh                - This script is run once to put config file in /etc
- README.md                 - This file
- test.sh                   - Run update by hand on a single repo
- update                    - Upon a push to a ubn repository, remove all its hashtags and regenerate them by parsing all .md files. This is started by gitea. Its name cannot change.

# Normal Operation

sh install.sh
sh githook-hashtag-deploy.sh

push a ubn repo to git
  or
sh test.sh


-
