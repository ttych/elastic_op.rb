# frozen_string_literal: true

require_relative '../elastic_op'

require_relative 'cli/cluster'
require_relative 'cli/cat'
require_relative 'cli/indices'
require_relative 'cli/shard'
require_relative 'cli/dangling'

module ElasticOp
  class Cli
    attr_reader :options

    def initialize(options: {})
      @options = options
    end

    def cluster
      @cluster ||= ElasticOp::Cli::Cluster.new(op: op)
    end

    def cat
      @cat ||= ElasticOp::Cli::Cat.new(op: op)
    end

    def indices
      @indices ||= ElasticOp::Cli::Indices.new(op: op)
    end

    def shard
      @shard ||= ElasticOp::Cli::Shard.new(op: op)
    end

    def dangling
      @dangling ||= ElasticOp::Cli::Dangling.new(op: op)
    end

    def op
      @op ||= ElasticOp::Op.new(options: options)
    end
  end
end
