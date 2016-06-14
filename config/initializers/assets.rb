# Directory for inventory pictures ready to be bulk imported.
# Can be a local dir to an s3 bucket.
BUCKET_PREFIX = Rails.env == 'production' ? 'public/assets/' : ''

dirs = { 
  'production'  => 'https://s3-ap-southeast-1.amazonaws.com/porthos/',
  'staging'     => '/var/www/porthos/production/shared/tmp/images',
  'development' => '/Users/pmedrano/Dropbox/porthos-inventory-images/temp'
}

RAW_ASSET_DIRECTORY = dirs[Rails.env]