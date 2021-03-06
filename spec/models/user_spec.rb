require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー新規登録' do
    it '全ての項目が正しく入力されていれば登録できる' do
      expect(@user).to be_valid
    end
    it 'nicknameが空と登録できない' do
      @user.nick_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nick name can't be blank")
    end
    it 'email  が空と登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it '重複したemailが存在する場合登録できないこと' do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end
    it 'passwordが空と登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it 'password_confirmationとpasswordが一致しないと登録できない' do
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'passwordが5文字以下では登録できない' do
      @user.password = 'sy113'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end
    it 'passwordが英数字混合でないと登録できない' do
      @user.password = '123456'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
    end
    it 'last_nameが空と登録できない' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end
    it 'last_nameが全角漢字、かな、カナでないと登録できない' do
      @user.last_name = 'abc'
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name is invalid")
    end
    it 'first_name が空と登録できない' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end
    it 'first_nameが全角漢字、かな、カナでないと登録できない' do
      @user.first_name = 'abc'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name is invalid")
    end
    it 'last_name_kanaが空と登録できない' do
      @user.last_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank")
    end
    it 'last_name_kanaが全角カナ以外だと登録できない' do
      @user.last_name_kana = 'ふふふ'
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana is invalid")
    end
    it 'first_name_kanaが空と登録できない' do
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end
    it 'first_name_kanaが全角カナ以外だと登録できない' do
      @user.first_name_kana = 'ふふふ'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana is invalid")
    end
    it 'birthday  が空と登録できない' do
      @user.birthday = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end
  end
end
