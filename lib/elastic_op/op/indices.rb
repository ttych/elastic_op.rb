# frozen_string_literal: true

require_relative 'service'

module ElasticOp
  class Op
    class Indices < Service
      LIST_FEATURES = %w[aliases mappings settings].freeze
      LIST_ALLOW_NO_INDICES = true

      def get(index: '*', options: {})
        op.client.indices.get(
          index: index,
          allow_no_indices: options.fetch(:allow_no_indices, LIST_ALLOW_NO_INDICES)
        )
      end
    end
  end
end
