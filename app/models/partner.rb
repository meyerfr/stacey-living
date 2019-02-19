class Partner < ApplicationRecord
  validate :name, :company, :email, :phone_code, :phone
end
