require 'rails_helper'
require 'faker'

RSpec.feature "Showing an Article" do
    before do
        @user1 = User.create(email: Faker::Internet.email, password: Faker::Number.number(digits: 6))
        @user2 = User.create(email: Faker::Internet.email, password: Faker::Number.number(digits: 6))
        @article = Article.create(title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph, user: @user1)
    end

    scenario "to non-signed in user hide the Edit and Delete buttons" do
        visit "/"

        click_link @article.title

        expect(page).to have_content(@article.title)
        expect(page).to have_content(@article.body)
        expect(current_path).to eq(article_path(@article))

        expect(page).not_to have_link("Edit Article")
        expect(page).not_to have_link("Delete Article")
    end

    scenario "to non-owner user hide the Edit and Delete buttons" do
        login_as(@user2)
        visit "/"

        click_link @article.title

        expect(page).to have_content(@article.title)
        expect(page).to have_content(@article.body)
        expect(current_path).to eq(article_path(@article))

        expect(page).not_to have_link("Edit Article")
        expect(page).not_to have_link("Delete Article")
    end
end