# frozen_string_literal: true

require_relative 'service'

module ElasticOp
  class Op
    class Indices < Service
      def list(index_pattern: '*', **_options)
        []
      end
    end
  end
end
