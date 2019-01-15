FactoryBot.define do
  factory :idea do
    association(:user, factory: :user)

    title { Faker::Job.title }
    description { Faker::Job.field }
  end
end
