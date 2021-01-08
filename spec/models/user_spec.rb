require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'check the user name' do
    it 'does not show error if name is valid' do
      user = User.new
      user.name = 'user name'
      user.valid?
      expect(user.errors[:name]).to_not include("can't be blank")
    end

    it 'shows error if name is empty' do
      user = User.new
      user.name = ''
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'shows error if name is too long' do
      user = User.new
      user.name = 'namewithmorethan18characters'
      user.valid?
      expect(user.errors[:name]).to include('is too long (maximum is 18 characters)')
    end
  end

  describe 'check the email' do
    it 'does not show error if email field is empty' do
      user = User.new
      user.email = ''
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end
    it 'does not show error if email field is not empty' do
      user = User.new
      user.email = 'test@email.com'
      user.valid?
      expect(user.errors[:email]).to_not include("can't be blank")
    end
  end

  describe 'check the password' do
    it 'does not show error if password field is empty' do
      user = User.new
      user.password = ''
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end
    it 'does not show error if password field is empty' do
      user = User.new
      user.password = 'pass'
      user.valid?
      expect(user.errors[:password]).to include('is too short (minimum is 6 characters)')
    end
    it 'does not show error if email field is not empty' do
      user = User.new
      user.password = 'pass1234'
      user.valid?
      expect(user.errors[:password]).to_not include("can't be blank")
    end
  end

  describe 'check associations' do
    it "should have many posts" do
      associations = User.reflect_on_association(:posts)
      expect(associations.macro).to eq(:has_many)
    end
    it "should have many comments" do
      associations = User.reflect_on_association(:comments)
      expect(associations.macro).to eq(:has_many)
    end
    it "should have many likes" do
      associations = User.reflect_on_association(:likes)
      expect(associations.macro).to eq(:has_many)
    end
    it "should have many friendships" do
      associations = User.reflect_on_association(:friendships)
      expect(associations.macro).to eq(:has_many)
    end
    it "should have many inverse friendships" do
      associations = User.reflect_on_association(:inverse_friendships)
      expect(associations.macro).to eq(:has_many)
    end
  end
end
