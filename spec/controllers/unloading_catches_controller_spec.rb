require 'rails_helper'

RSpec.describe UnloadingCatchesController, type: :controller do


  # This should return the minimal set of attributes required to create a valid
  # Company. As you add validations to Company, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      fish_id:  fish.id,
      unloading_id: unloading.id,
      quantity: 600
    }
  }



  let(:invalid_attributes) {
    {
      fish_id:  nil,
      unloading_id: nil,
      quantity: nil
    }
  }


  let(:admin)        { create :admin }

  let(:fish)         { create :fish }
  let(:unloading)    { create :unloading }

  let(:vessel)       { create :vessel }
  let(:company)      { create :company }
  let(:unloading_catch1)   { create :unloading_catch }
  let(:unloading_catch2)   { create :unloading, vessel: vessel_with_company }
  let(:unloading_catch3)   { create :unloading, vessel: vessel_with_unloading }


  let(:vessel_with_company) { create :vessel, company: company_with_unloading }

  let(:vessel_with_unloading) { vessel }
  let(:company_with_unloading) { company }
  let(:unloading_with_vessel) { unloading3 }
  let(:unloading_with_company) { unloading2 }

  describe "GET #index" do
    # not routable
  end

  describe "GET #show" do
    # not routable
  end

  describe "GET #new" do
    # not routable
  end

  describe "GET #edit" do
    # not routable
  end

  describe "POST #create" do
    # we will only test with admin
    # other roles are covered by ability_spec
    before :each do
      admin.roles.push Role.where(name: 'administrator').first_or_create
      sign_in admin
    end
    context "with valid params" do
      before :each do
        post :create, {:unloading_catch => valid_attributes}
      end
      it 'does some stuff' do
        expect {
          post :create, {:unloading_catch => build(:unloading_catch).attributes }
        }.to change(UnloadingCatch, :count).by(1)
      end
      it { expect(assigns(:unloading_catch)).to be_a(UnloadingCatch) }
      it { expect(assigns(:unloading_catch)).to be_persisted }
      it { is_expected.to redirect_to unloading_path(unloading) }
      it { expect( flash[:notice] ).to have_content "Catch record was successfully created." }
    end
    context "with invalid params" do
      before :each do
        post :create, {:unloading_catch => invalid_attributes}
      end
      it { expect( assigns(:unloading_catch) ).to be_a_new(UnloadingCatch) }
      it { is_expected.to render_template 'unloadings/show' }
    end
  end

  describe "PUT #update" do
    # we will only test with admin
    # other roles are covered by ability_spec
    before :each do
      admin.roles.push Role.where(name: 'administrator').first_or_create
      sign_in admin
    end
    context "with valid params" do
      let(:new_attributes) {
        { quantity: '300' }
      }
      before :each do
        put :update, {:id => unloading_catch1.to_param, :unloading_catch => new_attributes}
      end
      it { expect( assigns(:unloading_catch) ).to eq(unloading_catch1) }
      it { is_expected.to redirect_to unloading_catch1.unloading }
      it { expect( assigns(:unloading_catch).quantity ).to eq 300 }
      it { expect( flash[:notice] ).to have_content "Catch record was successfully updated." }
      it {
        is_expected.to permit(
          :fish_id,
          :unloading_id,
          :quantity
          ).
          for(:update, params: { id: unloading_catch1.to_param, unloading_catch: valid_attributes } ).
          on(:unloading_catch)
        }
    end
    context "with invalid params" do
      before :each do
        put :update, {:id => unloading_catch1.to_param, :unloading_catch => invalid_attributes}
      end
      it { expect( assigns(:unloading_catch) ).to eq(unloading_catch1) }
      it { is_expected.to render_template 'unloadings/show' }
    end
  end

  describe "DELETE #destroy"  do
    let!(:unloading_catch) { create :unloading_catch }
    # we will only test with superadmin
    # other roles are covered by ability_spec
    before :each do
      admin.roles.push Role.where(name: 'administrator').first_or_create
      sign_in admin
      delete :destroy, {:id => unloading_catch1.to_param}
    end
    it { expect {
        delete :destroy, {:id => unloading_catch.to_param}
      }.to change(UnloadingCatch, :count).by(-1) }
    it { is_expected.to redirect_to(unloading_path(unloading_catch1.unloading)) }
    it { expect( flash[:notice] ).to have_content "Catch record was successfully destroyed." }
  end


end
