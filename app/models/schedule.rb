class Schedule < ActiveRecord::Base
  validates :schedule, presence: true

  belongs_to :user
end