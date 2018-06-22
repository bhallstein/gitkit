# gitkit/install.sh
#
# usage:  bash install.sh              # will prompt user for bash profile path
#         bash install.sh ~/.profile   # install to the provided bash profile

set -e
cd $(dirname "$0")

echo '//////////////////////////////////////////'
echo '  ___  _  _    _    _  _   '
echo ' / __|(_)| |_ | |__(_)| |_ '
echo '| (_ || ||  _|| / /| ||  _|'
echo ' \___||_| \__||_\_\|_| \__|   0.1'
echo

if [ "$#" -eq 1 ]; then
  PROFILE_PATH=$1
else
  echo -n "Path to your bash profile [leave blank for ~/.profile]: "
  read PROFILE_PATH
  if [ -z "$PROFILE_PATH" ]; then PROFILE_PATH='~/.profile'; fi
fi

PROFILE_PATH=${PROFILE_PATH/\~/$HOME}


cp gitkit.sh ~/.profile--gitkit.sh
sed -i -E 's/.*gitkit.*//' $PROFILE_PATH
echo                           >> $PROFILE_PATH
echo "# gitkit"                >> $PROFILE_PATH
echo ". ~/.profile--gitkit.sh" >> $PROFILE_PATH

echo "- installed to ~/.profile--gitkit.sh"
echo "- invoked from $PROFILE_PATH"
echo "- start a new terminal session, then run 'gts' :)"
echo
echo '//////////////////////////////////////////'
