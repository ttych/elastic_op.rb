# frozen_string_literal: true

module ElasticOp
  class Op
    class Service
      attr_reader :op

      def initialize(op:)
        @op = op
      end

      def client
        op.client
      end

      def logger
        op.logger
      end

      def op_options
        op.options
      end
    end
  end
end
