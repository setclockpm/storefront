#!/bin/sh
source $HOME/.bashrc

echo "Starting google sync rake tasks at" `date` "as" `whoami`
cd /var/www/porthos/production/current
RAILS_ENV=production
export RAILS_ENV
echo " ... SellerCloud sync starting (" `date` ")"
/home/deploy/.rbenv/shims/bundle exec rake seller_cloud:inventory:sync --trace
echo " ... SellerCloud sync complete"
echo "Completed SellerCloud sync rake tasks at" `date` "as" `whoami`