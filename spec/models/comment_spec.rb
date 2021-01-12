require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'check the comment content content' do
    it 'does not show error if have content' do
      post = Comment.new
      post.content = 'comment post'
      post.valid?
      expect(post.errors[:content]).to_not include("can't be blank")
    end
    it 'shows error if have not content' do
      post = Comment.new
      post.content = ''
      post.valid?
      expect(post.errors[:content]).to include("can't be blank")
    end
  end

  describe 'check associations' do
    it 'should belongs to user' do
      associations = Comment.reflect_on_association(:user)
      expect(associations.macro).to eq(:belongs_to)
    end
    it 'should belongs to post' do
      associations = Comment.reflect_on_association(:post)
      expect(associations.macro).to eq(:belongs_to)
    end
  end
end
