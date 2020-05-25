# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

##
# A script that is used to verify that a ruby_binary rule works
# Is a two-parter. This is the second part.
# Requires a libary from ruby standard libraries and uses its function
#
def words
  require 'shellwords'
  Shellwords.split('"Hello World" from Ruby')
end
