# encoding: utf-8
# frozen_string_literal: true

#
# Cookbook Name:: visual_studio_code
# Library:: resource/visual_studio_code_app/debian
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
      class Debian < VisualStudioCodeApp
        resource_name :visual_studio_code_app_debian

        provides :visual_studio_code_app, platform_family: 'debian'

        action :install do
          case new_resource.source
          when :repo
            apt_repository 'visual_studio_code' do
              uri 'http://packages.microsoft.com/repos/vscode'
              components %w[main stable]
              key 'https://packages.microsoft.com/keys/microsoft.asc'
            end

            package 'code'
          when :direct
            return if ::File.exist?('/usr/bin/code')

            dest = ::File.join(Chef::Config[:file_cache_path], 'vscode.deb')

            remote_file dest do
              source 'https://vscode-update.azurewebsites.net/latest/' \
                     'linux-deb-x64/stable'
            end

            dpkg_package 'code' do
              source dest
            end
          end
        end

        action :remove do
          package('code') { action :purge }
          apt_repository('visual_studio_code') { action :remove }
        end
      end
    end
  end
end
