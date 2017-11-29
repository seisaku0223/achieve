module NotificationsHelper
  #2016-08-23 05:57:47のように表示されるので、日本用に変更
  def posted_time(time)
  time > Date.today ? "#{time_ago_in_words(time)}" : time.strftime('%m月%d日')
  end
end
