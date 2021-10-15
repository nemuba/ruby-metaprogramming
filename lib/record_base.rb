# frozen_string_literal: true

# class RecordBase
class RecordBase
  @@attributes = []

  def initialize(**opts)
    opts.each do |key, value|
      raise ArgumentError, "Attribute #{key} is not defined" unless @@attributes.include?(key)

      instance_variable_set("@#{key}", value)
    end
  end

  def to_s
    instance_variables.map do |attribute|
      key = attribute.to_s.gsub('@', '')
      [key, instance_variable_get(attribute)]
    end.to_h
  end

  def self.enum(**opts)
    default = opts.delete(:default)
    opts.reject! { |k, _v| k.eql?(:default) }

    opts.each do |key, values|
      raise ArgumentError, 'Values must be an array' unless values.is_a?(Array)
      raise ArgumentError, 'Values must be exists in array' unless !default.nil? && values.include?(default)

      write_attribute(key, default: default)

      create_methods_values(key, values)
    end
  end

  def self.attribute(key, default: nil)
    write_attribute(key, default: default)
  end

  class << self
    private

    def write_attribute(key, default: nil)
      define_method(key) do
        instance_variable_get("@#{key}") || default
      end

      define_method("#{key}=") do |value = default|
        instance_variable_set("@#{key}", value)
      end

      @@attributes << key
    end

    def create_methods_values(key, values)
      raise ArgumentError, 'Values must be an array' unless values.is_a?(Array)

      values.each do |value|
        # add method bang
        define_method("#{value}!") do
          instance_variable_set("@#{key}", value)
        end

        # add method question
        define_method("#{value}?") do
          instance_variable_get("@#{key}") == value
        end
      end
    end
  end
end
