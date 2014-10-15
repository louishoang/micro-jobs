class TextMessagesController < ApplicationController
  def new
  end

  def create(body)
    TextMessage.new(params[:number_to_send_to], body).send
  end
end
