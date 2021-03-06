# encoding: utf-8
# frozen_string_literal: true

#
# Cookbook Name:: visual_studio_code
# Library:: resource/visual_studio_code_app/mac_os_x
#
# Copyright 2017, Jonathan Hartman
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require_relative '../visual_studio_code_app'

class Chef
  class Resource
    class VisualStudioCodeApp < Resource
      # A Chef resource for managing the Visual Studio Code app.
      #
      # @author Jonathan Hartman <j@hartman.io>
      class MacOsX < VisualStudioCodeApp
        resource_name :visual_studio_code_app_mac_os_x

        provides :visual_studio_code_app, platform_family: 'mac_os_x'

        action :install do
          case new_resource.source
          when :repo
            include_recipe 'homebrew'
            homebrew_cask 'visual-studio-code'
          when :direct
            return if ::Dir.exist?('/Applications/Visual Studio Code.app')

            dest = ::File.join(Chef::Config[:file_cache_path], 'vscode.zip')

            remote_file dest do
              source 'https://vscode-update.azurewebsites.net/latest/' \
                     'darwin/stable'
            end

            execute 'Extract Visual Studio Code' do
              command "unzip -d /Applications #{dest}"
            end
          end
        end

        action :remove do
          case new_resource.source
          when :repo
            include_recipe 'homebrew'
            homebrew_cask('visual-studio-code') { action :uninstall }
          when :direct
            [
              '~/Library/Saved Application State/' \
                'com.microsoft.VSCode.savedState',
              '~/Library/Preferences/com.microsoft.VSCode.plist',
              '~/Library/Preferences/com.microsoft.VSCode.helper.plist',
              '~/Library/Caches/com.microsoft.VSCode.ShipIt',
              '~/Library/Caches/com.microsoft.VSCode',
              '~/Library/Application Support/Code',
              '~/.vscode',
              '/Applications/Visual Studio Code.app'
            ].each do |d|
              directory ::File.expand_path(d) do
                recursive true
                action :delete
              end
            end
          end
        end
      end
    end
  end
end
