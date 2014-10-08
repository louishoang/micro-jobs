require 'rails_helper'

describe User do
  describe 'validations' do
    it { should validate_presence_of(:user_name) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }

  end

  describe 'associations' do
    it { should have_many(:jobs).with_foreign_key('employer_id') }
  end
end
