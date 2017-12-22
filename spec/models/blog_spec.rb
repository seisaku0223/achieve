require 'rails_helper'

describe Blog do
  # タイトルと内容があれば有効な状態であること
  it "is valid with title and content" do
    blog = Blog.new(title: '宮岡', content: '暑いです')
    expect(blog).to be_valid
  end

  #タイトルと内容がなければ無効であること
  it "is invalid without a title and content" do
    blog = Blog.new
    expect(blog).not_to be_valid
  end

  #タイトルがなければエラー文を表示
  it "is invalid without a title" do
    blog = Blog.new
    blog.valid?
    expect(blog.errors[:title]).to include("を入力してください")
  end
end
