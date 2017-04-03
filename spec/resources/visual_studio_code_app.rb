# encoding: utf-8
# frozen_string_literal: true

require_relative '../resources'

shared_context 'resources::visual_studio_code_app' do
  include_context 'resources'

  let(:resource) { 'visual_studio_code_app' }
  %i[source].each { |p| let(p) { nil } }
  let(:properties) { { source: source } }
  let(:name) { 'default' }

  shared_context 'the :install action' do
  end

  shared_context 'the :remove action' do
    let(:action) { :remove }
  end

  shared_context 'all default properties' do
  end

  shared_context 'an overridden source property' do
    let(:source) { :direct }
  end

  shared_examples_for 'any platform' do
    context 'the :install action' do
      include_context description

      it 'installs a visual_studio_code_app resource' do
        expect(chef_run).to install_visual_studio_code_app(name)
      end
    end

    context 'the :remove action' do
      include_context description

      it 'removes a visual_studio_code_app resource' do
        expect(chef_run).to remove_visual_studio_code_app(name)
      end
    end
  end
end
