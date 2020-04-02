require 'rails_helper'
require 'faker'

RSpec.feature "Signing out signed-in users" do
    before do
        @user = User.create!(email: Faker::Internet.email, password: Faker::Number.number(digits: 6))

        visit "/"

        click_link "Sign in"
        fill_in "Email", with: @user.email
        fill_in "Password", with: @user.password
        click_button "Log in"
    end

    scenario do
        visit "/"
        click_link "Sign out"
        expect(page).to have_content("Signed out successfully.")
        expect(page).not_to have_content("Sign out")
    end


end