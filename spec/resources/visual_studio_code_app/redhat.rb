# encoding: utf-8
# frozen_string_literal: true

require_relative 'rhel'

shared_context 'resources::visual_studio_code_app::redhat' do
  include_context 'resources::visual_studio_code_app::rhel'

  let(:platform) { 'redhat' }

  shared_examples_for 'any Red Hat platform' do
    it_behaves_like 'any RHEL platform'
  end
end
