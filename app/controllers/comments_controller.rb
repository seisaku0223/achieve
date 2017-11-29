class CommentsController < ApplicationController
  before_action :set_comment_id, only: [:edit, :update, :destroy]

  # コメントを保存、投稿するためのアクションです。
  def create
    # Blogをパラメータの値から探し出し,Blogに紐づくcommentsとしてbuildします。
    @comment = current_user.comments.build(comment_params)
    @blog = @comment.blog
    #お知らせ用、通知と受け手用user_idも保存
    @notification = @comment.notifications.build(user_id: @blog.user.id )
    # クライアント要求に応じてフォーマットを変更
    respond_to do |format|
      if @comment.save
        format.html { redirect_to blog_path(@blog), notice: 'コメントを投稿しました。' }
        # JavaScript形式でレスポンスを返します。
        format.js { render :index }
        #誇大化しないよう、モデルに移すのがいい
        unless @comment.blog.user_id == current_user.id
          Pusher.trigger("user_#{@comment.blog.user_id}_channel", 'comment_created', {
            message: 'あなたの作成したブログにコメントが付きました'
            })
        end
        Pusher.trigger("user_#{@comment.blog.user_id}_channel", 'notification_created', {
          unread_counts: Notification.where(user_id: @comment.blog.user.id, read: false).count
        })
      else
        # newアクション及び、Viewにnewがないため、動作しないと思われる
        format.html { render :new }
      end
    end
  end

  def edit
    #idをキーとして取得するメソッド
  end

  def update
    #idをキーに、今保存されている内容を取得、下記で更新する
    if @comment.update(comment_params)
      redirect_to blogs_path, notice: "コメントを編集しました！"
    else
      #update失敗で編集ページへ戻す
      render 'edit'
    end
  end

  def destroy
    #idをキーとして取得するメソッド
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to blog_path, notice: 'コメントを削除しました！' }
    # JavaScript形式でレスポンスを返します。
      format.js { render :index }
    end
  end

  private

    # ストロングパラメーター
    def comment_params
      params.require(:comment).permit(:blog_id, :content)
    end

    #idをキーとして取得するメソッド
    def set_comment_id
      @comment = Comment.find(params[:id])
    end

end
