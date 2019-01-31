class Users::InvitationsController < Devise::InvitationsController

  def accept
    new_user = User.find_by_invitation_token(params[:invitation_token], true)
    User.accept_invitation!(invitation_token: params[:invitation_token], password: params[:password], first_name: new_user.first_name, last_name: new_user.last_name)
  end
end
