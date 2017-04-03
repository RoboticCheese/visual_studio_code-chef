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

        let(:installed?) { nil }

        before do
          allow(Dir).to receive(:exist?).and_call_original
          allow(Dir).to receive(:exist?)
            .with('/Applications/Visual Studio Code.app')
            .and_return(installed?)
        end

        context 'not already installed' do
          let(:installed?) { false }

          it 'downloads the VSCode .zip file' do
            expect(chef_run).to create_remote_file(
              "#{Chef::Config[:file_cache_path]}/vscode.zip"
            ).with(source: 'https://vscode-update.azurewebsites.net/latest/' \
                            'darwin/stable')
          end

          it 'extracts the VSCode .zip file' do
            expect(chef_run).to run_execute('Extract Visual Studio Code')
              .with(command: 'unzip -d /Applications ' \
                             "#{Chef::Config[:file_cache_path]}/vscode.zip")
          end
        end

        context 'already installed' do
          let(:installed?) { true }

          it 'does not download the VSCode .zip file' do
            expect(chef_run).to_not create_remote_file(
              "#{Chef::Config[:file_cache_path]}/vscode.zip"
            )
          end

          it 'does not extract the VSCode .zip file' do
            expect(chef_run).to_not run_execute('Extract Visual Studio Code')
          end
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

        [
          '~/Library/Saved Application State/com.microsoft.VSCode.savedState',
          '~/Library/Preferences/com.microsoft.VSCode.plist',
          '~/Library/Preferences/com.microsoft.VSCode.helper.plist',
          '~/Library/Caches/com.microsoft.VSCode.ShipIt',
          '~/Library/Caches/com.microsoft.VSCode',
          '~/Library/Application Support/Code',
          '~/.vscode',
          '/Applications/Visual Studio Code.app'
        ].each do |d|
          it "deletes the #{d} directory" do
            expect(chef_run).to delete_directory(File.expand_path(d))
              .with(recursive: true)
          end
        end
      end
    end
  end
end
