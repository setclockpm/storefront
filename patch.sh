#!/bin/sh

# Most of the time the path is as follows:
# scp path/to/file/to/be/patched/file.ext deploy@$IP_ADDRESS_OF_SERVER:/var/www/$APPLICATION/$ENVIRONMENT/current/path/to/file/to/be/patched/
# ssh key must be configured properly for this to work
# echo $#; Number of passed in arguments
if [[ $1 == "/Users/"* || $1 == "~/"* ]]
then
  echo "Absolute path to file detected.";
  ABSPATH=$1;
  RELPATH=${ABSPATH#*/CERP/};
else
  RELPATH=$1
fi
echo "Patching ${RELPATH} to application root (current_path by Capistrano's turns): /var/www/porthos/production/current/${RELPATH}"
scp ${RELPATH} deploy@porthos:/var/www/porthos/production/current/${RELPATH}
echo "Restarting Production Server"
cap production deploy:restart
echo ". . . ."
echo "Patching complete"