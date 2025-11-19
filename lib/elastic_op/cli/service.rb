# frozen_string_literal: true

module ElasticOp
  class Cli
    class Service
      attr_reader :op

      def initialize(op:)
        @op = op
      end

      def logger
        op.logger
      end

      def options
        op.options
      end
    end
  end
end
