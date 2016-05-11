require 'thor'
require 'datashift'
require 'datashift_spree'


DataShift::load_commands
DataShift::SpreeHelper::load_commands