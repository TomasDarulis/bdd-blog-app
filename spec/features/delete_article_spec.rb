require 'rails_helper'
require 'faker'

RSpec.feature "Deleting an Article" do
    before do
        @article = Article.create(title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph)
    end

    scenario "A user deletes an article" do
        visit "/"

        click_link @article.title
        click_link "Delete Article"

        expect(page).to have_content("Article has been deleted successfully")
        expect(page.current_path).to eq(articles_path)
    end
end