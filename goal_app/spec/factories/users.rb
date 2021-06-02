FactoryBot.define do
  factory :user do
    email {Faker::Internet.email}
    password_digest {SecureRandom::urlsafe_base64}
    session_token {SecureRandom::urlsafe_base64}
    password {"password1"}

    factory :short_password do
      password {"cat"}
    end

  end
end
