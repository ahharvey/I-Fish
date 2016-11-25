

require 'rails_helper'

RSpec.describe UnloadingCatch do



  let(:unloading_catch1) { create :unloading_catch }
  let(:unloading_catch2) { create :unloading_catch }

  describe 'associations' do
    context 'belongs to' do
      it { is_expected.to belong_to(:fish) }
      it { is_expected.to belong_to(:unloading) }
      it { is_expected.to belong_to(:size_class) }
    end
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:fish) }
  end

end
