Given /^an user login the website$/ do
   visit signin_path
    @user = User.create(name: "Example User", email: "user@example.com",
                      password: "foobar", password_confirmation: "foobar", verified:true)
  fill_in "Email",    with: @user.email
  fill_in "Şifre", with: @user.password
  click_button "Giriş Yap"
end

When /^the user visit the request page$/ do
  visit requests_path
end

Then /^the user should be on request page$/ do
  expect(page).to have_title('AYS | Sikayet')
end

When /^the user clicks button for send$/ do
  click_button "Gönder"
end

Then /^the user should see error message for send$/ do
   expect(page).to have_selector('div.alert.alert-error')
end

When /^the user fills in valid form$/ do
  fill_in "request_form_name",    with: "turgut felek"
  fill_in "request_form_title", with: "asd"
  fill_in "request_form_text", with: "qwe"
  click_button "Gönder"
end

Then /^the user should see success message$/ do
  expect(page).to have_selector('div.alert.alert-success')
end