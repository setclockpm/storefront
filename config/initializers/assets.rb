# Directory for inventory pictures ready to be bulk imported.
# Can be a local dir to an s3 bucket.

dirs = { 
  'production'  => 'https://s3-ap-southeast-1.amazonaws.com/porthos/',
  'staging'     => '/var/www/porthos/production/shared/tmp/images',
  'development' => '/Users/pmedrano/Dropbox/porthos-inventory-images/backup'
}

RAW_ASSET_DIRECTORY = dirs[Rails.env]