require 'rails_helper'
require 'faker'

RSpec.feature "Deleting an Article" do
    before do
        user = User.create!(email: Faker::Internet.email, password: Faker::Number.number(digits: 6))
        login_as(user)
        @article = Article.create(title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph, user: user)
    end

    scenario "A user deletes an article" do
        visit "/"

        click_link @article.title
        click_link "Delete Article"

        expect(page).to have_content("Article has been deleted successfully")
        expect(page.current_path).to eq(articles_path)
    end
end