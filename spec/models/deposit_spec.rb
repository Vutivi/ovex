require 'rails_helper'

RSpec.describe Deposit, type: :model do
  let(:deposit) { create(:deposit) }

  it { is_expected.to validate_presence_of(:amount) }
  it { is_expected.to validate_presence_of(:fee) }
  it { is_expected.to validate_presence_of(:aasm_state) }
  it 'has a valid factory' do
    expect(build(:deposit)).to be_valid
  end

  it 'increments the account balance by deposit amount' do
    account = create(:account)

    expect { deposit }.to change { account.balance }.by(deposit.amount - deposit.fee)
  end
end
