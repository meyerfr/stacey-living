module UsersHelper
  def all_admins
    User.where(role: 'admin')
  end

  def all_applicants
    User.where(role: 'applicant')
  end

  def all_tenants
    User.where(role: 'tenant')
  end
end
