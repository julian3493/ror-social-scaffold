require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'check the user name' do
    it 'does not show error if name is valid' do
      post = Post.new
      post.content = 'post without user'
      post.valid?
      expect(post.errors[:content]).to_not include("can't be blank")
    end
  end
end
