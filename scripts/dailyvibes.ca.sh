# Taken from https://github.com/KrauseFx/krausefx.com/blob/master/deploy.sh

# Exit if any subcommand fails.
set -e

echo "Starting deploy to https://dailyvibes.ca"

# Build the docs page locally
export JEKYLL_ENV="production"
bundle exec jekyll build

# Delete old directories (if any)
rm -rf "/tmp/dailyvibes.ca"
# Copy the generated website to the temporary directory
cp -R "_site/" "/tmp/dailyvibes.ca"

####################################
# Assuming we are on master branch #
####################################

echo "Switching back to gh-pages branch"
git checkout gh-pages
#####################
# no going back now #
#####################
rm -rf *
cp -R /tmp/dailyvibes.ca/* .

# We need a CNAME file for GitHub
echo "dailyvibes.ca" > "CNAME"

# Commit all the changes and push it to the remote
git add -A
git commit -m "Deployed with $(jekyll -v)"
############
# override #
############
git push origin gh-pages --force

echo "Cleaning up from tmp"
rm -rf "/tmp/dailyvibes.ca"

echo "Switching back to master branch"
git checkout master

# echo "Deployed successfully, check out https://dailyvibes.ca"
echo "Deployed successfully, check out https://getaclue.github.io/dailyvibes.ca"

exit 0