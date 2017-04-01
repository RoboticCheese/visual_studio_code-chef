# encoding: utf-8
# frozen_string_literal: true

require_relative '../spec_helper'

describe 'visual_studio_code::default::app' do
  describe directory('/Applications/Visual Studio Code.app') do
    it 'exists' do
      expect(subject).to exist
    end
  end
end
