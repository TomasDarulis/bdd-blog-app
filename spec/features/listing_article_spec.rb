require "rails_helper"
require 'faker'

RSpec.feature "Listing Articles" do
    before do
        user = User.create!(email: Faker::Internet.email, password: Faker::Number.number(digits: 6))
        @article1 = Article.create(title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph, user: user)
        @article2 = Article.create(title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph, user: user)
    end

    scenario "A user lists all articles" do
        visit "/"

        expect(page).to have_content(@article1.title)
        expect(page).to have_content(@article1.body)
        expect(page).to have_content(@article2.title)
        expect(page).to have_content(@article2.body)
        expect(page).to have_link(@article1.title)
        expect(page).to have_link(@article2.title)
    end

    scenario "A user has no articles" do
        Article.delete_all

        visit "/"

        expect(page).not_to have_content(@article1.title)
        expect(page).not_to have_content(@article1.body)
        expect(page).not_to have_content(@article2.title)
        expect(page).not_to have_content(@article2.body)
        expect(page).not_to have_link(@article1.title)
        expect(page).not_to have_link(@article2.title)

        within ("h1#no-articles") do
            expect(page).to have_content("No Articles Created")
        end
    end
end