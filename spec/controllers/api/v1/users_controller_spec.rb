require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.
#
# Also compared to earlier versions of this generator, there are no longer any
# expectations of assigns and templates rendered. These features have been
# removed from Rails core in Rails 5, but can be added back in via the
# `rails-controller-testing` gem.

RSpec.describe Api::V1::UsersController, type: :controller do
  include ApiHelper

  let(:admin){
    create(:admin)
  }

  let(:valid_attributes) {
    {name: "aa", username:"aas", email: "x1wins@changwoo.net", password: "password123", password_confirmation: "password123"}
  }

  let(:invalid_attributes) {
    {name: "", username:"aas", email: "", password: "password123", password_confirmation: "password123"}
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # UsersController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response - admin role" do
      authenticated_header(request: request, user: admin)

      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
    it "returns a success response - not admin role" do
      user = User.create! valid_attributes
      authenticated_header(request: request, user: user)

      get :index, params: {}, session: valid_session
      expect(response).to be_forbidden
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      user = User.create! valid_attributes
      authenticated_header(request: request, user: user)

      get :show, params: {_username: user.username}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new User" do
        expect {
          post :create, params: {user: valid_attributes}, session: valid_session
        }.to change(User, :count).by(1)
      end

      it "renders a JSON response with the new user" do

        post :create, params: {user: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to include('application/json')
        expect(response.location).to eq(api_v1_user_url(User.last.username))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new user" do

        post :create, params: {user: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to include('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {name: "updatedname", username: valid_attributes[:username], email: "update@changwoo.net", password: "password1111", password_confirmation: "password1111"}
      }

      it "updates the requested user" do
        user = User.create! valid_attributes
        authenticated_header(request: request, user: user)

        put :update, params: {_username: user.username, user: new_attributes}, session: valid_session
        user.reload
        expect(user.name).to eq(new_attributes[:name])
        expect(user.email).to eq(new_attributes[:email])
        expect(user.authenticate(new_attributes[:password])).to eq(user)
      end

      it "renders a JSON response with the user" do
        user = User.create! valid_attributes
        authenticated_header(request: request, user: user)

        put :update, params: {_username: user.username, user: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to include('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the user" do
        user = User.create! valid_attributes
        authenticated_header(request: request, user: user)

        put :update, params: {_username: user.username, user: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to include('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested user" do
      user = User.create! valid_attributes
      authenticated_header(user: user, request: request)
      
      expect {
        delete :destroy, params: {_username: user.username}, session: valid_session
      }.to change(User, :count).by(-1)
    end
  end

end
