class Article < ApplicationRecord
    validates :title, presence: true
    validates :body, presence: true

    default_scope { order(created_at: :desc) }

    belongs_to :user
    #if an article is deleted, all of the comments it had are also deleted
    has_many :comments, dependent: :destroy
end
