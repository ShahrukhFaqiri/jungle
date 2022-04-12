require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'creates user with all correct fields, (name, lastname, email, password and match passwords' do
      @user = User.new(first_name: 'Sha', last_name: 'Faqiri', email: 'Test@test.com', password: '123', password_confirmation: '123')
      @user.save
      expect(@user).to be_valid
    end
    it 'Error when passwords are not the same' do
      @user = User.new(first_name: 'Sha', last_name: 'Faqiri', email: 'Test@test.com', password: '123', password_confirmation: '124')
      @user.save
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'Password needs to be atleast 3 characters' do
      @user = User.new(first_name: 'Sha', last_name: 'Faqiri', email: 'Test@test.com', password: '12', password_confirmation: '12')
      @user.save
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 3 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should allow login with correct credentials' do
      @user = User.create!(first_name: 'Sha', last_name: 'Faqiri', email: 'Test@test.com', password: '123', password_confirmation: '123')
      @login = User.authenticate_with_credentials('Test@test.com', '123')
      expect(@user).to eq(@login)
    end
    it 'Should not be able to login with incorrect username' do
      @user = User.create!(first_name: 'Sha', last_name: 'Faqiri', email: 'Test@test.com', password: '123', password_confirmation: '123')
      @login = User.authenticate_with_credentials('Test@test.com', '1234')
      expect(@user).to_not eq(@login)
      expect(@login).to eq(nil)
    end
    it 'random spacing should stop from login' do
      @user = User.create!(first_name: 'Sha', last_name: 'Faqiri', email: 'test@test.com', password: '123', password_confirmation: '123')
      @login = User.authenticate_with_credentials('     test@test.com', '1234')
      expect(@user).to eq(@login)
    end
  end

end
