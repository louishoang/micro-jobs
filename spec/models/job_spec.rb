require 'rails_helper'

describe Job do
  describe 'validations' do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:location) }
    it do
      should validate_numericality_of(:budget).
      is_greater_than_or_equal_to(20)
    end
    it do
      should ensure_length_of(:description).
      is_at_least(50)
    end

  end

  describe 'associations' do
    it do
      should belong_to(:user).
      with_foreign_key('employer_id')
      ## should belong to user where job.employer_id = user.id
    end
  end
end
