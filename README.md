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
          ENV['CLEARBIT_KEY'],
          ENV['CLEARBIT_CONSUMER_SECRET'],
          client_options: {
            site:          'https://apihub.dev.clearbit.io',
            authorize_url: 'https://apihub.dev.clearbit.io/oauth/authorize',
            token_url:     'https://apihub.dev.clearbit.io/oauth/access_token'
          }
      end
