FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :micropost do
    content "Lorem ipsum"
    user
  end
end

#FactoryGirl.define do
  #factory :user do
    #name     "Ugur Unturk"
    #email    "ugurunturk@hotmail.com"
    #password "123123"
    #password_confirmation "123123"
  #end
#end