# singleton-like class with activerecord cause on heroku there is no way to
# have settings on the filesystem and edit them. Looks like a hack but works

class Settings < ActiveRecord::Base
  KEYS = %w[capability consecutive roulette default open_hour close_hour ]

  attr_accessible :data
  serialize       :data

  def self.instance
    last
  end

  def self.data
    @data ||= instance.data
  end

  KEYS.each do |name|
    define_singleton_method name do
      data[name]
    end
  end
end
