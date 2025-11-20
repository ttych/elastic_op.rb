# frozen_string_literal: true

module ElasticOp
  class Op
    class Response
      attr_reader :response

      def initialize(response)
        @response = response
      end

      def acknowledged?
        return true if response['acknowledged']

        false
      end

      def failed?
        !acknowledged?
      end
    end
  end
end
