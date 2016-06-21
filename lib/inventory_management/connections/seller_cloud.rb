require 'savon'

module InventoryManagement
  module Connections
    
    def self.establish(endpoint_params)
      return false unless endpoint_params[:api]
      connection_to = endpoint_params[:api]
      connection_to.to_s.camelize.send(:connect)
    end
    
    
    
    
    class SellerCloud
      SELLER_CLOUD_ENDPT = 'http://ek.ws.sellercloud.com/scservice.asmx?WSDL'
      AUTH_HEADER = %{<api:AuthHeader><api:UserName>#{ENV['SELLER_CLOUD_ID']}</api:UserName><api:Password>#{ENV['SELLER_CLOUD_PW']}</api:Password></api:AuthHeader>}
      
      
      def self.connection
        @seller_cloud_connection = SellerCloud.new
      end
      
      
      def initialize
        @sc_client = Savon.client(env_namespace: :soap, 
                                  namespaces: { "xmlns:api" => "http://api.sellercloud.com/" }, 
                                  pretty_print_xml: true, 
                                  soap_version:2,
                                  wsdl: SELLER_CLOUD_ENDPT)
      end
      
      def get_available_qty(sku)
        begin
          response = @sc_client.call(:get_inventory_available_qty, message: { 'ProductID' => sku }, soap_header: AUTH_HEADER)
        rescue Exception => e
          puts "There was a problem getting information for this sku: #{e.message}"
        end
        
        # Life goals
        if response and response.successful?
          # Actual numeric qty buried in hash
          return response.to_hash[:get_inventory_available_qty_response][:get_inventory_available_qty_result].to_i
        else
          report_unsuccessful_response(response, sku)
        end
      end
      
      
      private
        def report_unsuccessful_response(r, sku)
          puts "Unsuccessful response given by endpoint: #{r.to_hash} - arg: #{sku}"
        end
      end
  end
  
end
