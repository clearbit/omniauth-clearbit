# OmniAuth Clearbit

This is the official OmniAuth strategy for authenticating to Clearbit.

## Basic Usage

    use OmniAuth::Builder do
      provider :clearbit, ENV['CLEARBIT_KEY'], ENV['CLEARBIT_SECRET']
    end

## Advanced Usage

To use this strategy against local, dev, or staging environments you'll need to
override the values in that are [hardcoded for production](lib/omniauth/strategies/clearbit.rb#L4:L8) for the appropriate environment.

In dev, this might look like

    use OmniAuth::Builder do
        provider :clearbit,
          ENV['CLEARBIT_CONSUMER_KEY'],
          ENV['CLEARBIT_CONSUMER_SECRET'],
          client_options: {
            site:          ENV['OMNIAUTH_CLEARBIT_SITE'].presence,
            authorize_url: ENV['OMNIAUTH_CLEARBIT_AUTHORIZE_URL'].presence,
            token_url:     ENV['OMNIAUTH_CLEARBIT_TOKEN_URL'].presence
          }
      end

The actual ENV values should reflect the env you are working in - i.e. in development,
the `OMNIAUTH_CLEARBIT_SITE` var should be set to the root dev url for APIHub.
