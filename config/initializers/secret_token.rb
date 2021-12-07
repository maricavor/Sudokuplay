
require File.join(Rails.root,'lib','openshift_secret_generator.rb')

# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.

Sudokuplay::Application.config.secret_token = 'a92f7aa8eb0a8491d51a1df10bd73893a0b809ed453d05ebd90e02d5f55bbb2396b229b5507a5562a42b18a4026aa0ba4059e3389f8a6fad1a6691fd61c209e5'

