Rails.configuration.git_revision = if ENV["GIT_COMMIT"]
                                     ENV["GIT_COMMIT"]
                                   else
                                     `git rev-parse HEAD`.strip
                                   end

Rails.logger.info "Wonka running with revision #{Rails.configuration.git_revision}"
