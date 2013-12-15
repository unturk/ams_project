Given /^a user visits the signin page$/ do
  visit signin_path
end

When /^she submits invalid signin information$/ do
  click_button "Giriş Yap"
end

Then /^she should see an error message$/ do
  expect(page).to have_selector('div.alert.alert-error')
end

Given /^the user has an account$/ do
  @user = User.create(name: "Example User", email: "user@example.com",
                      password: "foobar", password_confirmation: "foobar", verified:true)
end

When /^the user submits valid signin information$/ do
  fill_in "Email",    with: @user.email
  fill_in "Şifre", with: @user.password
  click_button "Giriş Yap"
end

Then /^she should see her profile page$/ do
  #expect(page).to have_title(@user.name)
  expect(page).to have_title('Anasayfa')
end

Then /^she should see a signout link$/ do
  expect(page).to have_link('Çıkış Yap', href: signout_path)
end