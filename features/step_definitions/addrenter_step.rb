Given /^an admin login the website$/ do
  @admin = User.create(name:"Admin User", email: "admin@example.com", password: "foobar",password_confirmation: "foobar", admin:true, verified:true)
  visit signin_path
  fill_in "Email",    with: @admin.email
  fill_in "Şifre", with: @admin.password
  click_button "Giriş Yap"
end

When /^the admin visit the renter page$/ do
  visit renters_path
end

Then /^the admin should be on renter page$/ do
  expect(page).to have_title('AYS | Kiracı Takip')
end

When /^the admin clicks Add New Renter$/ do
  click_link "Yeni Kiracı Ekle"
end

And /^the admin clicks Add Renter$/ do
  click_button "Kiracıyı Ekle"
end

Then /^the admin should see an error message about Add New Renter$/ do
  expect(page).to have_selector('div.alert.alert-error')
end

And /^the admin sumbit valid renter information$/ do
  select '8', :from => "Daire Numarası"
          fill_in "İsim", with: "Turguts"
          fill_in "Telefon *", with: "12345678912"
          fill_in "Ev Sahibi Telefon", with: "2"
          fill_in "E-Mail", with: "deneme2@renter.com"
  click_button "Kiracıyı Ekle"
end

Then /^the admin should see success message in renter page$/ do
  expect(page).to have_selector('div.alert.alert-success')
  expect(page).to have_selector('h1', text: 'Tüm Apartman Sakinleri')
end







