
And /^given there is a announcement in database$/ do
  @anon = Post.create(title:"yeni duyuru",text:"silmek için yeni duyuru")
end

When /^the admin visit the announcement page about delete$/ do
  visit posts_path
  expect(page).to have_content(@anon.title)
end
Then /^the admin should be on announcement page about delete$/ do
  expect(page).to have_title('AYS | Duyurular')
end

When /^the admin clicks Delete announcement$/ do
  click_link "Sil", match: :first
end

Then /^the admin should not see announcement title$/ do
  page.should_not have_content(@anon.title)
end