class TextMessage
  attr_reader :to_number, :body

  def initialize(to_number, body)
    @to_number = to_number
    @body = body
  end

  def send
    client.account.sms.messages.create(
      from: twilio_phone_number,
      to: to_number,
      body: body
    )
  end

  private

  def twilio_sid
    ENV['TWILIO_SID']
  end

  def twilio_token
    ENV['TWILIO_TOKEN']
  end

  def twilio_phone_number
    ENV['PHONE_NUMBER']
  end

  def client
    @client = Twilio::REST::Client.new(twilio_sid, twilio_token)
  end
end
