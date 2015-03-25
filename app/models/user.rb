class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #attr_accessor :login
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable
         #, :authentication_keys => [:login]

  # def self.find_first_by_auth_conditions(warden_conditions)
  #   conditions = warden_conditions.dup
  #   if login = conditions.delete(:login)
  #     where(conditions).where(["username = :value OR lower(email) = lower(:value)", { :value => login }]).first
  #   else
  #     where(conditions).first
  #   end
  # end

  validates :username, length: { maximum: 50 },:presence => {:message => 'ユーザ名を入力してください'}
  validates :email, :presence => {:message => 'メールアドレスを選択してください'}

  has_one :staff,dependent: :destroy
  has_and_belongs_to_many :roles
  def has_role?(name)
    self.roles.where(name: name).length > 0
  end
end
