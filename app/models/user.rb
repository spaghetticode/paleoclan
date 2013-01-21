class User < ActiveRecord::Base
  has_many :bets
  has_many :slots

  devise :omniauthable
  attr_accessor :password
  attr_accessible :email, :password, :password_confirmation, :remember_me, :provider, :uid, :name, :provider

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

  def banned?
    self[:banned] and ban_count > 0
  end

  def ban
    self.banned = true
    self.ban_count += 1
    save
  end

  def unban
    if ban_count < Settings.max_ban
      update_column :banned, false
    else
      false
    end
  end

  def bet?(day)
    day.bets.where(:user_id => id).present?
  end

  def can_book?(day)
    !cant_book?(day)
  end

  def cant_book?(day)
    return true if banned?
    return false if test_days.size < Settings.consecutive
    res = false
    test_days.each_with_index do |day, i|
      res = true if day.next_available == test_days[i+1]
    end
    if res
      res = false if test_days.last.next_available != day
    end
    res
  end

  private

  def test_days
    slots.limit(Settings.consecutive).map(&:day).reverse
  end
end
