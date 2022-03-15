require 'rails_helper'

RSpec.describe Deposit, type: :model do
  let(:member)  { create(:member) }
  let(:account) { create(:account, member: member) }

  it { is_expected.to validate_presence_of(:amount) }
  it { is_expected.to validate_presence_of(:fee) }
  it { is_expected.to validate_presence_of(:aasm_state) }
  it 'has a valid factory' do
    expect(build(:deposit)).to be_valid
  end

  describe 'updates the member account correctly' do
    it 'increments the account balance by deposit amount' do
      account_balance = account.balance
      deposit = create(:deposit, member: member)
      
      expect(account.reload.balance).to eq(account_balance + (deposit.amount - deposit.fee))
    end
  end
end
