require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'check associations' do
    it 'should belongs to user' do
      associations = Like.reflect_on_association(:user)
      expect(associations.macro).to eq(:belongs_to)
    end
  end
end
