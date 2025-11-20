# frozen_string_literal: true

module ElasticOp
  class Cli
    class Index < Service
      def get(index_patterns, options: {})
        logger.debug("Index#get index_patterns:#{index_patterns}")

        indices = op.indices.get(index_pattern: index_patterns.first, **options)

        if indices.empty?
          logger.debug('Index#get no indices found !')
          return 0
        end

        headings = ['Health', 'Status', 'Index Name', 'UUID', 'Pri', 'Rep', 'Docs', 'Size (MB)']
        rows = indices.map do |idx|
          [
            idx['health'],
            idx['status'],
            idx['index'],
            idx['uuid'],
            idx['pri'],
            idx['rep'],
            idx['docs.count'],
            idx['store.size']
          ]
        end
        table = Terminal::Table.new(headings: headings, rows: rows)
        puts table
      end

      def cat(index_patterns, options: {})
        logger.debug("Index#cat index_patterns:#{index_patterns}")

        indices = op.indices.cat(options)
        puts indices
      end
    end
  end
end
