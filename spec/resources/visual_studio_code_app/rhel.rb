# encoding: utf-8
# frozen_string_literal: true

require_relative '../visual_studio_code_app'

shared_context 'resources::visual_studio_code_app::rhel' do
  include_context 'resources::visual_studio_code_app'

  shared_examples_for 'any RHEL platform' do
    it_behaves_like 'any platform'

    context 'the :install action' do
      include_context description

      context 'all default properties' do
        include_context description

        it 'creates the VS Code YUM repo' do
          expect(chef_run).to create_yum_repository('visual_studio_code')
            .with(baseurl: 'https://packages.microsoft.com/yumrepos/vscode',
                  gpgkey: 'https://packages.microsoft.com/keys/microsoft.asc')
        end

        it 'installs the VS Code package' do
          expect(chef_run).to install_package('code')
        end
      end

      context 'an overridden source property' do
        include_context description

        it 'downloads the VS Code package' do
          expect(chef_run).to create_remote_file(
            "#{Chef::Config[:file_cache_path]}/vscode.rpm"
          ).with(source: 'https://vscode-update.azurewebsites.net/latest/' \
                          'linux-rpm-x64/stable')
        end

        it 'installs the VS Code package' do
          expect(chef_run).to install_rpm_package('code')
            .with(source: "#{Chef::Config[:file_cache_path]}/vscode.rpm")
        end
      end
    end

    context 'the :remove action' do
      include_context description

      it 'removes the VS code package' do
        expect(chef_run).to remove_package('code')
      end

      it 'removes the VS Code YUM repo' do
        expect(chef_run).to remove_yum_repository('visual_studio_code')
      end
    end
  end
end
