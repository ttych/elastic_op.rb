# frozen_string_literal: true

require_relative 'response'

module ElasticOp
  class Op
    class Dangling < Service
      def get
        response = op.client.dangling_indices.list_dangling_indices
        response['dangling_indices'].each do |dangling_index|
          creation_date_millis = dangling_index.delete('creation_date_millis')
          dangling_index['creation_date_millis'] =
            Time.at(creation_date_millis / 1000.0)
        end
      end

      def import(index_uuid)
        response = op.client.dangling_indices.import_dangling_index(
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
