require 'spec_helper'

describe Renter do

  before do
    @renter = Renter.new(name: "Example User", email: "user@example.com", phone:"02324567890", ap_num:"1",
                     meslek:"Futbolcu", medeni_durum:"Bekar", birey_sayisi:"1", cocuk_sayisi:"0", 
                     memleket:"İzmir", ev_sahibi:"Example User", ev_sahibi_telefon:"02324567890",
                     kira_miktari:"0")
  end

  subject { @renter }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:phone) }
  it { should respond_to(:ap_num) }
  it { should respond_to(:meslek) }
  it { should respond_to(:medeni_durum) }
  it { should respond_to(:birey_sayisi) }
  it { should respond_to(:cocuk_sayisi) }
  it { should respond_to(:memleket) }
  it { should respond_to(:ev_sahibi) }
  it { should respond_to(:ev_sahibi_telefon) }
  it { should respond_to(:kira_miktari) }

  it { should be_valid }


  describe "when name is not present" do
    before { @renter.name = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @renter.email = " " }
    it { should_not be_valid }
  end
  
  describe "when phone is not present" do
    before { @renter.phone = " " }
    it { should_not be_valid }
  end
  
  describe "when apartment number is not present" do
    before { @renter.ap_num = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @renter.name = "a" * 31 }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
      addresses.each do |invalid_address|
        @renter.email = invalid_address
        @renter.should_not be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @renter.email = valid_address
        @renter.should be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      renter_with_same_email = @renter.dup
      renter_with_same_email.ap_num = "2"
      renter_with_same_email.email = @renter.email.upcase
      renter_with_same_email.save
    end

    it { should_not be_valid }
  end
  
   describe "when apartment number is already taken" do
    before do
      renter_with_same_ap_num = @renter.dup
      renter_with_same_ap_num.email = "different@mail.com"
      renter_with_same_ap_num.save
    end

    it { should_not be_valid }
  end

  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it "should be saved as all lower-case" do
      @renter.email = mixed_case_email
      @renter.save
      @renter.reload.email.should == mixed_case_email.downcase
    end
  end

end