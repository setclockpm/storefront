class MessageMailer < ActionMailer::Base

  default to: "Porthos Home <phsia@porthoshome.com>"

  def new_message(message)
    @message = message
    
    mail subject: "Message from #{message.name}", from: message.email, reply_to: message.email
  end

end