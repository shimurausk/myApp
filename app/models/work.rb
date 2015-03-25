class Work < ActiveRecord::Base
  belongs_to :staff
  #validates :date,presence: true
  #validates :start, :presence => {:message => '開始時間を選択してください'}
  #validates :end, :presence => {:message => '終了時間を選択してください'}
  #validates :break,presence: true
  validates :staff_id,presence: true

end
