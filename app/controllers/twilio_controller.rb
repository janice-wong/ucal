class TwilioController < ApplicationController
skip_before_action :verify_authenticity_token

  def process_group_response
    user = User.find_by(phone: params[:From])
    first_dash_index = params[:Body].index("-")
    group_name = params[:Body][0..first_dash_index - 2]
    decision = params[:Body][first_dash_index + 2].capitalize

    GroupInvitation.find_by(group_id: Group.find_by(name: group_name).id, user_id: user.id).update(decision: decision)
  end
end
