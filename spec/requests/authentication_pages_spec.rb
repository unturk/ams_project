require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_selector('h1', text: 'Giriş Yap') }
    it { should have_title(full_title('Giriş')) }
  end

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Giriş Yap" }

      it { should have_title('Giriş') }
      it { should have_selector('div.alert.alert-error', text: 'hatalı') }

      describe "after visiting another page" do
        before { click_link "Anasayfa" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end

    describe "with valid user information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email", with: user.email.upcase
        fill_in "Şifre", with: user.password
        click_button "Giriş Yap"
      end

      it { should have_title(full_title('Anasayfa')) }

      it { should have_link('Profil', href: user_path(user)) }
      it { should have_link('Ayarlar', href: edit_user_path(user)) }
      it { should have_link('Çıkış Yap', href: signout_path) }
      it { should_not have_link('Giriş Yap', href: signin_path) }

      describe "followed by signout" do
        before { click_link "Çıkış Yap" }
        it { should have_link('Giriş Yap') }
      end
    end # end of with valid user information
    
    describe "with valid admin information" do
      let(:user) { FactoryGirl.create(:user, admin:true) }
      before do
        fill_in "Email", with: user.email.upcase
        fill_in "Şifre", with: user.password
        click_button "Giriş Yap"
      end

      it { should have_title(full_title('Anasayfa')) }

      it { should have_link('Aidat Takip', href: aidats_path) }
      it { should have_link('Kullanıcı Takip', href: users_path) }
      it { should have_link('Kiracı Takip', href: renters_path) }
      it { should have_link('Profil', href: user_path(user)) }
      it { should have_link('Ayarlar', href: edit_user_path(user)) }
      it { should have_link('Çıkış Yap', href: signout_path) }
      it { should_not have_link('Giriş Yap', href: signin_path) }

      describe "followed by signout" do
        before { click_link "Çıkış Yap" }
        it { should have_link('Giriş Yap') }
      end
    end # end of with valid admin information
  end # end of sign in
  
  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email", with: user.email
          fill_in "Şifre", with: user.password
          click_button "Giriş Yap"
        end

        describe "after signing in" do

          it "should render the desired protected page" do
            page.should have_title('Kullanıcı Ayarları')
          end

          describe "when signing in again" do
            before { visit signin_path }
            it { should have_selector('div.alert.alert-notice', text: 'Zaten') }
          end # end of when signing in again
        end # end of after signing in
      end # end of when attempting to visit a protected page

      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_title('Giriş') }
        end

        describe "submitting to the update action" do
          before { patch user_path(user) }
          specify { response.should redirect_to(signin_url) }
        end

        describe "visiting user index" do
          before { visit users_path }
          it { should have_title('Giriş') }
        end
      end # end of in the Users controller

    end # for non-signed-in users

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in user, no_capybara: true }

      describe "visiting Users#edit page" do
        before { visit edit_user_path(wrong_user) }
        it { should have_title('Giriş') }
      end

      describe "submitting a PATCH request to the Users#update action" do
        before { patch user_path(wrong_user) }
        specify { response.should redirect_to(root_url) }
      end
    end # end of as wrong user

    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { sign_in non_admin, no_capybara: true }

      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete user_path(user) }
        specify { response.should redirect_to(root_url) }
      end
    end # end of as non-admin
    
  end # end of Authorization

end # end of Authentication 