class Users::InvitationsController < Devise::InvitationsController
  def create
    self.resource = invite_resource
    resource_invited = resource.errors.empty?

    yield resource if block_given?
    if resource_invited
      if is_flashing_format? && self.resource.invitation_sent_at
        set_flash_message :notice, :send_instructions, :email => self.resource.email
      end
      if self.method(:after_invite_path_for).arity == 1
        respond_with resource, :location => after_invite_path_for(current_inviter)
      else
        respond_with resource, :location => after_invite_path_for(current_inviter, resource)
      end
    else
      respond_with_navigational(resource) { render :new }
    end
  end

  def update
    super
    User.find(resource.id).update(applicant: false)
  end

  def after_invite_path_for(resource)
    applicants_index_path
  end

  protected

  def invite_params
    user = User.find(params[:user])
    { email: user.email,
      first_name: user.first_name,
      last_name: user.last_name,
      phone: user.phone,
      phone_code: user.phone_code,
      job: user.job,
      move_in_date: user.move_in_date,
      date_of_birth: user.date_of_birth,
      duration_of_stay: user.duration_of_stay,
      amount_of_people: user.amount_of_people,
      linked_in: user.linked_in,
      facebook: user.facebook,
      twitter: user.twitter,
      instagram: user.instagram }
  end

  def invite_resource(&block)
    @user = User.find_by(email: invite_params[:email])
    # @user is an instance or nil
    if @user && @user.email != current_user.email
      # invite! instance method returns a Mail::Message instance
      @user.invite!(current_user)
      # return the user instance to match expected return type
      @user
    else
      # invite! class method returns invitable var, which is a User instance
      resource_class.invite!(invite_params, current_inviter, &block)
    end
  end
end
