"""
Providers for the ruby libraries and Ruby Runtime context
"""

RubyLibraryInfo = provider (
  fields = {
    "deps" : "A depset",
    "info" : "info",
  }
)

RubyContext = provider(
  fields = {
    "bin" : "bin",
    "info" : "info",
  }
)
