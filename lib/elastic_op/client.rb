# frozen_string_literal: true

require 'elasticsearch'

module ElasticOp
  class Client
    RETRY_ON_FAILURE = 3
    REQUEST_TIMEOUT = 60
    SSL_VERIFY = true
    SSL_CA = nil
    SSL_TIMEOUT = 30

    attr_reader :url, :username, :password, :logger

    def initialize(url:, username: nil, password: nil, logger: nil, **options)
      @url = url
      @username = username
      @password = password
      @logger = logger

      @options = options
    end

    def client
      auth_options = {
        user: username,
        password: password
      }.compact

      connection_options = {
        retry_on_failure: options.fetch(:retry_on_failure, RETRY_ON_FAILURE),
        request_timeout: options.fetch(:request_timeout, REQUEST_TIMEOUT)
      }.compact

      ssl_options = {
        verify: options.fetch(:ssl_verify, SSL_VERIFY),
        ca_file: options.fetch(:ca, SSL_CA),
        ssl_timeout: options.fetch(:ssl_timeout, SSL_TIMEOUT)
      }.compact

      @client ||= Elasticsearch::Client.new(
        host: url,
        **auth_options,
        **connection_options,
        transport_options: { ssl: ssl_options },
        log: logger
      )
    end

    def method_missing(method_name, *args, &block)
      if client.respond_to?(method_name)
        client.public_send(method_name, *args, &block)
      else
        super
      end
    end

    def respond_to_missing?(method_name, include_private = false)
      client.respond_to?(method_name, include_private) || super
    end
  end
end
