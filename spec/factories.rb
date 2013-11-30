FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
    verified true

    factory :admin do
      admin true
    end
  end
  
  factory :renter do
    ap_num "1"
    name "Example Renter"
    phone "02329876543"
    email "example@renter.com"
    ocak "0"
    subat "0"
    mart "0"
    nisan "0"
    mayis "0"
    haziran "0"
    temmuz "0"
    agustos "0"
    eylul "0"
    ekim "0"
    kasim "0"
    aralik "0"
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