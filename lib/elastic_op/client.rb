# frozen_string_literal: true

require 'elasticsearch'

module ElasticOp
  class Client
    RETRY_ON_FAILURE = 3
    REQUEST_TIMEOUT = 60
    SSL_VERIFY = true
    SSL_CA = nil

    attr_reader :url, :username, :password, :logger, :options

    def initialize(url:, username: nil, password: nil, logger: nil, **options)
      @url = url
      @username = username
      @password = password
      @logger = logger

      @options = options
    end

    def client
      @client ||= Elasticsearch::Client.new(
        **_client_options
      )
    end

    def _client_options
      {
        host: url,
        user: username,
        password: password,
        transport_options: {
          ssl: {
            verify: options.fetch(:ssl_verify, SSL_VERIFY),
            ca_file: options.fetch(:ca, SSL_CA)
          }.compact
        },
        retry_on_failure: options.fetch(:retry_on_failure, RETRY_ON_FAILURE),
        request_timeout: options.fetch(:request_timeout, REQUEST_TIMEOUT),
        logger: logger,
        tracer: logger
      }.compact
    end

    def method_missing(method_name, *, &)
      if client.respond_to?(method_name)
        client.public_send(method_name, *, &)
      else
        super
      end
    end

    def respond_to_missing?(method_name, include_private = false)
      client.respond_to?(method_name, include_private) || super
    end
  end
end
