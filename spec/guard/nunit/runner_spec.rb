require 'spec_helper'
require 'guard/nunit/runner'

Runner = Guard::NUnit::Runner

describe Guard::NUnit::Runner do
  let( :subject )

  describe '.NET version' do
    it 'should use nunit-console4 for version 4.0' do
      Runner.new( :version => '4.0' ).nunit_command.should == 'nunit-console4'
    end

    it 'should use nunit-console2 for version 2.0' do
      Runner.new( :version => '2.0' ).nunit_command.should == 'nunit-console2'
    end

    it 'should use nunit-console2 for version 3.0' do
      Runner.new( :version => '3.0' ).nunit_command.should == 'nunit-console2'
    end

    it 'should use nunit-console2 for version 3.5' do
      Runner.new( :version => '3.5' ).nunit_command.should == 'nunit-console2'
    end

    it 'should use nunit-console for other versions' do
      Runner.new.nunit_command.should == 'nunit-console'
    end
  end

  describe 'command options' do
    it 'should default to include nologo' do
      Runner.new.command_options.should include( '-nologo' )
    end

    it 'should allow overridding options' do
      Runner.new( :command_options => '-my-option' ).command_options.should == '-my-option'
    end
  end

  describe 'command' do
    it 'should use nunit_command option' do
      runner = Runner.new( :command_options => '' )
      runner.stub!( :nunit_command ){ 'my-command' }

      runner.get_command( 'my_dll.dll' ).should == 'my-command my_dll.dll'
    end

    it 'should use command options' do
      runner = Runner.new( :command_options => '-my-option' )
      runner.get_command( 'my_dll.dll' ).should == 'nunit-console -my-option my_dll.dll'
    end

    it 'should handle multiple files' do
      runner = Runner.new
      runner.get_command( ['my_dll.dll', 'my_other_dll.dll'] ).should == 
        'nunit-console -nologo my_dll.dll my_other_dll.dll'
    end
  end

end
