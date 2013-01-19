class Settings < ActiveRecord::Base
  KEYS = %w[capability consecutive roulette default open_hour close_hour ]

  attr_accessible :data
  serialize       :data

  def self.data
    @data ||= last.data
  end

  KEYS.each do |name|
    define_singleton_method name do
      data[name.to_sym]
    end
  end
end
