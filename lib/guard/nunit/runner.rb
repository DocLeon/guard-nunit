module Guard
  class NUnit
    class Runner

      attr_reader :nunit_command

      def initialize( options = { } )
        @options = { 
          :command_options => '-nologo'
        }.merge( options )

        # Default command
        @nunit_command = 'nunit-console'

        @nunit_command << '4' if options[ :version ] == '4.0'

        # Version 2.0 - 3.5 needs to run nunit-console2
        if %w{ 2.0 3.0 3.5 }.include?( options[ :version ] )
          @nunit_command << '2'
        end
      end

      def command_options
        @options[ :command_options ]
      end

      def get_command( files )
        command = nunit_command
        command << " #{command_options}" unless command_options.empty? or command_options.nil?

        if files.respond_to?( :join )
          command << " #{files.join(' ')}" if files.respond_to?(:join)
        else
          command << " #{files}" if files.is_a?(String)
        end

        command
      end
      
      def execute( paths )
        `#{get_command( paths )}`
      end
    end
  end
end
