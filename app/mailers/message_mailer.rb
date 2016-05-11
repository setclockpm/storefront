class MessageMailer < ActionMailer::Base

  default to: "development@porthoshome.com"

  def new_message(message)
    @message = message
    
    mail subject: "Message from #{message.name}", from: "#{message.name} \<#{message.email}\>", reply_to: "noreply@porthoshomestorefront.com"
  end

end