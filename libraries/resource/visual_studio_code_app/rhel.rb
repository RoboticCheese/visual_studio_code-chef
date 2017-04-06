# encoding: utf-8
# frozen_string_literal: true

#
# Cookbook Name:: visual_studio_code
# Library:: resource/visual_studio_code_app/rhel
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
      class Rhel < VisualStudioCodeApp
        resource_name :visual_studio_code_app_rhel

        provides :visual_studio_code_app, platform_family: 'rhel'

        action :install do
          case new_resource.source
          when :repo
            yum_repository 'visual_studio_code' do
              baseurl 'https://packages.microsoft.com/yumrepos/vscode'
              gpgkey 'https://packages.microsoft.com/keys/microsoft.asc'
            end

            package 'code'
          when :direct
            return if ::File.exist?('/usr/bin/code')

            dest = ::File.join(Chef::Config[:file_cache_path], 'vscode.rpm')

            remote_file dest do
              source 'https://vscode-update.azurewebsites.net/latest/' \
                     'linux-rpm-x64/stable'
            end

            rpm_package 'code' do
              source dest
            end
          end
        end

        action :remove do
          package('code') { action :remove }
          yum_repository('visual_studio_code') { action :remove }
        end
      end
    end
  end
end
