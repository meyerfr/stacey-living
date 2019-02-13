class Users::InvitationsController < Devise::InvitationsController
  # def create
  #   self.resource = invite_resource
  #   resource_invited = resource.errors.empty?

  #   yield resource if block_given?
  #   raise
  #   if resource_invited
  #     if is_flashing_format? && self.resource.invitation_sent_at
  #       set_flash_message :notice, :send_instructions, :email => self.resource.email
  #     end
  #     if self.method(:after_invite_path_for).arity == 1
  #       respond_with resource, :location => after_invite_path_for(current_inviter)
  #     else
  #       respond_with resource, :location => after_invite_path_for(current_inviter, resource)
  #     end
  #   else
  #     respond_with_navigational(resource) { render :new }
  #   end
  # end
  # def create
  #   applicant = Applicant.find(params[:applicant])
  #   User.invite!({ email: applicant.email, first_name: applicant.first_name, last_name: applicant.last_name })
  # end
  # def create
  #   self.resource = invite_resource
  #   resource_invited = resource.errors.empty?

  #   yield resource if block_given?

  #   if resource_invited
  #     if is_flashing_format? && self.resource.invitation_sent_at
  #       set_flash_message :notice, :send_instructions, :email => self.resource.email
  #     end
  #     if self.method(:after_invite_path_for).arity == 1
  #       respond_with resource, :location => after_invite_path_for(current_inviter)
  #     else
  #       respond_with resource, :location => after_invite_path_for(current_inviter, resource)
  #     end
  #   else
  #     respond_with_navigational(resource) { render :new }
  #   end
  # end

  # private

  # this is called when creating invitation
  # should return an instance of resource class
  # def invite_resource
  #   applicant = Applicant.find(params[:applicant])
  #   resource_class.invite!(applicant, current_inviter)
  # end

  # this is called when accepting invitation
  # should return an instance of resource class
  # def accept_resource
  #   resource = resource_class.accept_invitation!(update_resource_params)
  #   ## Report accepting invitation to analytics
  #   Analytics.report('invite.accept', resource.id)
  #   resource
  # end

   protected

  # def invite_resource(&block)
  #   resource_class.invite!(invite_params, current_inviter, &block)
  # end

  # def accept_resource
  #   resource_class.accept_invitation!(update_resource_params)
  # end

  # def current_inviter
  #   authenticate_inviter!
  # end

  # def has_invitations_left?
  #   unless current_inviter.nil? || current_inviter.has_invitations_left?
  #     self.resource = resource_class.new
  #     set_flash_message :alert, :no_invitations_remaining if is_flashing_format?
  #     respond_with_navigational(resource) { render :new }
  #   end
  # end

  # def resource_from_invitation_token
  #   unless params[:invitation_token] && self.resource = resource_class.find_by_invitation_token(params[:invitation_token], true)
  #     set_flash_message(:alert, :invitation_token_invalid) if is_flashing_format?
  #     redirect_to after_sign_out_path_for(resource_name)
  #   end
  # end

  def invite_params
    applicant = Applicant.find(params[:applicant])
    { email: applicant.email }
  end

  # def update_resource_params
  #   devise_parameter_sanitizer.sanitize(:accept_invitation)
  # end

  # def translation_scope
  #   'devise.invitations'
  # end
end
