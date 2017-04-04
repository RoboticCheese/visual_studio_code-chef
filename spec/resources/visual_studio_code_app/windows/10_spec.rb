# encoding: utf-8
# frozen_string_literal: true

require_relative '../windows'

describe 'resources::visual_studio_code_app::windows::10' do
  include_context 'resources::visual_studio_code_app::windows'

  let(:platform_version) { '10' }

  it_behaves_like 'any Windows platform'
end
