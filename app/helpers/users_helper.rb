module UsersHelper
  def all_admins
    User.select{ |u| u.has_role?('admin') }
  end

  def all_applicants
    User.select{ |u| u.has_role?('applicant') }
  end

  def all_tenants
    User.select{ |u| u.has_role?('tenant') }
  end
end
