require 'guard/notifier'

module Guard
  class NUnit
    class Notification
      def self.build_message( duration, tests, failures, pending = nil )
        message = "Tests run: #{tests}"
        message << ", Failures: #{failures}" 
        message << ", Pending: #{pending}" if pending

        message << "\nTime: #{duration}"

        message
      end

      def self.notify( message, success )
        options = {
          :title => 'NUnit results'
        }

        if success
          options.merge!({ :image => :success, :priority => -2 })
        else
          options.merge!({ :image => :failed, :priority => 2 })
        end
        ::Guard::Notifier.notify( message, options )
      end

      def self.notify_results( duration, tests, failures, pending = nil )
        message = self.build_message( duration, tests, failures, pending )

        self.notify( message, failures == 0 )
      end
    end
  end
end
