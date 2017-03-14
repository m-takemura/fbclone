class CommentsController < ApplicationController
  before_action :set_comment, only:[:edit, :update, :destroy]

  def create
    # ログインユーザーに紐付けてインスタンス生成するためbuildメソッドを使用します。
    @comment = current_user.comments.build(comment_params)
    @topic = @comment.topic
    @notification=@comment.notifications.build(user_id:@topic.user.id)

    # クライアント要求に応じてフォーマットを変更
    respond_to do |format|
      if @comment.save
        # format.html { redirect_to blog_path(@topic), notice: 'コメントを投稿しました。' }
        # unless @comment.topic.user_id == current_user.id
        #   Pusher.trigger("user_#{@comment.topic.user_id}_channel", 'comment_created', {
        #     message: 'あなたの投稿にコメントが付きました'
        #   })
        #   Pusher.trigger("user_#{@comment.topic.user_id}_channel", 'notification_created', {
        #     unread_counts: Notification.where(user_id: @comment.topic.user.id, read: false).count
        #   })
        # end

        format.js {render :index}
      else
        # format.html { render :new }
      end
    end
  end

  def destroy
    # @comment=Comment.find(params[:id])
    # @topic=@comment.topic
    @comment.destroy

    respond_to do |format|
      # redirect_to blog_path(@blog)
      # format.html{redirect_to blog_path(@blog), notice:'コメントを削除しました。'}
      format.js{render :index}
    end
  end

  def edit
    # @comment=Comment.find(params[:id])
    # @topic=@comment.topic
    # binding.pry
  end

  def update
    if @comment.update(comment_params)
      redirect_to topics_path, notice:'コメントを更新しました！'
    else
      render 'edit'
    end
  end

  private
    # ストロングパラメーター
    def comment_params
      params.require(:comment).permit(:topic_id, :content)
    end

    def set_comment
      @comment=Comment.find(params[:id])
      @topic=@comment.topic
    end
end
