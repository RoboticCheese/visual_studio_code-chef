# encoding: utf-8
# frozen_string_literal: true

name 'visual_studio_code'
maintainer 'Jonathan Hartman'
maintainer_email 'j@hartman.io'
license 'apachev2'
description 'Installs/configures Visual Studio Code'
long_description 'Installs/configures Visual Studio Code'
version '0.0.1'
chef_version '>= 12.1'

source_url 'https://github.com/RoboticCheese/visual_studio_code-chef'
issues_url 'https://github.com/RoboticCheese/visual_studio_code-chef/issues'

depends 'chocolatey', '~> 1.1'
depends 'dmg', '~> 3.0'
depends 'homebrew', '~> 3.0'

supports 'mac_os_x'
supports 'windows'
supports 'ubuntu'
supports 'debian'
