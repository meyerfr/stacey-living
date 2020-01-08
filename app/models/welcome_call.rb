class WelcomeCall < ApplicationRecord
  belongs_to :booking, optional: true
end
