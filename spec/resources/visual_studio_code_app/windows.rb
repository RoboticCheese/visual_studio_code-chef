# encoding: utf-8
# frozen_string_literal: true

require_relative '../visual_studio_code_app'

shared_context 'resources::visual_studio_code_app::windows' do
  include_context 'resources::visual_studio_code_app'

  let(:platform) { 'windows' }

  shared_examples_for 'any Windows platform' do
    it_behaves_like 'any platform'

    context 'the :install action' do
      include_context description

      context 'all default properties' do
        include_context description

        it 'includes the chocolatey recipe' do
          expect(chef_run).to include_recipe('chocolatey')
        end

        it 'installs the VS Code Chocolatey package' do
          expect(chef_run).to install_chocolatey('visualstudiocode')
        end
      end

      context 'an overridden source property' do
        include_context description

        it 'installs the VS Code package' do
          expect(chef_run).to install_package('Visual Studio Code')
            .with(source: 'https://vscode-update.azurewebsites.net/latest/' \
                          'win32/stable')
        end
      end
    end

    context 'the :remove action' do
      include_context description

      context 'all default properties' do
        include_context description

        it 'includes the chocolatey recipe' do
          expect(chef_run).to include_recipe('chocolatey')
        end

        it 'removes the VS Code Chocolatey package' do
          expect(chef_run).to remove_chocolatey('visualstudiocode')
        end
      end

      context 'an overridden source property' do
        include_context description

        it 'removes the VS Code package' do
          expect(chef_run).to remove_package('Visual Studio Code')
        end
      end
    end
  end
end
