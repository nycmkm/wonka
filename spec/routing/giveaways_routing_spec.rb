require "rails_helper"

RSpec.describe GiveawaysController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/giveaways").to route_to("giveaways#index")
    end

    it "routes to #new" do
      expect(get: "/giveaways/new").to route_to("giveaways#new")
    end

    it "routes to #show" do
      expect(get: "/giveaways/1").to route_to("giveaways#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/giveaways/1/edit").to route_to("giveaways#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/giveaways").to route_to("giveaways#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/giveaways/1").to route_to("giveaways#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/giveaways/1").to route_to("giveaways#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/giveaways/1").to route_to("giveaways#destroy", id: "1")
    end
  end
end
