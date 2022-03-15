require 'rails_helper'

RSpec.describe AccountHistory, type: :model do
  it 'has a valid factory' do
    expect(build(:account_history)).to be_valid
  end

  it { is_expected.to validate_presence_of(:balance) }
  it { is_expected.to validate_presence_of(:locked) }
  it { is_expected.to validate_presence_of(:event) }
  it { is_expected.to validate_presence_of(:change_amount) }
end
