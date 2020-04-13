require 'rails_helper'
require 'faker'

RSpec.describe "Comments", type: :request do
    before do
        @user1 = User.create(email: Faker::Internet.email, password: Faker::Number.number(digits: 6))
        @user2 = User.create(email: Faker::Internet.email, password: Faker::Number.number(digits: 6))
        @article = Article.create!(title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph, user: @user1)
    end

    describe 'POST /articles/:id/comments' do
        context 'with a non signed in user' do
            before do
                post "/articles/#{@article.id}/comments", params: { comment: {body: Faker::Lorem.sentence} }
            end

        it 'redirects user to the sign in page' do
            flash_message = "Please sign in or sign up first"
            expect(response).to redirect_to(new_user_session_path)
            expect(response.status).to eq 302
            expect(flash[:alert]).to eq flash_message
        end
        end

        context 'with a logged in user' do
            before do
                login_as(@user2)
                post "/articles/#{@article.id}/comments", params: { comment: {body: Faker::Lorem.sentence} }
            end

            it 'creates the comment successfully' do
                flash_message = "Comment has been created"
                expect(response).to redirect_to(article_path(@article.id))
                expect(response.status).to eq 302
                expect(flash[:notice]).to eq flash_message
            end
        end
    end

end