module Guard
  module NUnit
    class ResultParser

      # Number of tests run
      attr_reader :tests_run

      # Number of failures
      attr_reader :failures

      # Run time
      attr_reader :run_time

      def initialize( results )
        results.each_line do |line|
          parse_line line
        end
      end

      # Is the result a passing result?
      def is_passing?
        @failures == 0
      end

      # Does this parser have any results
      def has_results?
        return !@tests_run.nil?
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
