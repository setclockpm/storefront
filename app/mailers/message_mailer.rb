class MessageMailer < ActionMailer::Base

  default to: "Porthos Home \<info@porthoshome.com\>"

  def new_message(message)
    @message     = message
    reply_to_address = "#{message.name} \<#{message.email}\>"
    
    mail subject: "Message from #{message.name}", from: "worker@porthoshomeapplication.com", reply_to: reply_to_address, cc: "phsia@porthoshome.com"
  end

end
