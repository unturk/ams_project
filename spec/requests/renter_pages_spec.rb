require 'spec_helper'

describe "Renter pages" do

  subject { page }
  
  describe "index page with regular user visiting" do
    
    let(:user) { FactoryGirl.create(:user) } 
    
    before do
      sign_in user
      visit renters_path
    end
      
    it { should have_title('Anasayfa') }
    it { should have_selector('div.alert.alert-notice', text: 'Sayfaya erişim yetkiniz') }
  end
  
  describe "index page with admin user visiting" do
    
    let(:admin) { FactoryGirl.create(:admin) }

    before do
      sign_in admin
      visit renters_path
    end

    it { should have_title('Kiracı Takip') }
    it { should have_selector('h1', text: 'Tüm Apartman Sakinleri') }
    it { should have_selector('th', text: 'Daire No') }
    it { should have_selector('th', text: 'İsim') }
    it { should have_selector('th', text: 'Telefon') }
    it { should have_selector('th', text: 'E-mail') }
    it { should have_selector('th', text: 'Eylemler') }
    it { should have_link('Yeni Kiracı Ekle', href: 'renters/new' ) }
    
    describe "adding new renter" do
      before { click_link 'Yeni Kiracı Ekle' }
      it { should have_selector('h1', text: 'Yeni Kiracı') }
      
      
      describe "with invalid information" do
         before { click_button "Kiracıyı Ekle" }

         it { should have_title('Kiracı Takip') }
         it { should have_selector('h1', text: 'Yeni Kiracı') }
         it { should have_selector('div.alert.alert-error', text: 'Kayıt formunda') }
      end
  
      describe "with valid information" do
        let(:renter) { FactoryGirl.create(:renter) }
         before do
          select '8', :from => "Daire Numarası"
          fill_in "İsim", with: renter.name
          fill_in "Telefon *", with: renter.phone
          fill_in "E-Mail", with: "deneme2@renter.com"
          click_button "Kiracıyı Ekle"
        end
        
        it { should have_title('Kiracı Takip') }
        it { should have_selector('h1', text: 'Tüm Apartman Sakinleri') }
        it { should_not have_selector('h1', text: 'Yeni Kiracı') }
      end

    end # end of adding new renter
    
    describe "deleting a renter" do
      
     before do  
        FactoryGirl.create(:renter, name:"Deneme Renter 1", ap_num:"4", email:"dnm3@mail.com")
        visit renters_path 
     end
     
      
     it { should have_content(Renter.first.name)}
     it { should have_content(Renter.first.ap_num)}
     it { should have_link('Sil', href: renter_path(Renter.first)) }
        it "should be able to delete another renter" do
          expect do
            click_link('Sil', match: :first)
          end.to change(Renter, :count).by(-1)
        end
    end
    
  end # end of index page with admin user visiting
 
end # end of Renter pages