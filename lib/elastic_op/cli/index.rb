# frozen_string_literal: true

module ElasticOp
  class Cli
    class Index < Service
      def list(index_patterns, options: {})
        logger.debug("Index#list listing pattern_filters:#{index_patterns}")

        indices = op.indices.list(index_pattern: index_patterns.first, **options)

        if indices.empty?
          logger.debug('Index#list no indices found !')
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
    end
  end
end
