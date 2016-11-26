require 'rails_helper'

RSpec.describe UnloadingsController, type: :controller do


  # This should return the minimal set of attributes required to create a valid
  # Company. As you add validations to Company, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      vessel_id:  vessel.id,
      port_id: port.id,
      wpp_id: wpp.id
    }
  }



  let(:invalid_attributes) {
    {
      vessel_id:   nil,
      port_id: nil,
      wpp_id: nil
    }
  }

  let(:user)         { create :user }
  let(:admin)        { create :admin }
  let(:port)         { create :port }
  let(:wpp)          { create :wpp }
  let(:vessel)       { create :vessel }
  let(:company)      { create :company }
  let(:unloading1)   { create :unloading }
  let(:unloading2)   { create :unloading, vessel: vessel_with_company }
  let(:unloading3)   { create :unloading, vessel: vessel_with_unloading }


  let(:vessel_with_company) { create :vessel, company: company_with_unloading }

  let(:vessel_with_unloading) { vessel }
  let(:company_with_unloading) { company }
  let(:unloading_with_vessel) { unloading3 }
  let(:unloading_with_company) { unloading2 }

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
      it { expect( assigns(:unloadings) ).to match_array( [unloading1, unloading2, unloading3] ) }
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
    context 'when nested by company' do
      before :each do
        admin.roles.push Role.where(name: 'administrator').first_or_create
        sign_in admin
        get :index, { company_id: company_with_unloading.id }
      end
      it { is_expected.to respond_with :ok }
      it { is_expected.to respond_with_content_type :html }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :index }
      it { expect( assigns(:unloadings) ).to match_array( [unloading_with_company] ) }
    end
    context 'when nested by vessel' do
      before :each do
        admin.roles.push Role.where(name: 'administrator').first_or_create
        sign_in admin
        get :index, { vessel_id: vessel_with_unloading.id }
      end
      it { is_expected.to respond_with :ok }
      it { is_expected.to respond_with_content_type :html }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :index }
      it { expect( assigns(:unloadings) ).to match_array( [unloading_with_vessel] ) }
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
      it { expect( response.headers["Content-Type"] ).to have_text('text/csv') }
      it { expect( assigns(:unloadings) ).to match_array( [unloading1, unloading2, unloading3] ) }
    end
  end

  describe "GET #show" do
    context 'when admin is logged in' do
      before :each do
        sign_in admin
        admin.roles.push Role.where(name: 'administrator').first_or_create
        get :show, { id: unloading1.id }
      end
      it { is_expected.to respond_with :ok }
      it { is_expected.to respond_with_content_type :html }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :show }
      it { expect( assigns(:unloading) ).to eq( unloading1 ) }
      it { is_expected.to_not set_flash }
    end
    context 'when user is logged in' do
      before :each do
        sign_in user
        get :show, { id: unloading1.id }
      end
      it { is_expected.to redirect_to root_path }
      it { expect( flash[:alert] ).to have_content "You are not authorized to access this page." }
    end
    context 'when user is logged out' do
      before :each do
        get :show, { id: unloading1.id }
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
      it { expect(assigns(:unloading)).to be_a_new(Unloading) }
    end
    context 'when user is logged in' do
      before :each do
        sign_in user
        get :new
      end
      it { is_expected.to respond_with :ok }
      it { is_expected.to respond_with_content_type :html }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :new }
      it { expect(assigns(:unloading)).to be_a_new(Unloading) }
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
        get :edit, { id: unloading1.id }
      end
      it { is_expected.to respond_with :ok }
      it { is_expected.to respond_with_content_type :html }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :edit }
      it { expect(assigns(:unloading)).to eq(unloading1) }
    end
    context 'when user is logged in' do
      before :each do
        sign_in admin
        get :edit, { id: unloading1.id }
      end
      it { is_expected.to redirect_to root_path }
      it { expect( flash[:alert] ).to have_content "You don't have permission to edit this unloading." }
    end
    context 'when user is logged out' do
      before :each do
        get :edit, { id: unloading1.id }
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
        post :create, {:unloading => valid_attributes}
      end
      it 'does some stuff' do
        expect {
          post :create, {:unloading => build(:unloading).attributes }
        }.to change(Unloading, :count).by(1)
      end
      it { expect(assigns(:unloading)).to be_a(Unloading) }
      it { expect(assigns(:unloading)).to be_persisted }
      it { is_expected.to redirect_to unloading_path(Unloading.last) }
      it { expect( flash[:notice] ).to have_content "Unloading was successfully created." }
    end
    context "with invalid params" do
      before :each do
        post :create, {:unloading => invalid_attributes}
      end
      it { expect( assigns(:unloading) ).to be_a_new(Unloading) }
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
        { fuel: '300' }
      }
      before :each do
        put :update, {:id => unloading1.to_param, :unloading => new_attributes}
      end
      it { expect( assigns(:unloading) ).to eq(unloading1) }
      it { is_expected.to redirect_to unloading1 }
      it { expect( assigns(:unloading).fuel ).to eq 300 }
      it { expect( flash[:notice] ).to have_content "Unloading Record updated successfully!" }
      it {
        is_expected.to permit(
          :port_id,
          :wpp_id,
          :vessel_id,
          :formatted_time_out,
          :formatted_time_in,
          :etp,
          :location,
          :fuel,
          :ice,
          :review_state,
          :byproduct,
          :discard,
          :yft,
          :bet,
          :skj,
          :kaw,
          :catch_certificate
          ).
          for(:update, params: { id: unloading1.to_param, unloading: valid_attributes } ).
          on(:unloading)
        }
    end
    context "with invalid params" do
      before :each do
        put :update, {:id => unloading1.to_param, :unloading => invalid_attributes}
      end
      it { expect( assigns(:unloading) ).to eq(unloading1) }
      it { is_expected.to render_template :edit }
    end
  end

  describe "DELETE #destroy"  do
    let!(:unloading) { create :unloading }
    # we will only test with superadmin
    # other roles are covered by ability_spec
    before :each do
      admin.roles.push Role.where(name: 'administrator').first_or_create
      sign_in admin
      delete :destroy, {:id => unloading1.to_param}
    end
    it { expect {
        delete :destroy, {:id => unloading.to_param}
      }.to change(Unloading, :count).by(-1) }
    it { is_expected.to redirect_to(unloadings_path) }
    it { expect( flash[:notice] ).to have_content "Unloading was successfully destroyed." }
  end


end
