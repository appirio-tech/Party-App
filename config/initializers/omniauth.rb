OmniAuth.config.on_failure do |env|
  [500, {}, env['omniauth.error'].inspect]  
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'], mobile: true, scope: 'email,publish_stream'
end
