Given /^an admin login the website about view$/ do
  @admin = User.create(name:"Admin User", email: "admin@example.com", password: "foobar",password_confirmation: "foobar", admin:true, verified:true)
  visit signin_path
  fill_in "Email",    with: @admin.email
  fill_in "Şifre", with: @admin.password
  click_button "Giriş Yap"
end

And /^given there is a renter in database about view$/ do
  @renter = Renter.create(name: "Example Renter", email:"user@example.com", phone:"12345678912", ap_num: "2")
end

When /^the admin visit the renter page about view$/ do
  visit renters_path
end

When /^the admin clicks show button$/ do
  click_link "Göster", match: :first
end

Then /^the admin should see renter information$/ do
  expect(page).to have_selector('h1', text: 'Kiracı Bilgileri')
end
