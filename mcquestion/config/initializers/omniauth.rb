OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '694790013305-vdf6g5qdg3tffc0bpbie383eebmhoo6o.apps.googleusercontent.com', 'DKrWh07fKApIwsbTFSjOQngM', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end