# frozen_string_literal: true

require_relative 'spec_helper'

require 'user'

RSpec.describe User do
  context 'with default value' do
    it '#name' do
      expect(subject.name).to eql('admin')
    end

    it '#status' do
      expect(subject.status).to eql(:active)
    end

    it '#to_s' do
      expect(subject.to_s).to be_a(Hash)
    end
  end

  context 'with custom value' do
    it '#name' do
      subject.name = 'John'
      expect(subject.name).to eql('John')
    end

    it '#status' do
      subject.status = :inactive
      expect(subject.status).to eql(:inactive)
    end
  end

  context 'Enums' do
    it '#active!' do
      subject.active!
      expect(subject.status).to eql(:active)
    end

    it '#active?' do
      subject.active!
      expect(subject.active?).to be_truthy
    end

    it '#inactive!' do
      subject.inactive!
      expect(subject.status).to eql(:inactive)
    end

    it '#inative?' do
      subject.inactive!
      expect(subject.inactive?).to be_truthy
    end
  end

  context 'raise ArgumentError' do
    it '#new' do
      expect { User.new(teste: 'Alef') }.to raise_error(ArgumentError).with_message('Attribute teste is not defined')
    end
  end
end
