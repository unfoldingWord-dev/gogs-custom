manage hashtags in gitea database.

The following files are part of the application
# Test
- test.sh                   - run update by hand on a single repo
- tst

# Production
- githook-hashtag.conf      - server config values. These are changed when server environment changes.
- update                    - Upon a push to a ubn repository, remove all its hashtags and regenerate them by 
parsing all .md files. This is started by gitea. Its name cannot change.

# Normal Operation

push a UBN repo to git. UBN repos have -ubn or -ubn- as part of their name.
  or
sh test.sh

