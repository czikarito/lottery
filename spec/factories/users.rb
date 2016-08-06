FactoryGirl.define do
  factory :user do
    email { FFaker::Internet.email }
    password 'qwerty99'
    password_confirmation 'qwerty99'

    factory :admin do
      after(:create) { |user| user.add_role :admin }
    end
  end
end
