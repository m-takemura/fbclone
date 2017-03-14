class TopicsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic, only:[:edit, :show, :update, :destroy]

  def index
    @topics=Topic.my_topics(current_user)
    if params[:back]
      @topic=Topic.new(topics_params)
    else
      @topic=Topic.new
    end
    @comment=Comment.new
  end

  def create
    @topic=Topic.new(topics_params)
    @topic.user_id=current_user.id
    if @topic.save
      redirect_to topics_path, notice:"投稿しました！"
    else
      render 'edit'
    end
  end

  def show
    Notification.find(params[:notification_id]).update(read: true) if params[:notification_id]
    @comment=Comment.new
  end

  def edit
  end

  def update
    if @topic.update(topics_params)
      redirect_to topics_path, notice:'投稿を更新しました！'
    else
      render 'edit'
    end
  end

  def destroy
    @topic.destroy
    redirect_to topics_path, notice:'削除しました！'
  end

  private
    def topics_params
      params.require(:topic).permit(:content, :picture)
    end

    #idをキーとしてレコードを取得する
    def set_topic
      @topic=Topic.find(params[:id])
    end
end
