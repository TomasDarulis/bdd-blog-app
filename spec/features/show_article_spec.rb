require 'rails_helper'
require 'faker'

RSpec.feature "Showing an Article" do
    before do
        user = User.create!(email: Faker::Internet.email, password: Faker::Number.number(digits: 6))
        login_as(user)
        @article = Article.create(title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph, user: user)
    end

    scenario "A user shows an article" do
        visit "/"

        click_link @article.title

        expect(page).to have_content(@article.title)
        expect(page).to have_content(@article.body)
        expect(current_path).to eq(article_path(@article))
    end
end