# frozen_string_literal: true

require 'logger'

module ElasticOp
  DEFAULT_LOGGER_LEVEL = Logger::INFO
  LOGGER_LEVEL_MAP = {
    debug: Logger::DEBUG,
    info: Logger::INFO,
    warn: Logger::WARN,
    error: Logger::ERROR,
    fatal: Logger::FATAL
  }.freeze

  def self.logger(log_level: :info)
    @logger ||= Logger.new($stderr).tap do |logger|
      logger_level = LOGGER_LEVEL_MAP[log_level.to_s.to_sym] || DEFAULT_LOGGER_LEVEL
      logger.level = logger_level
      logger.formatter = proc do |severity, datetime, _progname, msg|
        "#{datetime.strftime('%H:%M:%S')} [#{severity}] #{msg}\n"
      end

      logger.debug("Logger initialized with level: #{log_level}/#{logger_level}")
    end
  end
end
