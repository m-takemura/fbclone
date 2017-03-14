class Comment < ActiveRecord::Base
  has_many :notifications, dependent: :destroy
  belongs_to :user
  belongs_to :topic

  after_save do
    #お知らせの通知
    # binding.pry
    Pusher.trigger("user_#{topic.user_id}_channel", 'notification_created',{
      #Comment#user.notifications
      #コメント投稿者がtopic投稿者と同じものはカウントしない
      unread_counts: Notification.includes(:comment)
      .where(user_id: topic.user.id, read: false)
      .where.not(comments:{user_id: topic.user.id}).count
    })
  end
end
