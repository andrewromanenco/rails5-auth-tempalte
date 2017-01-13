Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['OAUTH_GOOGLE_ID'], ENV['OATH_GOOGLE_SECRET'], {
    scope: ['profile'],
    access_type: 'offline'}
end
