# in spec/support/omniauth_macros.rb
module OmniauthMacros
  def mock_auth_hash_for(user)
    # The mock_auth configuration allows you to set per-provider (or default)
    # authentication hashes to return during integration testing.

    OmniAuth.config.add_mock(user.provider.to_sym, {
      'provider' => user.provider,
      'uid' => user.uid,
      'info' => {
        'first_name' => user.first_name,
        'last_name' => user.last_name,
        'email' => user.user_name
      }
    })
  end
end
