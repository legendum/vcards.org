# Please setup env vars in the .env file
module LeanSignals
  def self.integrations
    {
# TODO: Fix this
#      facebook: %w(FACEBOOK_APP_ID FACEBOOK_APP_SECRET),
#      google_oauth2: %w(GOOGLE_CLIENT_ID GOOGLE_CLIENT_SECRET),
#      instagram: %w(INSTAGRAM_CLIENT_ID INSTAGRAM_CLIENT_SECRET),
#      twitter: %w(TWITTER_API_KEY TWITTER_API_SECRET),
    }
  end

  def self.integration_options
    {
      facebook:   { auth_type: 'reauthenticate',
                    scope: 'email' },
      twitter:    { authorize_params: { force_login: 'true' } },
    }
  end
end
