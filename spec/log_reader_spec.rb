require 'spec_helper'

module LogParserNotifier
  describe LogReader do
    let :log_reader do
      LogReader.new(File.join(Dir.pwd, 'spec', 'support', 'rails.log'))
    end

    after do
      FileUtils.cp 'spec/support/rails.log.back', 'spec/support/rails.log'
    end

    it 'when created it should start reading from the end of the file' do
      expect(log_reader.read_to_end).to eq('')
    end

    it 'should read the new lines if log file is updated after reading' do
      log_reader # force initialize
      FileUtils.cp 'spec/support/rails_with_new_requests.log', 'spec/support/rails.log'
      expect(log_reader.read_to_end.split("\n").count).to eq 41
    end

    it 'should never reread the same lines' do
      log_reader # force initialize
      FileUtils.cp 'spec/support/rails_with_new_requests.log', 'spec/support/rails.log'
      log_reader.read_to_end
      expect(log_reader.read_to_end).to eq ''
    end

    it 'should start from the beginning if the log file is rotated' do
      log_reader # force initialize
      FileUtils.cp 'spec/support/rails_rotated.log', 'spec/support/rails.log'
      expect(log_reader.read_to_end.split("\n").count).to eq 19
    end
  end
end
