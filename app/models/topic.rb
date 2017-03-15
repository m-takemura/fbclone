class Topic < ActiveRecord::Base
  validates :content, presence: true

  mount_uploader :picture, PictureUploader

  belongs_to :user
  has_many :comments, dependent: :destroy

  # 渡されたユーザーによる投稿と、渡されたユーザーが
  # フォローしているユーザーによる投稿を返します
  def self.my_topics(user)
    user_ids = user.followed_user_id
    user_ids << user.id
    # binding.pry
    where(user_id: user_ids).order("created_at desc")
  end

  def posted_date
    created_at.strftime("%-m月%-d日 %-l:%M")
  end
end
