require 'rails_helper'

RSpec.describe Member, type: :model do
  let(:member) { create(:member) }

  it "has a valid factory" do
    expect(build(:member)).to be_valid
  end
end
