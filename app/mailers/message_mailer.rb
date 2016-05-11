class MessageMailer < ActionMailer::Base

  default to: "Porthos Home Storefront \<development@porthoshome.com\>"

  def new_message(message)
    @message     = message
    from_address = "#{message.name} \<#{message.email}\>"
    
    mail subject: "Message from #{message.name}", from: from_address, reply_to: from_address, date: Time.zone.now
  end

end
