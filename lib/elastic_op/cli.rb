# frozen_string_literal: true

require_relative '../elastic_op'

require_relative 'cli/cluster'
require_relative 'cli/index'
require_relative 'cli/shard'

module ElasticOp
  class Cli
    attr_reader :options

    def initialize(options: {})
      @options = options
    end

    def cluster
      @cluster ||= ElasticOp::Cli::Cluster.new(op: op)
    end

    def index
      @index ||= ElasticOp::Cli::Index.new(op: op)
    end

    def shard
      @shard ||= ElasticOp::Cli::Shard.new(op: op)
    end

    def op
      @op ||= ElasticOp::Op.new(options: options)
    end
  end
end
