Given /^a visiter goes to register page$/ do
  visit signup_path
end

When /^she submits invalid signup form$/ do
  click_button "Hesabımı Yarat"
end

Then /^she should see an error message about signup$/ do
  expect(page).to have_selector('div.alert.alert-error')
end

And /^she should stay in the register page$/ do
  expect(page).to have_title('Kayıt')
end

When /^the user submits valid signup form$/ do
  @user = User.new(name: "Example User", email: "user@example.com",
                      password: "foobar", password_confirmation: "foobar", verified:true)
  fill_in "İsim", with: @user.name
  fill_in "E-Mail",    with: @user.email
  fill_in "Şifre", with: @user.password
  fill_in "Şifre Doğrulama", with: @user.password_confirmation
  click_button "Hesabımı Yarat"
end

Then /^she should see a welcome message$/ do
  expect(page).to have_selector('div.alert.alert-success', text: 'Kayıt başarılı, AYS uygulamasına hoşgeldiniz!')
end

And /^she should redirected to signin page$/ do
  expect(page).to have_title('Giriş')
end