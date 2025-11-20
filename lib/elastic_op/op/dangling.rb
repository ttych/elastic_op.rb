# frozen_string_literal: true

require_relative 'response'

module ElasticOp
  class Op
    class Dangling < Service
      def get
        response = op.client.perform_request('GET', '_dangling')
        response['dangling_indices'].each do |dangling_index|
          dangling_index['creation_date_millis'] =
            Time.at(dangling_index['creation_date_millis'] / 1000.0).utc.iso8601(3)
        end
      end

      def import(index_uuid)
        response = client.dangling_indices.import_dangling_index(
          index_uuid: index_uuid,
          accept_data_loss: 'true'
        )
        Op::Response.new(response)
      end

      def delete(index_uuid)
        response = op.client.dangling_indices.delete_dangling_index(
          index_uuid: index_uuid,
          accept_data_loss: 'true'
        )
        Op::Response.new(response)
      end
    end
  end
end
