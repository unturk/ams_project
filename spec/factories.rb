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
    meslek "Şarkıcı"
    medeni_durum "Evli"
    birey_sayisi "2"
    cocuk_sayisi "0"
    memleket "İzmir"
    ev_sahibi "Uğur Üntürk"
    ev_sahibi_telefon "12345678912"
    kira_miktari "2000"
  end
  
  factory :aidat do
    daire "1"
    year "2013"
    month "Aralık"
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