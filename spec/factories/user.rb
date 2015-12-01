FactoryGirl.define do
  factory :user do
    transient do
      skip_confirmation true
    end
    email "helena.wu87@gmail.com"
    password "helloworld"
    password_confirmation "helloworld"
    confirmed_at Time.now

    before(:create) do |user, evaluator| 
      user.skip_confirmation! if evaluator.skip_confirmation
    end
  end
end
