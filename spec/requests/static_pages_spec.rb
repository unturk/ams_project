require 'spec_helper'

describe "Static pages" do

  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_selector('h3', text: 'Merter sitesine hoşgeldiniz') }
    it { should have_title(full_title('Anasayfa')) }
    it { should_not have_title '| Home' }

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        sign_in user
        visit root_path
      end
      
      it { should have_content('Sisteme üye olarak giriş yapmış bulunmaktasınız.') }
      it { should_not have_content('yetkili') }
    end
    
    describe "for signed-in admin user" do
      let(:admin_user) { FactoryGirl.create(:user, admin:true) }
      before do
        sign_in admin_user
        visit root_path
      end
      
      it { should have_content('Şuan sistemde yetkili olarak görevlisiniz.') }
      it { should_not have_content('üye') }
    end
  end

  describe "Help page" do
    before { visit help_path }

    it { should have_selector('h1', text: 'Yardım Sayfası') }
    it { should have_title(full_title('Yardım')) }
  end

  describe "About page" do
    before { visit about_path }

    it { should have_selector('h1', text: 'Hakkımızda') }
    it { should have_title(full_title('Hakkımızda')) }
  end

  describe "Contact page" do
    before { visit contact_path }

    it { should have_selector('h1', text: 'İletişim Sayfası') }
    it { should have_title(full_title('İletişim')) }
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "Hakkımızda"
    page.should have_title full_title('Hakkımızda')
    click_link "Yardım"
    page.should have_title full_title('Yardım')
    click_link "İletişim"
    page.should have_title full_title('İletişim')
    click_link "Anasayfa"
    click_link "Hemen Üye Olun!"
    page.should have_title full_title('Kayıt')
    click_link "AYS"
    page.should have_selector 'h3', text: 'Merter sitesine hoşgeldiniz'
  end
end