require 'spec_helper'

describe "Aidat pages" do

  subject { page }
  
  describe "index page with regular user visiting" do
    
    let(:user) { FactoryGirl.create(:user) } 
    
    before do
      sign_in user
      visit aidats_path
    end
      
    it { should have_title('Anasayfa') }
    it { should have_selector('div.alert.alert-notice', text: 'Sayfaya erişim yetkiniz') }
  end
  
  describe "index page with admin user visiting" do
    
    let(:admin) { FactoryGirl.create(:admin) }
    let(:renter){ FactoryGirl.create(:renter)}

    before do
      sign_in admin
      visit renters_path
      click_link 'Yeni Kiracı Ekle'
      select renter.ap_num, :from => "Daire Numarası"
      fill_in "İsim", with: renter.name
      fill_in "Telefon *", with: renter.phone
      fill_in "E-Mail", with: renter.email
      click_button "Kiracıyı Ekle"
      visit aidats_path
    end

    it { should have_title('Aidat İşlem') }
    it { should have_selector('h1', text: 'Aidat Sayfası') }
    it { should have_selector('th', text: 'Daire No') }
    it { should have_selector('th', text: 'İsim') }
    it { should have_content(renter.name) }
    it { should have_link('Aidat Ekle', href: new_aidat_path ) }
    
    
 
   describe "adding new aidat" do
      before do 
        click_link 'Aidat Ekle' 
      end
      
      it { should have_selector('h1', text: 'Aidat Ekle') }
      it { should have_title('Yeni Aidat Girdisi') }
      
      describe "filling valid aidat form" do
        let(:aidat) { FactoryGirl.create(:aidat) }
          before do
            select aidat.daire, :from => "Daire"
            select aidat.year,  :from => "Yıl"
            select aidat.month, :from => "Ay"
            expect do
              click_button('Ekle', match: :first)
            end.to change(Aidat, :count).by(+1)
          end
          
        it { should have_title('Aidat Geçmişi') }
        it { should have_selector('h2', text: Renter.find_by_ap_num(aidat.daire).name) }
        it { should have_content(aidat.month) }
        it { should have_content(aidat.year) }
        it { should have_content(aidat.daire) }
      end # end of filling valid aidat form
      
    end # end of adding new aidat
    
  end # end of index page with admin user visiting
 
end # end of Aidat pages