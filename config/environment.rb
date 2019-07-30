# frozen_string_literal: true

# Load the Rails application.
require_relative 'application'

require 'sigdump/setup'

Rails.logger = Logger.new(STDOUT)
Rails.logger.datetime_format = "%Y-%m-%d %H:%M:%S"

# Initialize the Rails application.
Rails.application.initialize!
