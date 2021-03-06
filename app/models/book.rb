class Book < ApplicationRecord
   belongs_to :user
   has_many :favorites, dependent: :destroy
   has_many :book_comment, dependent: :destroy
   validates :title,presence: true
   validates :body,presence: true, length: { maximum: 200 }

    def favorited_by?(user)
      favorites.where(user_id: user.id).exists?
    end

    def self.search(method, word)
      if method == "forward_match"
        where("title LIKE?","#{word}%")
      elsif method == "backward_match"
        where("title LIKE?","%#{word}")
      elsif method == "perfect_match"
        where(title: "#{word}")
      elsif method == "partial_match"
        where("title LIKE?","%#{word}%")
      else
        all
      end
    end

end
