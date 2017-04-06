# encoding: utf-8
# frozen_string_literal: true

require_relative 'rhel'

shared_context 'resources::visual_studio_code_app::centos' do
  include_context 'resources::visual_studio_code_app::rhel'

  let(:platform) { 'centos' }

  shared_examples_for 'any CentOS platform' do
    it_behaves_like 'any RHEL platform'
  end
end
