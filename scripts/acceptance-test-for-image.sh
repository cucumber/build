set -e
# 
# Runs some commands within the build image to validate basic expecations about what should be working.
# 

which go || (echo "command 'go' not found" && exit 1)
which dart || (echo "command 'dart' not found" && exit 1)
printf "source 'https://rubygems.org'\ngem 'rake'\n" > Gemfile && bundle install && rm -rf Gemfile*