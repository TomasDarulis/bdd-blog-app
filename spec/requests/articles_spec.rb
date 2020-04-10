require 'rails_helper'
require 'faker'

RSpec.describe "Articles", type: :request do
    before do
        @user1 = User.create(email: Faker::Internet.email, password: Faker::Number.number(digits: 6))
        @user2 = User.create(email: Faker::Internet.email, password: Faker::Number.number(digits: 6))
        @article = Article.create!(title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph, user: @user1)
    end

    describe 'GET /articles/:id/edit' do
        context 'with non-signed in user' do
            before { get "/articles/#{@article.id}/edit" }

            it "redirects to the sign in page" do
                expect(response.status).to eq 302
                flash_message = "You need to sign in or sign up before continuing."
                expect(flash[:alert]).to eq flash_message
            end
        end

        context 'with signed in user, who is non-owner' do
            before do
                login_as(@user2)
                get "/articles/#{@article.id}/edit"
            end

            it "redirects to the home page" do
                expect(response.status).to eq 302
                flash_message = "You can only edit your own article."
                expect(flash[:alert]).to eq flash_message
            end
        end

        context "with signed in user as owner successfully edit" do
            before do
                login_as(@user1)
                get "/articles/#{@article.id}/edit"
            end

            it "successfully edits article" do
                expect(response.status).to eq 200
            end
        end
    end

    describe 'DELETE /articles/:id/delete' do
        context "with non-signed in user" do
            before { delete "/articles/#{@article.id}" }

            it "redirects to the sign in page" do
                flash_message = "You need to sign in or sign up before continuing."
                expect(flash[:alert]).to eq flash_message
            end
        end

        context 'with signed in user, who is non-owner' do
            before do
                login_as(@user2)
                delete "/articles/#{@article.id}"
            end

            it "redirects to the home page" do
                expect(response.status).to eq 302
                flash_message = "You can only delete your own article."
                expect(flash[:alert]).to eq flash_message
            end
        end

        context "with signed in user as owner successfully delete" do
            before do
                login_as(@user1)
                delete "/articles/#{@article.id}"
            end

            it "successfully deletes article" do
                expect(response.status).to eq 302
            end
        end
    end

    describe 'GET /articles/:id' do
        context 'with existing article' do
            before { get "/articles/#{@article.id}" }

            it "handles existing article" do
                expect(response.status).to eq 200
            end
        end
        context 'with non-existing article' do
            before { get "/articles/xxxx" }

            it "handles non-existing article" do
                expect(response.status).to eq 302
                flash_message = "The article you are looking for could not be found"
                expect(flash[:alert]).to eq flash_message
            end
        end
    end
end