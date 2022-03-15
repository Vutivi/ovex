require 'rails_helper'

RSpec.describe Currency, type: :model do
  it 'has a valid factory' do
    expect(build(:currency)).to be_valid
  end

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:code) }
end
