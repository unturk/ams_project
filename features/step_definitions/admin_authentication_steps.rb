Given /^an admin visits the signin page$/ do
  visit signin_path
end

When /^he submits invalid signin information$/ do
  click_button "Giriş Yap"
end

Then /^he should see an error message$/ do
  expect(page).to have_selector('div.alert.alert-error')
end

Given /^the admin has an account$/ do
  @user = User.create(name: "Example User", email: "user@example.com",
                      password: "foobar", password_confirmation: "foobar", admin:true, verified:true)
end

When /^the admin submits valid signin information$/ do
  fill_in "Email",    with: @user.email
  fill_in "Şifre", with: @user.password
  click_button "Giriş Yap"
end

Then /^he should see the home page$/ do
  expect(page).to have_title('Anasayfa')
end

And /^he should see a signout link$/ do
  expect(page).to have_link('Çıkış Yap', href: signout_path)
end

And /^he also should see the kiracı takip link$/ do
  expect(page).to have_link('Kiracı Takip', href: renters_path)
end

And /^he also should see the kullanıcı takip link$/ do
  expect(page).to have_link('Kullanıcı Takip', href: users_path)
end