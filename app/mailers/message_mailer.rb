class MessageMailer < ActionMailer::Base

  default to: "Porthos Home <sixpointmavslead@yahoo.com>"

  def new_message(message)
    @message = message
    
    mail subject: "Message from #{message.name}", from: message.email, reply_to: message.email
  end

end