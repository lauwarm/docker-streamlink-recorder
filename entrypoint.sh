#!/bin/sh

# Add local user and group
# Either use the uid and gid if passed in at runtime or
# fallback to 9001

USER_ID=${uid:-9001}
GROUP_ID=${gid:-9001}

addgroup --gid $GROUP_ID mygroup
adduser --disabled-password myuser --uid $USER_ID --gecos myuser --ingroup mygroup --shell /bin/sh

echo "UID : $USER_ID \nGID : $GROUP_ID"
#useradd --shell /bin/bash -u $USER_ID -o -c "" -m user
#export HOME=/home/user

chown -R myuser:mygroup /home/plugins
chown -R myuser:mygroup /home/script

exec gosu myuser "$@"