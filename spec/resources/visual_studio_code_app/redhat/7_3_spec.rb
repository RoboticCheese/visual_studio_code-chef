# encoding: utf-8
# frozen_string_literal: true

require_relative '../redhat'

describe 'resources::visual_studio_code_app::redhat::7_3' do
  include_context 'resources::visual_studio_code_app::redhat'

  let(:platform_version) { '7.3' }

  it_behaves_like 'any Red Hat platform'
end
