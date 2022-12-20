Rails.configuration.git_revision = if ENV["GIT_VERSION"]
                                     ENV["GIT_VERSION"]
                                   else
                                     `git rev-parse HEAD`.strip
                                   end

Rails.logger.info "Wonka running with revision #{Rails.configuration.git_revision}"
