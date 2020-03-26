require "rails_helper"
require 'faker'

RSpec.feature "Listing Articles" do
    before do
        @article1 = Article.create(title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph)
        @article2 = Article.create(title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph)
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
end