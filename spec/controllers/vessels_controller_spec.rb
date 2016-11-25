require 'rails_helper'

RSpec.describe VesselsController, type: :controller do


  # This should return the minimal set of attributes required to create a valid
  # Company. As you add validations to Company, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      ap2hi_ref:   'VesselRef'
    }
  }

  let(:invalid_attributes) {
    {
      ap2hi_ref:   nil
    }
  }

  let(:user)      { create :user }
  let(:admin)     { create :admin }
  let(:vessel1)   { create :vessel }
  let(:vessel2)   { create :vessel }
  let(:vessel3)   { create :vessel }


  describe "GET #index" do
    context 'when user is logged in' do
      before :each do
        sign_in user

        get :index

      end
      it { is_expected.to respond_with :ok }
      it { is_expected.to respond_with_content_type :html }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :index }
      it { expect( assigns(:vessels) ).to match_array( [vessel1, vessel2, vessel3] ) }
    end
    context 'when user is logged out' do
      before :each do
        get :index
      end
      it { is_expected.to respond_with :ok }
      it { is_expected.to respond_with_content_type :html }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :index }
      it { expect( assigns(:vessels) ).to match_array( [vessel1, vessel2, vessel3] ) }
    end
    context 'when params[:format] == csv' do
      before :each do
        get :index, { format: :csv }
      end
      it { is_expected.to respond_with :ok }
      it { is_expected.to respond_with_content_type :csv }
      it { is_expected.to_not render_with_layout }
      it { is_expected.to render_template :index }
      it { expect( assigns(:vessels) ).to match_array( [vessel1, vessel2, vessel3] ) }
    end
  end

  describe "GET #show" do
    context 'when user is logged in' do
      before :each do
        sign_in user
        get :show, { id: vessel1.id }
      end
      it { is_expected.to respond_with :ok }
      it { is_expected.to respond_with_content_type :html }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :show }
      it { expect( assigns(:vessel) ).to eq( vessel1 ) }
      it { is_expected.to_not set_flash }
    end
    context 'when user is logged out' do
      before :each do
        get :show, { id: vessel1.id }
      end
      it { is_expected.to respond_with :ok }
      it { is_expected.to respond_with_content_type :html }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :show }
      it { expect( assigns(:vessel) ).to eq( vessel1 ) }
      it { is_expected.to_not set_flash }
    end
  end

  describe "GET #new" do
    context 'when admin is logged in' do
      before :each do
        admin.roles.push Role.where(name: 'administrator').first_or_create
        sign_in admin
        get :new
      end
      it { is_expected.to respond_with :ok }
      it { is_expected.to respond_with_content_type :html }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :new }
      it { expect(assigns(:vessel)).to be_a_new(Vessel) }
    end
    context 'when user is logged in' do
      before :each do
        sign_in admin
        get :new
      end
      it { is_expected.to redirect_to root_path }
      it { expect( flash[:alert] ).to have_content "You don't have permission to create vessels." }
    end
    context 'when user is logged out' do
      before :each do
        get :new
      end
      it { is_expected.to redirect_to new_user_session_path }
      it { expect( flash[:alert] ).to have_content "You must log in to continue." }
    end
  end

  describe "GET #edit" do
    context 'when admin is logged in' do
      before :each do
        admin.roles.push Role.where(name: 'administrator').first_or_create
        sign_in admin
        get :edit, { id: vessel1.id }
      end
      it { is_expected.to respond_with :ok }
      it { is_expected.to respond_with_content_type :html }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :edit }
      it { expect(assigns(:vessel)).to eq(vessel1) }
    end
    context 'when user is logged in' do
      before :each do
        sign_in admin
        get :edit, { id: vessel1.id }
      end
      it { is_expected.to redirect_to root_path }
      it { expect( flash[:alert] ).to have_content "You don't have permission to edit this vessel." }
    end
    context 'when user is logged out' do
      before :each do
        get :edit, { id: vessel1.id }
      end
      it { is_expected.to redirect_to new_user_session_path }
      it { expect( flash[:alert] ).to have_content "You must log in to continue." }
    end
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
        post :create, {:vessel => valid_attributes}
      end
      it 'does some stuff' do
        expect {
          post :create, {:vessel => attributes_for(:vessel) }
        }.to change(Vessel, :count).by(1)
      end
      it { expect(assigns(:vessel)).to be_a(Vessel) }
      it { expect(assigns(:vessel)).to be_persisted }
      it { is_expected.to redirect_to vessel_path(Vessel.last) }
      it { expect( flash[:notice] ).to have_content "Vessel was successfully created." }
    end
    context "with invalid params" do
      before :each do
        post :create, {:vessel => invalid_attributes}
      end
      it { expect( assigns(:vessel) ).to be_a_new(Vessel) }
      it { is_expected.to render_template :new }
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
        { name: 'New Name' }
      }
      before :each do
        put :update, {:id => vessel1.to_param, :vessel => new_attributes}
      end
      it { expect( assigns(:vessel) ).to eq(vessel1) }
      it { is_expected.to redirect_to vessel1 }
      it { expect( assigns(:vessel).name ).to eq 'New Name' }
      it { expect( flash[:notice] ).to have_content "Your edits were successfully submitted and are pending review." }
      it {
        is_expected.to permit(:name, :vessel_type_id, :gear_id, :flag_state, :year_built,
          :length, :tonnage, :imo_number, :shark_policy, :iuu_list, :code_of_conduct,
          :company_id, :ap2hi_ref, :issf_ref, :crew, :hooks, :captain, :owner, :sipi_number,
          :sipi_expiry, :siup_number, :issf_ref_requested, :name_changed, :flag_state_changed,
          :radio, :relationship_type, :formatted_sipi_expiry, :return_to, :material_type,
          :machine_type, :capacity, :vms, :tracker, :port, :operational_type).
          for(:update, params: { id: vessel1.to_param, vessel: valid_attributes } ).
          on(:vessel)
        }
    end
    context "with invalid params" do
      before :each do
        put :update, {:id => vessel1.to_param, :vessel => invalid_attributes}
      end
      it { expect( assigns(:vessel) ).to eq(vessel1) }
      it { is_expected.to render_template :edit }
    end
  end

  describe "DELETE #destroy"  do
    let!(:vessel) { create :vessel }
    # we will only test with superadmin
    # other roles are covered by ability_spec
    before :each do
      admin.roles.push Role.where(name: 'administrator').first_or_create

      sign_in admin
      #require 'pry'; binding.pry
      delete :destroy, {:id => vessel1.to_param}
    end
    it { expect {
        delete :destroy, {:id => vessel.to_param}
      }.to change(Vessel, :count).by(-1) }
    it { is_expected.to redirect_to(vessels_path) }
    it { expect( flash[:notice] ).to have_content "Vessel was successfully destroyed." }
  end


end
