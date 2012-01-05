require 'pathname'
require 'guard/nunit/runner'

module Guard
  class NUnit
    class MonoRunner < Runner

      def initialize( options = { } )
        super( options )
      end

      # Command line for running nunit
      def nunit_command
        return @nunit_command if @nunit_command

        @nunit_command = "exec #{mono_command} #{nunit_path( @options[ :version ] )}"
      end
 
      # Path to the mono
      def mono_command
        @mono_command = which 'mono' unless @mono_command
        @mono_command
      end

      # Root path of the mono installation
      def mono_path
        return nil if mono_command.nil?
        mono_command.parent.parent
      end

      # Path to nunit exe
      def nunit_path( version )
        "#{mono_path}/Home/lib/mono/#{version}/nunit-console.exe"
      end
    end
  end
end
