class MessageMailer < ActionMailer::Base

  default from: "Porthos Home <noreply@porthoshome.com>"
  default to: "Porthos Home <phsia@porthoshome.com>"

  def new_message(message)
    @message = message
    
    mail subject: "Message from #{message.name}"
  end

end