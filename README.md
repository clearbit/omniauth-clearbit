# OmniAuth Clearbit

This is the official OmniAuth strategy for authenticating to Clearbit.

## Basic Usage

    use OmniAuth::Builder do
      provider :clearbit, ENV['CLEARBIT_KEY'], ENV['CLEARBIT_SECRET']
    end
