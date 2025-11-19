# frozen_string_literal: true

require_relative 'cli/cluster'

module ElasticOp
  class Cli
    attr_reader :options

    def initialize(options: {})
      @options = options
    end

    def cluster
      @cluster ||= ElasticOp::Cli::Cluster.new
    end
  end
end
