class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    #orderで新らしいのがくるように並び替え where(read: false)で未読通知のみ表示
    @notifications = Notification.where(user_id: current_user.id).where(read: false).order(created_at: :desc)
  end
end
