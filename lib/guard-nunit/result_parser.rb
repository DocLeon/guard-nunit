module Guard
  module NUnit
    class ResultParser

      attr_reader :tests_run
      attr_reader :failures
      attr_reader :run_time

      def initialize( results )
        results.each_line do |line|
          parse_line line
        end
      end

      def is_passing
        @failures == 0
      end

    private

      def parse_line( line )
        /^Tests run: (\d+)/.match( line ) do |m|
          @tests_run = m[1].to_i
        end

        /^Tests run:.*Failures: (\d+)/.match( line ) do |m|
          @failures = m[1].to_i
        end

        /^Tests run:.*Time: (.*)$/.match( line ) do |m|
          @run_time = m[1]
        end
      end

    end
  end
end
