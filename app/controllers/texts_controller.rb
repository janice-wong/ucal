class TextsController < ApplicationController
skip_before_action :verify_authenticity_token

  def process_sms
    response = Twilio::TwiML::Response.new do |r|
      r.Message "yassssssss"
    end
    render :xml => response.to_xml
  end
end
