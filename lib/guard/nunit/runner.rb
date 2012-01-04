require 'pathname'

module Guard
  class NUnit
    class Runner

      attr_reader :nunit_command

      def initialize( options = { } )
        @options = { 
          :command_options => '-nologo',
          :version => '2.0'
        }.merge( options )
      end

      def mono_path
        return @mono_path if @mono_path

        path = which 'mono'

        @mono_path = path ? path.parent.parent : nil
      end

      def nunit_command
        return @nunit_command if @nunit_command

        @nunit_command = "#{mono_path}/Home/lib/mono/#{@options[ :version ]}/nunit-console.exe"
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

      # Cross-platform way of finding an executable in the $PATH.
      #
      #   which('ruby') #=> /usr/bin/ruby
      def which( cmd )
        exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']

        ENV[ 'PATH' ].split( File::PATH_SEPARATOR ).each do |path|
          exts.each do |ext|
            exe = "#{path}/#{cmd}#{ext}"
            return Pathname.new(exe).realpath if File.executable? exe
          end 
        end

        return nil
      end
    end
  end
end
