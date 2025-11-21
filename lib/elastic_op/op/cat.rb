# frozen_string_literal: true

require_relative 'service'

module ElasticOp
  class Op
    class Cat < Service
      CAT_FORMAT = 'json'

      # INDICES_HEADERS = ['*']
      INDICES_HEADERS = [].freeze

      def indices(options: {})
        op.client.cat.indices(
          h: options.fetch(:headers, INDICES_HEADERS),
          format: options.fetch(:format, CAT_FORMAT)
        )
      end
    end
  end
end
