class Reservation < ActiveRecord::Base
	validates :name, :presence => {:message => '名前を入力してください'}
	validates :email, :presence => {:message => 'メールアドレスを入力してください'}
	validates :time,presence: true
end
