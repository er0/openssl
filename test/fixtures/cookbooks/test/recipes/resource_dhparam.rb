#
# Cookbook Name:: test
# Recipe:: resource_dhparam
#
# Copyright:: Copyright (c) 2015, Chef Software, Inc. <legal@chef.io>
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

apt_update 'update' if platform_family?('debian')

# Ensure files are not present, so the lwrp makes new keys every time
file 'any potential existing key' do
  path '/etc/ssl_test/dhparam.pem'
  action :delete
end

# Create directory if not already present
directory '/etc/ssl_test' do
  recursive true
end

# Generate new key and certificate
openssl_dhparam '/etc/ssl_test/dhparam.pem' do
  key_length 1024
  action :create
end
