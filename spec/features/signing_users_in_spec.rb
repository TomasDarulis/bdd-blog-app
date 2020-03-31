require 'rails_helper'
require 'faker'

RSpec.feature "Users sign in" do
    before do
        @john = User.create!(email: Faker::Internet.email, password: Faker::Number.number(digits: 6))
    end

    scenario "User signs in with valid credentials" do
        visit "/"

        click_link "Sign in"

        fill_in "Email", with: @john.email
        fill_in "Password", with: @john.password

        click_button "Log in"

        expect(page).to have_content("Signed in successfully")
        expect(page).to have_content("Signed in as #{@john.email}")
        expect(page).not_to have_link("Sign in")
        expect(page).not_to have_link("Sign up")
    end
end