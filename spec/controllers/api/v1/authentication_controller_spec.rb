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

RSpec.describe Api::V1::AuthenticationController, type: :controller do
  include ApiHelper

  let(:user){
    create(:user)
  }

  let(:valid_attributes) {
    {email: user.email, password: user.password }
  }

  let(:invalid_attributes) {
    {email: "", password: "" }
  }

  let(:invalid_attributes_password) {
    {email: user.email, password: "wrong_password" }
  }

  let(:invalid_attributes_email) {
    {email: "wrong_email", password: user.password }
  }

  let(:valid_session) { {} }

  describe "POST #login" do
    context "with valid email, password" do
      it "Login Success" do
        post :login, params: valid_attributes, session: valid_session
        expect(response).to be_successful
        expect(response.content_type).to include('application/json')
      end
    end

    context "with invalid params" do
      it "Login Fails" do
        post :login, params: invalid_attributes, session: valid_session
        expect(response).to have_http_status(:unauthorized)
        expect(response.content_type).to include('application/json')
      end
      it "Login Fails with wrong email" do
        post :login, params: invalid_attributes_email, session: valid_session
        expect(response).to have_http_status(:unauthorized)
        expect(response.content_type).to include('application/json')
      end
      it "Login Fails with wrong password" do
        post :login, params: invalid_attributes_password, session: valid_session
        expect(response).to have_http_status(:unauthorized)
        expect(response.content_type).to include('application/json')
      end
    end
  end


end