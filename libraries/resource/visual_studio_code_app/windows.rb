# encoding: utf-8
# frozen_string_literal: true

#
# Cookbook Name:: visual_studio_code
# Library:: resource/visual_studio_code_app/windows
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
      class Windows < VisualStudioCodeApp
        resource_name :visual_studio_code_app_windows

        provides :visual_studio_code_app, platform_family: 'windows'

        action :install do
          case new_resource.source
          when :repo
            include_recipe 'chocolatey'
            chocolatey 'visualstudiocode'
          when :direct
            package 'Visual Studio Code' do
              source 'https://vscode-update.azurewebsites.net/latest/win32/' \
                     'stable'
            end
          end
        end

        action :remove do
          case new_resource.source
          when :repo
            include_recipe 'chocolatey'
            chocolatey('visualstudiocode') { action :remove }
          when :direct
            package('Visual Studio Code') { action :remove }
          end
        end
      end
    end
  end
end
