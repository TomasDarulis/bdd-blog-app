require 'rails_helper'
require 'faker'

RSpec.feature "Adding reviews to Articles" do
    before do
        @user1 = User.create(email: Faker::Internet.email, password: Faker::Number.number(digits: 6))
        @user2 = User.create(email: Faker::Internet.email, password: Faker::Number.number(digits: 6))
        @article = Article.create!(title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph, user: @user1)
    end

    scenario "permits a signed in user to write a review" do
        login_as(@user2)

        visit "/"

        click_link @article.title
        fill_in "New Comment", with: "An amazing article"
        click_button "Add Comment"

        expect(page).to have_content("Comment has been created")
        expect(page).to have_content("An amazing article")
        expect(current_path).to eq(article_path(@article.id))
    end
end