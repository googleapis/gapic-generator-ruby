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
# A main file for a small application that is used to check that bazel
# can run ruby apps via bundler
#
require 'rainbow'

puts Rainbow("this is red").red + " and " + Rainbow("this on yellow bg").bg(:yellow) + " and " + Rainbow("even bright underlined!").underline.bright
