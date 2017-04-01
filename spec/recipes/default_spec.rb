# encoding: utf-8
# frozen_string_literal: true

require_relative '../spec_helper'

describe 'visual_studio_code::default' do
  let(:platform) { { platform: 'ubuntu', version: '16.04' } }
  let(:runner) { ChefSpec::SoloRunner.new(platform) }
  let(:chef_run) { runner.converge(described_recipe) }

  it 'installs a visual_studio_code_app' do
    expect(chef_run).to install_visual_studio_code_app('default')
  end
end
