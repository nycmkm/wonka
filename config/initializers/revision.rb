Rails.configuration.git_revision = (ENV["GIT_VERSION"] || `git rev-parse HEAD`.strip)

Rails.logger.info "Wonka running with revision #{Rails.configuration.git_revision}"
