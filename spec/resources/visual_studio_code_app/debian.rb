# encoding: utf-8
# frozen_string_literal: true

require_relative '../visual_studio_code_app'

shared_context 'resources::visual_studio_code_app::debian' do
  include_context 'resources::visual_studio_code_app'

  let(:platform) { 'debian' }

  shared_examples_for 'any Debian platform' do
    it_behaves_like 'any platform'

    context 'the :install action' do
      include_context description

      context 'all default properties' do
        include_context description

        it 'adds the VS Code APT repo' do
          expect(chef_run).to add_apt_repository('visual_studio_code')
            .with(uri: 'http://packages.microsoft.com/repos/vscode',
                  components: %w[main stable],
                  key: 'https://packages.microsoft.com/keys/microsoft.asc')
        end

        it 'installs the VS Code package' do
          expect(chef_run).to install_package('code')
        end
      end

      context 'an overridden source property' do
        include_context description

        it 'downloads the VS Code package' do
          expect(chef_run).to create_remote_file(
            "#{Chef::Config[:file_cache_path]}/vscode.deb"
          ).with(source: 'https://vscode-update.azurewebsites.net/latest/' \
                          'linux-deb-x64/stable')
        end

        it 'installs the VS Code package' do
          expect(chef_run).to install_dpkg_package('code')
            .with(source: "#{Chef::Config[:file_cache_path]}/vscode.deb")
        end
      end
    end

    context 'the :remove action' do
      include_context description

      it 'purges the VS code package' do
        expect(chef_run).to purge_package('code')
      end

      it 'removes the VS Code APT repo' do
        expect(chef_run).to remove_apt_repository('visual_studio_code')
      end
    end
  end
end
