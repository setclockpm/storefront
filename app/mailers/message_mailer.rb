class MessageMailer < ActionMailer::Base

  default to: "Porthos Home \<info@porthoshome.com\>"

  def new_message(message)
    @message     = message
    reply_to_address = "#{message.name} \<#{message.email}\>"
    
    mail subject: "Message from #{message.name}", from: "worker@porthoshomeapplication.com", reply_to: reply_to_address, cc: "phsia@porthoshome.com"
  end
  
  def inventory_sync_report(skus_to_look_into)
    @skus = skus_to_look_into
    reply_to_address = "Porthos Server (Do Not Reply) \<donotreply@porthoshome.com\>"
    
    mail subject: "SKU Possibly Requiring Attention", from: "worker@porthoshomeapplication.com", reply_to: reply_to_address, to: "phsia87@gmail.com"
  end

end
