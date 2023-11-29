img_src = ["'self'", "data:"]

if ENV["AWS_BUCKET_NAME"]
  img_src << "https://#{ENV["AWS_BUCKET_NAME"]}.s3.amazonaws.com"
end

SecureHeaders::Configuration.default do |config|
  config.csp = {
    default_src: ["'self'"],
    font_src: ["'self'", "data:"],
    img_src: img_src,
    script_src: ["'self'"],
    style_src: ["'self'", "'unsafe-inline'"],
  }
end
