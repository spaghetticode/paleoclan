# TODO there must be a better way to write this

FactoryGirl.define do
  factory :settings, :class => 'Settings' do
    data {
        {
        'capability'  => 3,
        'consecutive' => 2,
        'roulette'    => 5,
        'open_hour'   => 10,
        'close_hour'  => 12,
        'max_ban'     => 3,
        'default'     => ['Andrea Longhi']
      }
    }
  end
end
