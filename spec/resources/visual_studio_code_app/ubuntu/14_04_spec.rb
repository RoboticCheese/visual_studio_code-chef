# encoding: utf-8
# frozen_string_literal: true

require_relative '../ubuntu'

describe 'resources::visual_studio_code_app::ubuntu::14_04' do
  include_context 'resources::visual_studio_code_app::ubuntu'

  let(:platform_version) { '14.04' }

  it_behaves_like 'any Ubuntu platform'
end
