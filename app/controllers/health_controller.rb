class HealthController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    render json: {
      version: Rails.configuration.git_revision,
    }
  end
end
