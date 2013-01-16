class User < ActiveRecord::Base
  has_many :slots
  has_many :days, :through => :slots
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable
  # Setup accessible (or protected) attributes for your model
  attr_accessor :password
  attr_accessible :email, :password, :password_confirmation, :remember_me, :provider, :uid, :name, :provider
  # attr_accessible :title, :body

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    User.where(:provider => auth.provider, :uid => auth.uid).first || User.create(
      name:     auth.extra.raw_info.name,
      provider: auth.provider,
      uid:      auth.uid,
      email:    auth.info.email,
      password: Devise.friendly_token[0,20]
    )
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
