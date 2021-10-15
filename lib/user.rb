# frozen_string_literal: true

require_relative 'record_base'

# class User
class User < RecordBase
  enum status: %i[active inactive], default: :active
  attribute :name
end
