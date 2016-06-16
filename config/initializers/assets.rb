# Directory for inventory pictures ready to be bulk imported.
# Can be a local dir to an s3 bucket.
BUCKET_PREFIX = 'public/assets/'

dirs = { 
  'production'  => 'https://s3-ap-southeast-1.amazonaws.com/porthos/',
  'staging'     => '/var/www/porthos/production/shared/tmp/images',
  'development' => 'https://s3-ap-southeast-1.amazonaws.com/porthos/'
}

RAW_ASSET_DIRECTORY ="https://s3-ap-southeast-1.amazonaws.com/porthos/"