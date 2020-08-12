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

"""
Providers for the ruby libraries and Ruby Runtime context
"""

##
# A provider that encompasses a ruby library, e.g. a gem or a standard library
#
RubyLibraryInfo = provider (
  fields = {
    "deps" : "A depset of other libraries this one depends upon",
    "info" : "A struct covering the components of this library: its sources, lib and extlib paths",
  }
)

##
# A provider that encompasses a ruby runtime with ruby binaries
#
RubyContext = provider(
  fields = {
    "bin" : "A ruby binary",
    "all_bins" : "All the binaries that come with the ruby runtime (e.g. gem, rubocop, etc)",
    "info" : "A struct covering the library-component of the ruby runtime: its sources and lib path",
  }
)

BundledInstallContext = provider(
  fields = {
    "gemfile" : "the gemfile for the installation",
    "all_bundled_files": "all files in this bundled installation"
  }
)