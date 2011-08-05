Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  # provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'], mobile: true, scope: 'email,publish_stream'
  provider :salesforce, ENV['SALESFORCE_KEY'], ENV['SALESFORCE_SECRET']
end
