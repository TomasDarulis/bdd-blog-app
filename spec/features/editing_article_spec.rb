require 'rails_helper'
require 'faker'

RSpec.feature "Editing an article" do
    before do
        user = User.create!(email: Faker::Internet.email, password: Faker::Number.number(digits: 6))
        login_as(user)
        @article = Article.create(title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph, user: user)
    end

    scenario "A user updates an article" do
        visit "/"

        click_link @article.title
        click_link "Edit Article"

        fill_in "Title", with: Faker::Lorem.sentence
        fill_in "Body", with: Faker::Lorem.paragraph

        click_button "Update Article"

        expect(page).to have_content("Article has been updated successfully")
        expect(page.current_path).to eq(article_path(@article))
    end

    scenario "A user fails to update an article" do
    visit "/"

    click_link @article.title
    click_link "Edit Article"

    fill_in "Title", with: ""
    fill_in "Body", with: Faker::Lorem.paragraph

    click_button "Update Article"

    expect(page).to have_content("Article has not been updated")
    expect(page.current_path).to eq(article_path(@article))
    end
end