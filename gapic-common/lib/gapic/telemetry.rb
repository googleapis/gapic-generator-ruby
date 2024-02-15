# Copyright 2024 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "gapic/common/error"

module Gapic
  ##
  # A module that provides methods for enabling telemetry instrumentation.  
  #
  module Telemetry
    class Tracer
        def no_op *_
            yield
        end

        def with_trace method_name            
          @tracer.in_span(method_name.to_s) do |task_span|
            yield
          end
        end

        def trace_enabled? config
            ENV['OTEL_INSTRUMENTATION_GCP_SDK_ENABLED'] || config.tracing_enabled
        end

        def initialize_trace_provider config
            require 'opentelemetry'
            @tracer = config.tracer_provider || OpenTelemetry.tracer_provider.tracer(config.lib_name, config.lib_version)
        end

        def get_trace_wrapper config
            if trace_enabled? config 
              initialize_trace_provider config
              return method(:with_trace)
            end
            method(:no_op)
        end
    end
  end  
end
