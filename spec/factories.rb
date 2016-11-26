FactoryGirl.define do

  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(10, 20) }
    after(:build) do |u|
      u.password_confirmation = u.password
      #u.roles = [create(:user_role)]
    end
  end

  factory :admin do
    email { Faker::Internet.email }
    name  { Faker::Name.name }
    password { Faker::Internet.password(10, 20) }
    approved true
    office
    after(:build) do |u|
      u.password_confirmation = u.password
      #u.roles = [create(:user_role)]

    end
  end

  factory :fishery do
    sequence(:name) { |n| "Fishery#{n}" }
    sequence(:code) { |n| "A#{n}"}
  end

  factory :office do
    sequence(:name) { |n| "Office#{n}" }
  end

  factory :company do
    sequence(:name) { |n| "Company#{n}" }
  end

  factory :port do
    sequence(:name) { |n| "Port#{n}" }
  end

  factory :wpp do
    sequence(:name) { |n| "WPP#{n}" }
  end

  factory :vessel do
    sequence(:ap2hi_ref) { |n| "Vessel#{n}" }
  end

  factory :unloading do
    vessel
    port
    wpp
  end

  factory :unloading_catch do
    fish
    unloading
    quantity {rand(1..999)}
  end

  factory :bait_loading do
    vessel
    bait
    quantity {rand(1..999)}
  end

  factory :bait do
    sequence(:name) { |n| "Bait#{n}" }
    sequence(:code) { |n| "B#{n}" }
  end

  factory :fish do
    sequence(:scientific_name) { |n| "Fish#{n}" }
    sequence(:english_name) { |n| "Fish#{n}" }
    sequence(:order) { |n| "Fish#{n}" }
    sequence(:family) { |n| "Fish#{n}" }
    sequence(:code) { |n| "F#{n}" }
  end

  factory :document do
    file { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'test_image.jpg')) }
    association :documentable, factory: :vessel
  end

end
