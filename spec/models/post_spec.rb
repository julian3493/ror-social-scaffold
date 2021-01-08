require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'check the post content' do
    it 'does not show error if have content' do
      post = Post.new
      post.content = 'content post'
      post.valid?
      expect(post.errors[:content]).to_not include("can't be blank")
    end
    it 'shows error if have not content' do
      post = Post.new
      post.content = ''
      post.valid?
      expect(post.errors[:content]).to include("can't be blank")
    end
  end

  describe 'check associations' do
    it 'should have many comments' do
      associations = Post.reflect_on_association(:comments)
      expect(associations.macro).to eq(:has_many)
    end
    it 'should have many likes' do
      associations = Post.reflect_on_association(:likes)
      expect(associations.macro).to eq(:has_many)
    end
    it 'should belongs to user' do
      associations = Post.reflect_on_association(:user)
      expect(associations.macro).to eq(:belongs_to)
    end
  end
end
