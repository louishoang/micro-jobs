class TextMessagesController < ApplicationController
  def new
  end

  def create
    receiver = User.find(params[:user_id])
    sender = current_user

    body = text_message_params[:text]
    body = body + "\n\nYou've been messsaged by #{sender.user_name}."

    TextMessage.new(receiver.phone_number, body).send

    redirect_to :back
  end

  def text_message_params
    params.require(:text_message).permit(:text)
  end
end
