class Credit < ActiveRecord::Base
  belongs_to :user
  attr_accessible :used, :user_id

  validates_presence_of :user_id

  scope :used,   where(:used => true)
  scope :unused, where(:used => false)

  def use
    update_column :used, true
  end
end
