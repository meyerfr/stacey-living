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
      Applicant.find_by(email: invite_params[:email]).update(invited: true)
    else
      respond_with_navigational(resource) { render :new }
    end
  end

  def after_invite_path_for(resource)
    applicants_path
  end

  protected

  def invite_params
    applicant = Applicant.find(params[:applicant])
    phone = "#{applicant.phone_code} #{applicant.phone}"
    { email: applicant.email,
      first_name: applicant.first_name,
      last_name: applicant.last_name,
      phone: phone,
      job: applicant.job,
      move_in_date: applicant.move_in_date,
      date_of_birth: applicant.date_of_birth,
      duration_of_stay: applicant.duration_of_stay,
      amount_of_people: applicant.amount_of_people,
      linked_in: applicant.linked_in }
  end
end
