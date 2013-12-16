Given /^an admin login the website about delete$/ do
  @admin = User.create(name:"Admin User", email: "admin@example.com", password: "foobar",password_confirmation: "foobar", admin:true, verified:true)
  visit signin_path
  fill_in "Email",    with: @admin.email
  fill_in "Şifre", with: @admin.password
  click_button "Giriş Yap"
end

And /^given there is a renter in database$/ do
  @renter = Renter.create(name: "Example Renter", email:"user@example.com", phone:"12345678912", ap_num: "2")
end

When /^the admin visit the renter page about delete$/ do
  visit renters_path
  expect(page).to have_content(Renter.name)
end

Then /^the admin should be on renter page about delete$/ do
  expect(page).to have_title('AYS | Kiracı Takip')
end

When /^the admin clicks Delete Renter$/ do
  click_link "Sil", match: :first
end

Then /^the admin should not see renter name$/ do
  page.should_not have_content(Renter.name)
end