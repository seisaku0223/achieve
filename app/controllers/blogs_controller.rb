class BlogsController < ApplicationController
  before_action :authenticate_user!
  #送られたidをキーとして取得する
  before_action :set_blog_id, only: [:show, :edit, :update, :destroy]
  #送られた変数を取得し、インスタンス変数化するメソッド
  before_action :set_blog_new, only: [:create, :confirm]

  def index
    @blogs = Blog.all
  end

  # showアクションを定義します。入力フォームと一覧を表示するためインスタンスを2つ生成します。
  def show
    @comment = @blog.comments.build
    @comments = @blog.comments
    #通知をクリックすると、通知が既読になる処理
    Notification.find(params[:notification_id]).update(read: true) if params[:notification_id]
  end

  def new
    if params[:back]
      @blog = Blog.new(blogs_params)
    else
      @blog = Blog.new
    end
  end

  def create
    # user_idを代入する
    @blog.user_id = current_user.id

    # save時のバリデーション成否を条件にしている
    if @blog.save
      # 一覧画面へ遷移し、"ブログを作成しました！"とメッセージを表示します。
      redirect_to blogs_path, notice: "ブログを作成しました！"
      NoticeMailer.sendmail_blog(@blog).deliver
    else
      # 入力フォームを再描画します。
      render 'new'
    end
  end

  def edit
  end

  def update
    #idをキーに、今保存されている内容を取得、下記で更新する
    if @blog.update(blogs_params)
      redirect_to blogs_path, notice: "ブログを編集しました！"
    else
      #update失敗で編集ページへ戻す
      render 'edit'
    end
  end

  def destroy
    @blog.destroy
    redirect_to blogs_path, notice: "ブログを削除しました！"
  end

  def confirm
    render :new if @blog.invalid?
  end

  private
    def blogs_params
      params.require(:blog).permit(:title, :content)
    end

    #idをキーとして取得するメソッド
    def set_blog_id
      @blog = Blog.find(params[:id])
    end

    #インスタンス変数化するメソッド
    def set_blog_new
      @blog = Blog.new(blogs_params)
    end
end
