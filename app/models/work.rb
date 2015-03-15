class Work < ActiveRecord::Base
  # belongs_to :staff
  #validates :date,presence: true
  #validates :start,presence: true
  #validates :end,presence: true
  #validates :break,presence: true
  validates :staff,presence: true

end
