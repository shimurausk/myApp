class Reservation < ActiveRecord::Base
	validates :name, :presence => {:message => '名前を入力してください'}
	VALID_EMAIL_REGEX =  /\A[^@]+@.+\..+\z/i
	validates :email, :presence => {:message => 'メールアドレスを入力してください'},
	 format: { with: VALID_EMAIL_REGEX ,:message => 'メールアドレスをご確認ください'}
	validates :time, :presence => {:message => '利用時間を選択してください'}
	validates :member, :presence => {:message => '人数を選択してください'}
	validates :content, :presence => {:message => 'プランを入力してください'}
	#validates :time,presence: true
end
