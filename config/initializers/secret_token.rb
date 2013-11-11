# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
require 'securerandom'

def secure_token
  token_file = Rails.root.join('.secret')
  if File.exist?(token_file)
    # Use the existing token.
    File.read(token_file).chomp
  else
    # Generate a new token and store it in token_file.
    token = SecureRandom.hex(64)
    File.write(token_file, token)
    token
  end
end

AmsProject::Application.config.secret_key_base = secure_token
#AmsProject::Application.config.secret_key_base = '5df97994a358384a9751c613f435731182d35c3cc56963df4aa4a627200d0ed30bfb4bf17047f5f5eeb28b2c60c69b39fdbd89a2726950d1912242362dbc4fec'
