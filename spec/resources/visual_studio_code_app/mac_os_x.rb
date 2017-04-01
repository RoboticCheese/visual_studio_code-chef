# encoding: utf-8
# frozen_string_literal: true

require_relative '../visual_studio_code_app'

shared_context 'resources::visual_studio_code_app::mac_os_x' do
  include_context 'resources::visual_studio_code_app'

  let(:platform) { 'mac_os_x' }

  before do
    stub_command('which git').and_return('/usr/bin/git')
  end

  shared_examples_for 'any MacOS platform' do
    it_behaves_like 'any platform'

    context 'the :install action' do
      include_context description

      context 'all default properties' do
        include_context description

        it 'includes the homebrew recipe' do
          expect(chef_run).to include_recipe('homebrew')
        end

        it 'installs the VS Code Homebrew cask' do
          expect(chef_run).to install_homebrew_cask('visual-studio-code')
        end
      end

      context 'an overridden source property' do
        include_context description

        it 'raises an error' do
          expect { chef_run }.to raise_error(Chef::Exceptions::ValidationFailed)
        end
      end
    end

    context 'the :remove action' do
      include_context description

      context 'all default properties' do
        include_context description

        it 'includes the homebrew recipe' do
          expect(chef_run).to include_recipe('homebrew')
        end

        it 'uninstalls the VS Code Homebrew cask' do
          expect(chef_run).to uninstall_homebrew_cask('visual-studio-code')
        end
      end

      context 'an overridden source property' do
        include_context description

        it 'raises an error' do
          expect { chef_run }.to raise_error(Chef::Exceptions::ValidationFailed)
        end
      end
    end
  end
end
