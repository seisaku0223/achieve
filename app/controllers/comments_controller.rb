class CommentsController < ApplicationController

  # コメントを保存、投稿するためのアクションです。
  def create
    # Blogをパラメータの値から探し出し,Blogに紐づくcommentsとしてbuildします。
    @comment = current_user.comments.build(comment_params)
    @blog = @comment.blog
    # クライアント要求に応じてフォーマットを変更
    respond_to do |format|
      if @comment.save
        format.html { redirect_to blog_path(@blog), notice: 'コメントを投稿しました。' }
        # JavaScript形式でレスポンスを返します。
        format.js { render :index }
      else
        # newアクション及び、Viewにnewがないため、動作しないと思われる
        format.html { render :new }
      end
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    #idをキーに、今保存されている内容を取得、下記で更新する
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to blogs_path, notice: "コメントを編集しました！"
    else
      #update失敗で編集ページへ戻す
      render 'edit'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
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
end
