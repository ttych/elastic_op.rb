# frozen_string_literal: true

require_relative 'logging'
require_relative 'client'
require_relative 'op/cat'
require_relative 'op/indices'
require_relative 'op/dangling'

module ElasticOp
  class Op
    attr_reader :options

    def initialize(options: {})
      @options = options
    end

    def client
      @client ||= ElasticOp::Client.new(
        logger: logger,
        **options
      )
    end

    def logger
      @logger = ElasticOp.logger(log_level: options[:log_level])
    end

    def cat
      @cat ||= Op::Cat.new(op: self)
    end

    def indices
      @indices ||= Op::Indices.new(op: self)
    end
    alias index indices

    def dangling
      @dangling ||= Op::Dangling.new(op: self)
    end
  end
end
