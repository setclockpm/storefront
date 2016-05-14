require 'thor'
require 'datashift'
require 'datashift_spree'


DataShift::load_commands
DataShift::SpreeEcom::load_commands

#@load_object.variants.each_with_index {|v, i| v.update_attributes(sku: values[i].to_f) }
#@load_object.variants.each_with_index {|v, i| v.price = values[i].to_f }