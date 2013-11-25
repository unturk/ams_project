require 'spec_helper'

describe "User pages" do

  subject { page }
  
  describe "index" do

    before do
      FactoryGirl.create(:user, name: "Bob", email: "bob@example.com")
      sign_in FactoryGirl.create(:user, admin:true)
      FactoryGirl.create(:user, name: "Ben", email: "ben@example.com")
      visit users_path
    end

    it { should have_title('Üyeler') }

    describe "pagination" do

      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all) { User.delete_all }

      let(:first_page) { User.paginate(page: 1) }
      let(:second_page) { User.paginate(page: 2) }

      it { should have_link('Next') }
      its(:html) { should match('>2</a>') }

      it "should list each user" do
        User.all[0..2].each do |user|
          page.should have_selector('li', text: user.name)
        end
      end

      it "should list the first page of users" do
        first_page.each do |user|
          page.should have_selector('li', text: user.name)
        end
      end

      it "should not list the second page of users" do
        second_page.each do |user|
          page.should_not have_selector('li', text: user.name)
        end
      end

      describe "showing the second page" do
        before { visit users_path(page: 2) }

        it "should list the second page of users" do
          second_page.each do |user|
            page.should have_selector('li', text: user.name)
          end
        end
      end
    end

    describe "delete links" do

      describe "as an admin user" do
       let(:admin) { FactoryGirl.create(:admin) }
        before do
          #sign_in admin
          visit users_path
        end

        it { should have_link('Kullanıcıyı Sil', href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect do
            click_link('Kullanıcıyı Sil', match: :first)
          end.to change(User, :count).by(-1)
        end
        it { should_not have_link('Kullanıcıyı Sil', href: user_path(admin)) }
      end
    end
  end
  

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    
    before do
      sign_in user
      visit user_path(user) 
    end

    it { should have_content(user.name) }
    it { should have_title(full_title(user.name)) }
  end

  describe "signup page" do
    before { visit signup_path }

    it { should have_selector('h1', text: 'Kayıt ol') }
    it { should have_title(full_title('Kayıt')) }
  end

  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Hesabımı Yarat" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "error messages" do
        before { click_button submit }

        it { should have_title('Kayıt') }
        it { should have_content('hata') }
      end
    end

    describe "with valid information" do
      before do
        fill_in "İsim", with: "Example User"
        fill_in "E-Mail", with: "user@example.com"
        fill_in "Şifre", with: "foobar"
        fill_in "Şifre Doğrulama", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }

        let(:user) { User.find_by_email('user@example.com') }

        it { should have_title(full_title('Anasayfa')) }
        it { should have_selector('div.alert.alert-success', text: 'Kayıt başarılı, AYS uygulamasına hoşgeldiniz!') }
        it { should have_link('Çıkış Yap') }
      end
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_selector('h1', text: "Bilgilerinizi Güncelleyin") }
      it { should have_title("Kullanıcı Ayarları") }
      it { should have_link('Resmi Değiştir', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "Güncelle" }

      it { should have_content('hata') }
    end

    describe "with valid information" do
      let(:new_name) { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "İsim", with: new_name
        fill_in "E-Mail", with: new_email
        fill_in "Şifre", with: user.password
        fill_in "Şifre Doğrulama", with: user.password
        click_button "Güncelle"
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Çıkış Yap', href: signout_path) }
      specify { user.reload.name.should == new_name }
      specify { user.reload.email.should == new_email }
    end
  end

end