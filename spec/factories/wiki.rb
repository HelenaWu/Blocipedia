FactoryGirl.define do
  factory :wiki do
    subject "Some wiki title"
    level "public"
    body "MyText"
    user_id "1"
  end
end
