require 'rails_helper'

RSpec.describe Account, type: :model do
  it 'has a valid factory' do
    expect(build(:account)).to be_valid
  end

  describe '#withdrawal' do
    describe 'when account has negative balance' do
      it 'throws a no available balance error'
    end

    describe 'when account has positive balance' do
      describe 'and withdrawal amount is greater than account balance' do
        it 'throws a higher withdrawal amount error'
      end

      describe 'and withdrawal amount is less than account balance' do
        it 'updates the locked amount with withdrawal amount'
        it 'deducts the withdrawal amount from the account balance'
      end
    end
  end
end
