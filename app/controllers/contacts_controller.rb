class ContactsController < ApplicationController
  before_action :set_contact, only: [:create, :confirm]

  def new
    if params[:back]
      set_contact
    else
      @contact = Contact.new
    end
  end
  
  def create
    if @contact.save
    redirect_to root_path, notice: "お問い合わせが完了しました！"
    else
      render 'new'
    end
  end
  
  def confirm
    render :new if @contact.invalid?
  end
  
  private
    def contacts_params
      params.require(:contact).permit(:name, :email, :content)
    end
    
    #変数の取得、インスタンス変数化をするメソッド
    def set_contact
      @contact = Contact.new(contacts_params)
    end
end
