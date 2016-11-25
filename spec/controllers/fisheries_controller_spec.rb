require 'rails_helper'

RSpec.describe FisheriesController, type: :controller do


  # This should return the minimal set of attributes required to create a valid
  # Company. As you add validations to Company, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      name:   'Fishery A',
      code:   'PL'
    }
  }

  let(:invalid_attributes) {
    {
      name:   nil,
      code:   nil
    }
  }

  let(:user)      { create :user }
  let(:admin)     { create :admin }
  let(:fishery1)  { create :fishery }
  let(:fishery2)  { create :fishery }
  let(:fishery3)  { create :fishery }


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
      it { expect( assigns(:fisheries) ).to match_array( [fishery1, fishery2, fishery3] ) }
    end
    context 'when user is logged out' do
      before :each do
        get :index
      end
      it { is_expected.to respond_with :ok }
      it { is_expected.to respond_with_content_type :html }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :index }
      it { expect( assigns(:fisheries) ).to match_array( [fishery1, fishery2, fishery3] ) }
    end
    context 'when params[:format] == csv' do
      before :each do
        get :index, { format: :csv }
      end
      it { is_expected.to respond_with :ok }
      it { is_expected.to respond_with_content_type :csv }
      it { is_expected.to_not render_with_layout }
      it { is_expected.to render_template :index }
      it { expect( response.headers["Content-Type"] ).to have_text('text/csv') }
      it { expect( assigns(:fisheries) ).to match_array( [fishery1, fishery2, fishery3] ) }
    end
  end

  describe "GET #show" do
    context 'when user is logged in' do
      before :each do
        sign_in user
        get :show, { id: fishery1.id }
      end
      it { is_expected.to respond_with :ok }
      it { is_expected.to respond_with_content_type :html }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :show }
      it { expect( assigns(:fishery) ).to eq( fishery1 ) }
      it { is_expected.to_not set_flash }
    end
    context 'when user is logged out' do
      before :each do
        get :show, { id: fishery1.id }
      end
      it { is_expected.to respond_with :ok }
      it { is_expected.to respond_with_content_type :html }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :show }
      it { expect( assigns(:fishery) ).to eq( fishery1 ) }
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
      it { expect(assigns(:fishery)).to be_a_new(Fishery) }
    end
    context 'when user is logged in' do
      before :each do
        sign_in user
        get :new
      end
      it { is_expected.to redirect_to root_path }
      it { expect( flash[:alert] ).to have_content "You don't have permission to create fisheries." }
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
        get :edit, { id: fishery1.id }
      end
      it { is_expected.to respond_with :ok }
      it { is_expected.to respond_with_content_type :html }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :edit }
      it { expect(assigns(:fishery)).to eq(fishery1) }
    end
    context 'when user is logged in' do
      before :each do
        sign_in admin
        get :edit, { id: fishery1.id }
      end
      it { is_expected.to redirect_to root_path }
      it { expect( flash[:alert] ).to have_content "You don't have permission to edit this fishery." }
    end
    context 'when user is logged out' do
      before :each do
        get :edit, { id: fishery1.id }
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
        post :create, {:fishery => valid_attributes}
      end
      it 'does some stuff' do
        expect {
          post :create, {:fishery => attributes_for(:fishery) }
        }.to change(Fishery, :count).by(1)
      end
      it { expect(assigns(:fishery)).to be_a(Fishery) }
      it { expect(assigns(:fishery)).to be_persisted }
      it { is_expected.to redirect_to fishery_path(Fishery.last) }
      it { expect( flash[:notice] ).to have_content "Fishery was successfully created." }
    end
    context "with invalid params" do
      before :each do
        post :create, {:fishery => invalid_attributes}
      end
      it { expect( assigns(:fishery) ).to be_a_new(Fishery) }
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
        put :update, {:id => fishery1.to_param, :fishery => new_attributes}
      end
      it { expect( assigns(:fishery) ).to eq(fishery1) }
      it { is_expected.to redirect_to fishery1 }
      it { expect( assigns(:fishery).name ).to eq 'New Name' }
      it { expect( flash[:notice] ).to have_content "Your edits were successfully submitted and are pending review." }
      it {
        is_expected.to permit(:name, :code).
          for(:update, params: { id: fishery1.to_param, fishery: valid_attributes } ).
          on(:fishery)
        }
    end
    context "with invalid params" do
      before :each do
        put :update, {:id => fishery1.to_param, :fishery => invalid_attributes}
      end
      it { expect( assigns(:fishery) ).to eq(fishery1) }
      it { is_expected.to render_template :edit }
    end
  end

  describe "DELETE #destroy"  do
    let!(:fishery) { create :fishery }
    # we will only test with superadmin
    # other roles are covered by ability_spec
    before :each do
      admin.roles.push Role.where(name: 'administrator').first_or_create
      sign_in admin
      delete :destroy, {:id => fishery1.to_param}
    end
    it { expect {
        delete :destroy, {:id => fishery.to_param}
      }.to change(Fishery, :count).by(-1) }
    it { is_expected.to redirect_to(fisheries_path) }
    it { expect( flash[:notice] ).to have_content "Fishery was successfully destroyed." }
  end


end
