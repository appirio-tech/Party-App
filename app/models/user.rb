class User < ActiveRecord::Base
  def self.from_auth(auth)
    user = User.send("find_by_#{auth['provider']}_id", auth['uid'])
    
    unless user
      user = User.create! do |u|
        u.name = auth['user_info']['name']

        case auth['provider']
          when 'twitter'
            u.twitter_id = auth['uid']
            u.twitter_token = auth['credentials']['token']
            u.twitter_secret = auth['credentials']['secret']
            u.twitter_name = auth['user_info']['nickname']
            u.image = "http://img.tweetimag.es/i/#{u.twitter_name}_n"
          when 'facebook'
            u.facebook_id = auth['uid']
            u.facebook_token = auth['credentials']['token']
            u.email = auth['email']
            u.image = auth['user_info']['image']
        end
      end
    end

    user
  end
end
