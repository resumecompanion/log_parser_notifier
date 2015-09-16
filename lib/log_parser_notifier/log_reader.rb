module LogParserNotifier
  class LogReader
    def initialize(log_file)
      LogParserNotifier.logger.debug("creating log reader for: '#{log_file}'")
      @log_file = File.open(log_file, 'rb')
      @log_file.seek(@log_file.size, IO::SEEK_SET)
      LogParserNotifier.logger.debug("staring position at: #{@log_file.pos}")
    end

    def log_io
      @log_file.seek(0, IO::SEEK_SET) if @log_file.pos > @log_file.size

      @log_file
    end

    def read_to_end
      log_io.read
    end
  end
end
