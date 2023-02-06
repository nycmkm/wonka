require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/giveaways", type: :request do
  before do
    @user = create(:user)
    sign_in @user
  end

  # This should return the minimal set of attributes required to create a valid
  # Giveaway. As you add validations to Giveaway, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      event_id: create(:event).id,
      prize: "Unikorn Commission",
      num_winners: 4,
      user_id: @user.id,
    }
  }

  let(:invalid_attributes) {
    { prize: "" } # Missing everything
  }

  describe "GET /index" do
    it "renders a successful response" do
      Giveaway.create! valid_attributes
      get giveaways_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      giveaway = Giveaway.create! valid_attributes
      get giveaway_url(giveaway)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_giveaway_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      giveaway = Giveaway.create! valid_attributes
      get edit_giveaway_url(giveaway)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Giveaway" do
        expect {
          post giveaways_url, params: { giveaway: valid_attributes }
        }.to change(Giveaway, :count).by(1)
      end

      it "redirects to the created giveaway" do
        post giveaways_url, params: { giveaway: valid_attributes }
        expect(response).to redirect_to(giveaway_url(Giveaway.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Giveaway" do
        expect {
          post giveaways_url, params: { giveaway: invalid_attributes }
        }.to change(Giveaway, :count).by(0)
      end


      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post giveaways_url, params: { giveaway: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end

    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      before do
        @new_num_winners = 41
      end

      let(:new_attributes) {
        { num_winners: @new_num_winners }
      }

      it "updates the requested giveaway" do
        giveaway = Giveaway.create! valid_attributes
        patch giveaway_url(giveaway), params: { giveaway: new_attributes }
        giveaway.reload
        expect(giveaway.num_winners).to eq(@new_num_winners)
      end

      it "redirects to the giveaway" do
        giveaway = Giveaway.create! valid_attributes
        patch giveaway_url(giveaway), params: { giveaway: new_attributes }
        giveaway.reload
        expect(response).to redirect_to(giveaway_url(giveaway))
      end
    end

    context "with invalid parameters" do

      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        giveaway = Giveaway.create! valid_attributes
        patch giveaway_url(giveaway), params: { giveaway: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end

    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested giveaway" do
      giveaway = Giveaway.create! valid_attributes
      expect {
        delete giveaway_url(giveaway)
      }.to change(Giveaway, :count).by(-1)
    end

    it "redirects to the giveaways list" do
      giveaway = Giveaway.create! valid_attributes
      delete giveaway_url(giveaway)
      expect(response).to redirect_to(giveaways_url)
    end
  end
end
