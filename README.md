Visual_studio_code Cookbook
===========================
[![Cookbook Version](https://img.shields.io/cookbook/v/visual_studio_code.svg)][cookbook]
[![Build Status](https://img.shields.io/travis/RoboticCheese/visual_studio_code-chef.svg)][travis]
[![Code Climate](https://img.shields.io/codeclimate/github/RoboticCheese/visual_studio_code-chef.svg)][codeclimate]
[![Coverage Status](https://img.shields.io/coveralls/RoboticCheese/visual_studio_code-chef.svg)][coveralls]

[cookbook]: https://supermarket.chef.io/cookbooks/visual_studio_code
[travis]: https://travis-ci.org/RoboticCheese/visual_studio_code-chef
[codeclimate]: https://codeclimate.com/github/RoboticCheese/visual_studio_code-chef
[coveralls]: https://coveralls.io/r/RoboticCheese/visual_studio_code-chef

A Chef cookbook for Microsoft Visual Studio Code.

Requirements
============

This cookbook requires Chef 12+.

Usage
=====

Either add the included default recipe to your node's run list or call the
custom resources directly.

Recipes
=======

***default***

Installs Visual Studio Code.

Attributes
==========

***default***

Resources
=========

***visual_studio_code_app***

Manages installation of the Visual Studio Code packages.

Syntax:

    visual_studio_code_app 'default' do
      source :homebrew
      action :install
    end

Actions:

| Action     | Description                  |
|------------|------------------------------|
| `:install` | Install Visual Studio Code   |
| `:remove`  | Uninstall Visual Studio Code |

Properties:

| Property | Default     | Description                    |
|----------|-------------|--------------------------------|
| source   | `:homebrew` | Source to install the app from |
| action   | `:install`  | Action(s) to perform           |

Contributing
============

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Add tests for the new feature; ensure they pass (`rake`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request

License & Authors
=================

- Author: Jonathan Hartman <j@hartman.io>

Copyright:: 2017, Jonathan Hartman

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
