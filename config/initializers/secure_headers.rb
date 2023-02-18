SecureHeaders::Configuration.default do |config|
 config.csp = {
    default_src: %w('self'),
    font_src: %w('self' data:),
    img_src: %w('self' data:),
    script_src: %w('self'),
    style_src: %w('self' 'unsafe-inline'),
  }
end
