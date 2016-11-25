require 'rails_helper'

RSpec.describe DocumentsController, type: :controller do


  # This should return the minimal set of attributes required to create a valid
  # Company. As you add validations to Company, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      file:  Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'test_image.jpg')),
      documentable_id: vessel.id,
      documentable_type: vessel.class.name
    }
  }

  let(:invalid_attributes) {
    {
      file:   nil,
      documentable_id: nil,
      documentable_type: nil
    }
  }

  let(:user)      { create :user }
  let(:admin)     { create :admin }
  let(:vessel)    { create :vessel }
  let(:vessel2)   { create :vessel }
  let(:document1)   { create :document, documentable: vessel }
  let(:document2)   { create :document }
  let(:document3)   { create :document }


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
      it { expect( assigns(:documents) ).to match_array( [document1, document2, document3] ) }
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
  end

  describe "GET #show" do
    context 'when admin is logged in' do
      before :each do
        admin.roles.push Role.where(name: 'administrator').first_or_create
        sign_in admin
        get :show, { id: document1.id }
      end
      it { is_expected.to respond_with :ok }
      it { is_expected.to respond_with_content_type :html }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :show }
      it { expect( assigns(:document) ).to eq( document1 ) }
      it { is_expected.to_not set_flash }
    end
    context 'when user is logged in' do
      before :each do
        sign_in user
        get :show, { id: document1.id }
      end
      it { is_expected.to redirect_to root_path }
      it { expect( flash[:alert] ).to have_content "You are not authorized to access this page." }
    end
    context 'when user is logged out' do
      before :each do
        get :show, { id: document1.id }
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
      it { expect(assigns(:document)).to be_a_new(Document) }
    end
    context 'when user is logged in' do
      before :each do
        sign_in user
        get :new
      end
      it { is_expected.to redirect_to root_path }
      it { expect( flash[:alert] ).to have_content "You don't have permission to create documents." }
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
        get :edit, { id: document1.id }
      end
      it { is_expected.to respond_with :ok }
      it { is_expected.to respond_with_content_type :html }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :edit }
      it { expect(assigns(:document)).to eq(document1) }
    end
    context 'when user is logged in' do
      before :each do
        sign_in user
        get :edit, { id: document1.id }
      end
      it { is_expected.to redirect_to root_path }
      it { expect( flash[:alert] ).to have_content "You don't have permission to edit this document." }
    end
    context 'when user is logged out' do
      before :each do
        get :edit, { id: document1.id }
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
        post :create, {:document => valid_attributes}
      end
      it 'does some stuff' do
        expect {
          post :create, {:document => attributes_for(:document, documentable_id: vessel.id, documentable_type: vessel.class.name ) }
        }.to change(Document, :count).by(1)
      end
      it { expect(assigns(:document)).to be_a(Document) }
      it { expect(assigns(:document)).to be_persisted }
      it { is_expected.to redirect_to vessel_path(vessel) }
      it { expect( flash[:notice] ).to have_content "Document was successfully created." }
    end
    context "with invalid params" do
      before :each do
        post :create, {:document => invalid_attributes}
      end
      it { expect( assigns(:document) ).to be_a_new(Document) }
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
        { documentable_id: vessel2.id }
      }
      before :each do
        put :update, {:id => document1.to_param, :document => new_attributes}
      end
      it { expect( assigns(:document) ).to eq(document1) }
      it { is_expected.to redirect_to vessel2 }
      it { expect( assigns(:document).documentable ).to eq vessel2 }
      it { expect( flash[:notice] ).to have_content "Document was successfully updated." }
      it {
        is_expected.to permit(:file, :documentable_id, :documentable_type).
          for(:update, params: { id: document1.to_param, document: valid_attributes } ).
          on(:document)
        }
    end
    context "with invalid params" do
      before :each do
        put :update, {:id => document1.to_param, :document => invalid_attributes}
      end
      it { expect( assigns(:document) ).to eq(document1) }
      it { is_expected.to render_template :edit }
    end
  end

  describe "DELETE #destroy"  do
    let!(:document) { create :document }
    # we will only test with superadmin
    # other roles are covered by ability_spec
    before :each do
      admin.roles.push Role.where(name: 'administrator').first_or_create

      sign_in admin
      #require 'pry'; binding.pry
      delete :destroy, {:id => document1.to_param}
    end
    it { expect {
        delete :destroy, {:id => document.to_param}
      }.to change(Document, :count).by(-1) }
    it { is_expected.to redirect_to(vessel_path(vessel)) }
    it { expect( flash[:notice] ).to have_content "Document was successfully destroyed." }
  end


end
