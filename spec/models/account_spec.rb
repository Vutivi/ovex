require 'rails_helper'

RSpec.describe Account, type: :model do
  let(:account) { create(:account) }

  it 'has a valid factory' do
    expect(build(:account)).to be_valid
  end

  describe '#withdraw' do
    describe 'when account does not have a positive balance' do
      it 'throws a no funds error' do
        zero_balance_account = create(:account, balance: 0.0)
        expect { zero_balance_account.withdraw(200.00) }.to raise_error('You have no funds in your account to withdraw')
      end
    end

    describe 'when account has positive balance' do
      describe 'and withdrawal amount is greater than account balance' do
        it 'throws a higher withdrawal amount error' do
          expect { account.withdraw(account.balance + 200.00) }.to raise_error('You cannot withdraw an amount higher than your balance')
        end
      end

      describe 'and withdrawal amount is less than account balance' do
        describe 'and there are locked funds' do
          let(:withdrawal_amount) { account.balance / 2 }

          before do
            account.withdraw(withdrawal_amount)
          end

          describe 'and withdrawal amount is greater than balance - locked funds' do
            it 'throws cannot withdraw error' do
              expect { account.withdraw((account.balance - withdrawal_amount) + 1) }.to raise_error('Your withdrawal amount exceeds your withdrawable balance')
            end
          end
          
          describe 'and withdrawal amount is less than balance - locked funds' do
            it 'updates the locked amount with withdrawal amount' do
              new_withdrawal_amount = account.balance - withdrawal_amount
              expect { account.withdraw(new_withdrawal_amount) }.to change { account.locked }.from(withdrawal_amount).to(account.locked + new_withdrawal_amount)
            end
          end
        end

        describe 'and there are no locked funds' do
          it 'updates the locked amount with withdrawal amount' do
            withdrawal_amount = account.balance / 2
            expect { account.withdraw(withdrawal_amount) }.to change { account.locked }.from(0.0).to(withdrawal_amount)
          end

          it 'logs the account event' do
            withdrawal_amount = account.balance / 2
            locked            = account.locked + withdrawal_amount
            account.withdraw(withdrawal_amount)

            account_history = account.account_histories&.first
      
            expect(account_history).to be_valid
            expect(account_history.event).to eq('withdrawal')
            expect(account_history.change_amount).to eq(withdrawal_amount)
            expect(account_history.balance).to eq(account.balance)
            expect(account_history.locked).to eq(locked)
          end
        end
      end
    end

    describe '#clear_funds' do
      let(:account_balance) { account.balance }
      let(:withdrawal_amount) { account_balance / 2 }

      before do
        account.withdraw(withdrawal_amount)
      end

      it 'reduce the balance by the locked funds' do
        expect { account.clear_funds }.to change { account.balance }.from(account_balance).to(account_balance - withdrawal_amount)
      end

      it 'clears the locked funds' do
        locked = account.locked
        expect { account.clear_funds }.to change { account.locked }.from(locked).to(0.0)
      end
    end
  end
end
