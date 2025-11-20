# frozen_string_literal: true

module ElasticOp
  class Cli
    class Dangling < Service
      def list(options: {})
        dangling_indices = op.dangling.get

        if dangling_indices.empty?
          logger.debug('Dangling#list no indices found !')
          return 0
        end

        puts dangling_indices
      end

      def import(index_uuids: [], options: {})
        index_uuids.each do |index_uuid|
          response = op.dangling.import(index_uuid)
          if response.acknowledged?
            logger.debug("Dangling#import #{index_uuid} succeded")
          else
            logger.error("Dangling#import #{index_uuid} failed")
          end
        end
      end

      def delete(index_uuids: [], options: {})
        index_uuids.each do |index_uuid|
          response = op.dangling.delete(index_uuid)
          if response.acknowledged?
            logger.debug("Dangling#delete #{index_uuid} succeded")
          else
            logger.error("Dangling#delete #{index_uuid} failed")
          end
        end
      end
    end
  end
end
