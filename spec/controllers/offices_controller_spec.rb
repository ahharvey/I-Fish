require 'rails_helper'

RSpec.describe OfficesController, type: :controller do


  # This should return the minimal set of attributes required to create a valid
  # Company. As you add validations to Company, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      name: 'Test'
    }
  }

  let(:invalid_attributes) {
    {
      name:   nil
    }
  }

  let(:user)      { create :user }
  let(:admin)     { create :admin }
  let(:office1)   { create :office }
  let(:office2)   { create :office }
  let(:office3)   { create :office }


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
      it { expect( assigns(:offices) ).to match_array( [office1, office2, office3] ) }
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
        get :index, { format: :csv }
      end
      it { is_expected.to respond_with :ok }
      it { is_expected.to respond_with_content_type :csv }
      it { is_expected.to_not render_with_layout }
      it { is_expected.to render_template :index }
      it { expect( response.headers["Content-Type"] ).to have_text('text/csv') }
      it { expect( assigns(:offices) ).to match_array( [office1, office2, office3] ) }
    end
  end

  describe "GET #show" do
    context 'when admin is logged in' do
      before :each do
        admin.roles.push Role.where(name: 'administrator').first_or_create
        sign_in admin
        get :show, { id: office1.id }
      end
      it { is_expected.to respond_with :ok }
      it { is_expected.to respond_with_content_type :html }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :show }
      it { expect( assigns(:office) ).to eq( office1 ) }
      it { is_expected.to_not set_flash }
    end
    context 'when user is logged in' do
      before :each do
        sign_in user
        get :show, { id: office1.id }
      end
      it { is_expected.to redirect_to root_path }
      it { expect( flash[:alert] ).to have_content "You are not authorized to access this page." }
    end
    context 'when user is logged out' do
      before :each do
        get :show, { id: office1.id }
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
      it { expect(assigns(:office)).to be_a_new(Office) }
    end
    context 'when user is logged in' do
      before :each do
        sign_in user
        get :new
      end
      it { is_expected.to redirect_to root_path }
      it { expect( flash[:alert] ).to have_content "You don't have permission to create offices." }
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
        get :edit, { id: office1.id }
      end
      it { is_expected.to respond_with :ok }
      it { is_expected.to respond_with_content_type :html }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :edit }
      it { expect(assigns(:office)).to eq(office1) }
    end
    context 'when user is logged in' do
      before :each do
        sign_in admin
        get :edit, { id: office1.id }
      end
      it { is_expected.to redirect_to root_path }
      it { expect( flash[:alert] ).to have_content "You don't have permission to edit this office." }
    end
    context 'when user is logged out' do
      before :each do
        get :edit, { id: office1.id }
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
        post :create, {:office => valid_attributes}
      end
      it 'does some stuff' do
        expect {
          post :create, {:office => attributes_for(:office) }
        }.to change(Office, :count).by(1)
      end
      it { expect(assigns(:office)).to be_a(Office) }
      it { expect(assigns(:office)).to be_persisted }
      it { is_expected.to redirect_to office_path(Office.last) }
      it { expect( flash[:notice] ).to have_content "Office was successfully created." }
    end
    context "with invalid params" do
      before :each do
        post :create, {:office => invalid_attributes}
      end
      it { expect( assigns(:office) ).to be_a_new(Office) }
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
        put :update, {:id => office1.to_param, :office => new_attributes}
      end
      it { expect( assigns(:office) ).to eq(office1) }
      it { is_expected.to redirect_to office1 }
      it { expect( assigns(:office).name ).to eq 'New Name' }
      it { expect( flash[:notice] ).to have_content "Your edits were successfully submitted and are pending review." }
      it {
        is_expected.to permit(:name).
          for(:update, params: { id: office1.to_param, office: valid_attributes } ).
          on(:office)
        }
    end
    context "with invalid params" do
      before :each do
        put :update, {:id => office1.to_param, :office => invalid_attributes}
      end
      it { expect( assigns(:office) ).to eq(office1) }
      it { is_expected.to render_template :edit }
    end
  end

  describe "DELETE #destroy" do
    let!(:office) { create :office }
    #Rails.logger.info Fishery.size
    # we will only test with superadmin
    # other roles are covered by ability_spec
    before :each do

      admin.roles.push Role.where(name: 'administrator').first_or_create
      sign_in admin
      delete :destroy, {:id => office1.to_param}

    end
    it {
      expect {
        delete :destroy, {:id => office.to_param}
      }.to change(Office, :count).by(-1)
    }
    it { is_expected.to redirect_to(offices_path) }
    it { expect( flash[:notice] ).to have_content "Office was successfully destroyed." }
  end


end
