require 'rails_helper'

RSpec.describe BaitLoadingsController, type: :controller do


  # This should return the minimal set of attributes required to create a valid
  # Company. As you add validations to Company, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      vessel_id: vessel.id,
      bait_id: bait.id,
      quantity: 30
    }
  }

  let(:invalid_attributes) {
    {
      vessel_id: nil,
      bait_id: nil,
      quantity: nil
    }
  }

  let(:user)      { create :user }
  let(:admin)     { create :admin }
  let(:vessel)    { create :vessel }
  let(:bait)      { create :bait }
  let(:bait_loading1)  { create :bait_loading }
  let(:bait_loading2)  { create :bait_loading }
  let(:bait_loading3)  { create :bait_loading }


  describe "GET #index" do
    context 'when admin is logged in' do
      before :each do
        admin.roles.push Role.where(name: 'administrator').first_or_create
        sign_in admin
        get :index
      end
      it { is_expected.to respond_with :ok }
      it { is_expected.to respond_with_content_type :html }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :index }
      it { expect( assigns(:bait_loadings) ).to match_array( [bait_loading1, bait_loading2, bait_loading3] ) }
    end
    context 'when user is logged in' do
      before :each do
        sign_in user
        get :index
      end
      it { is_expected.to redirect_to root_path }
      it { expect( flash[:alert] ).to have_content "You are not authorized to access this page." }
    end
    context 'when user is logged out' do
      before :each do
        get :index
      end
      it { is_expected.to redirect_to new_user_session_path }
      it { expect( flash[:alert] ).to have_content "You must log in to continue." }
    end
    context 'when params[:format] == csv' do
      before :each do
        admin.roles.push Role.where(name: 'administrator').first_or_create
        sign_in admin
        get :index, { format: :csv }
      end
      it { is_expected.to respond_with :ok }
      it { is_expected.to respond_with_content_type :csv }
      it { is_expected.to_not render_with_layout }
      it { is_expected.to render_template :index }
      it { expect( assigns(:bait_loadings) ).to match_array( [bait_loading1, bait_loading2, bait_loading3] ) }
    end
  end

  describe "GET #show" do
    context 'when admin is logged in' do
      before :each do
        admin.roles.push Role.where(name: 'administrator').first_or_create
        sign_in admin
        get :show, { id: bait_loading1.id }
      end
      it { is_expected.to respond_with :ok }
      it { is_expected.to respond_with_content_type :html }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :show }
      it { expect( assigns(:bait_loading) ).to eq( bait_loading1 ) }
      it { is_expected.to_not set_flash }
    end
    context 'when user is logged in' do
      before :each do
        sign_in user
        get :show, { id: bait_loading1.id }
      end
      it { is_expected.to redirect_to root_path }
      it { expect( flash[:alert] ).to have_content "You are not authorized to access this page." }
    end
    context 'when user is logged out' do
      before :each do
        get :show, { id: bait_loading1.id }
      end
      it { is_expected.to redirect_to new_user_session_path }
      it { expect( flash[:alert] ).to have_content "You must log in to continue." }
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
      it { expect(assigns(:bait_loading)).to be_a_new(BaitLoading) }
    end
    context 'when user is logged in' do
      before :each do
        sign_in user
        get :new
      end
      it { is_expected.to redirect_to root_path }
      it { expect( flash[:alert] ).to have_content "You don't have permission to create bait loading reports." }
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
        get :edit, { id: bait_loading1.id }
      end
      it { is_expected.to respond_with :ok }
      it { is_expected.to respond_with_content_type :html }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :edit }
      it { expect(assigns(:bait_loading)).to eq(bait_loading1) }
    end
    context 'when user is logged in' do
      before :each do
        sign_in admin
        get :edit, { id: bait_loading1.id }
      end
      it { is_expected.to redirect_to root_path }
      it { expect( flash[:alert] ).to have_content "You don't have permission to edit this bait loading report." }
    end
    context 'when user is logged out' do
      before :each do
        get :edit, { id: bait_loading1.id }
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
        post :create, {:bait_loading => valid_attributes}
      end
      it 'does some stuff' do
        expect {
          post :create, {:bait_loading => attributes_for(:bait_loading, bait_id: bait.id, vessel_id: vessel.id) }
        }.to change(BaitLoading, :count).by(1)
      end
      it { expect(assigns(:bait_loading)).to be_a(BaitLoading) }
      it { expect(assigns(:bait_loading)).to be_persisted }
      it { is_expected.to redirect_to vessel_path(vessel) }
      it { expect( flash[:notice] ).to have_content "Bait loading report was successfully created." }
    end
    context "with invalid params" do
      before :each do
        post :create, {:bait_loading => invalid_attributes}
      end
      it { expect( assigns(:bait_loading) ).to be_a_new(BaitLoading) }
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
        { quantity: 60 }
      }
      before :each do
        put :update, {:id => bait_loading1.to_param, :bait_loading => new_attributes}
      end
      it { expect( assigns(:bait_loading) ).to eq(bait_loading1) }
      it { is_expected.to redirect_to bait_loading1.vessel }
      it { expect( assigns(:bait_loading).quantity ).to eq 60 }
      it { expect( flash[:notice] ).to have_content "Bait loading report was successfully updated." }
      it {
        is_expected.to permit(
          :vessel_id,
          :formatted_date,
          :bait_id,
          :secondary_bait_id,
          :quantity,
          :price,
          :location,
          :method_type
        ).
          for(:update, params: { id: bait_loading1.to_param, bait_loading: valid_attributes } ).
          on(:bait_loading)
        }
    end
    context "with invalid params" do
      before :each do
        put :update, {:id => bait_loading1.to_param, :bait_loading => invalid_attributes}
      end
      it { expect( assigns(:bait_loading) ).to eq(bait_loading1) }
      it { is_expected.to render_template :edit }
    end
  end

  describe "DELETE #destroy"  do
    let!(:bait_loading) { create :bait_loading }
    # we will only test with superadmin
    # other roles are covered by ability_spec
    before :each do
      admin.roles.push Role.where(name: 'administrator').first_or_create
      sign_in admin
      #require 'pry'; binding.pry
      delete :destroy, {:id => bait_loading1.to_param}
    end
    it { expect {
        delete :destroy, {:id => bait_loading.to_param}
      }.to change(BaitLoading, :count).by(-1) }
    it { is_expected.to redirect_to(bait_loading1.vessel) }
    it { expect( flash[:notice] ).to have_content "Bait loading report was successfully destroyed." }
  end


end
