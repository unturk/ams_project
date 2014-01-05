Given /^an admin login to website$/ do
  @admin = User.create(name:"Admin User", email: "admin@example.com", password: "foobar",password_confirmation: "foobar", admin:true, verified:true)
  visit signin_path
  fill_in "Email",    with: @admin.email
  fill_in "Şifre", with: @admin.password
  click_button "Giriş Yap"
end

When /^the admin visit announcement page$/ do
  visit posts_path
end

Then /^the admin should be on announcement page$/ do
  expect(page).to have_title('AYS | Duyurular')
end

When /^the admin clicks Add New Announcement$/ do
  click_link "Yeni Duyuru"
end


And /^the admin clicks Add Announcement$/ do
  click_button "Duyuruyu Yayınla"
end

Then /^the admin should see an error message about Add New Announcement$/ do
  expect(page).to have_selector('div.alert.alert-error')
end

And /^the admin sumbit valid announcement information$/ do
  
          fill_in "post_title", with: "Yeni Duyuru"
          fill_in "post_text", with: "Yeni duyuru içeriği ekle"
          
  #click_button "Duyuruyu Yayınla"
end

Then /^the admin should see the announcement information$/ do
  expect(page).to have_title('AYS | Duyuru Göster')
end

  