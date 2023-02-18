SecureHeaders::Configuration.default do |config|
  config.csp = {
    default_src: ["'self'"],
    font_src: ["'self'", "data:"],
    img_src: ["'self'", "data:"],
    script_src: ["'self'"],
    style_src: ["'self'", "'unsafe-inline'"],
  }
end
