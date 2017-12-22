require 'rails_helper'

describe Contact do
  # 名前とEメールと内容、全て値があり有効な状態である
  it "is valid with name, email and content" do
    contact = Contact.new(name: 'nametest', email: 'test@test.jp', content: '内容')
    expect(contact).to be_valid
  end

  # 名前とEメールと内容、いずれかの値がなく無効な状態である
  it "is invalid without name, email or content" do
    contact = Contact.new(name: 'nametest', content: '内容')
    expect(contact).not_to be_valid
  end

  #valid?によりエラーメッセージから判定、いずれかのキーの値が無く無効であること
  it "is invalid without name, email and content" do
    contact = Contact.new
    contact.valid?
    expect(contact.errors[:name]).to include("を入力してください")
    expect(contact.errors[:email]).to include("を入力してください")
    expect(contact.errors[:content]).to include("を入力してください")
  end

  # 各キーの値が存在すれば有効
  it "is valid with name, email and content" do
    contact = Contact.new(name: 'nametest', email: 'test@mail', content: '内容')
    expect(contact).to be_valid
  end

  #個別判定をすると下記のパターンになるが、他キーはnilでも通ってしまう
  #エラーメッセージより、名前に値が存在
  it "is invalid without name" do
    contact = Contact.new
    contact.valid?
    expect(contact.errors[:name]).to include("を入力してください")
  end

  # 名前に値が存在し、有効
  it "is valid with name" do
    contact = Contact.new(name: 'nametest')
    expect(contact).to be_name
  end
end
