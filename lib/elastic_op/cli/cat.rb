# frozen_string_literal: true

require_relative 'service'

module ElasticOp
  class Cli
    class Cat < Service
      def indices(options: {})
        logger.debug('cat#indices')

        indices = op.cat.indices(options: options)
        puts indices
      end
    end
  end
end
