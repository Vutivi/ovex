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
      deposit         = create(:deposit, member: member)
      
      expect(account.reload.balance).to eq(account_balance + (deposit.amount - deposit.fee))
    end

    it 'logs the account event' do
      account_balance = account.balance
      deposit         = create(:deposit, member: member)
      account_history = account.account_histories&.first

      expect(account_history).to be_valid
      expect(account_history.event).to eq('deposit')
      expect(account_history.change_amount).to eq(deposit.amount - deposit.fee)
      expect(account_history.balance).to eq(account_balance + (deposit.amount - deposit.fee))
      expect(account_history.locked).to eq(account.locked)
    end
  end
end
