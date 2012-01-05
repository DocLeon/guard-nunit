require 'spec_helper'
require 'guard/nunit/mono_runner'

MonoRunner = Guard::NUnit::MonoRunner

describe Guard::NUnit::MonoRunner do
  let( :subject )

  describe '.NET version' do
    it 'should use nunit-console4 for version 4.0' do
      runner = MonoRunner.new( :version => '4.0' )
      runner.stub!( :mono_path ){ '/my/path' }
      runner.stub!( :mono_command ){ 'mono' }
      runner.nunit_command.should == 'exec mono /my/path/Home/lib/mono/4.0/nunit-console.exe'
    end

    it 'should use nunit-console2 for version 2.0' do
      runner = MonoRunner.new( :version => '2.0' )
      runner.stub!( :mono_path ){ '/my/path' }
      runner.stub!( :mono_command ){ 'mono' }
      runner.nunit_command.should == 'exec mono /my/path/Home/lib/mono/2.0/nunit-console.exe'
    end

    it 'should use nunit-console for other versions' do
      runner = MonoRunner.new
      runner.stub!( :mono_path ){ '/my/path' }
      runner.stub!( :mono_command ){ 'mono' }
      runner.nunit_command.should == 'exec mono /my/path/Home/lib/mono/2.0/nunit-console.exe'
    end
  end

  describe 'command options' do
    it 'should default to include nologo' do
      MonoRunner.new.command_options.should include( '-nologo' )
    end

    it 'should allow overridding options' do
      MonoRunner.new( :command_options => '-my-option' ).command_options.should == '-my-option'
    end
  end

  describe 'command' do
    it 'should use nunit_command option' do
      runner = MonoRunner.new( :command_options => '' )
      runner.stub!( :nunit_command ){ 'my-command' }

      runner.get_command( 'my_dll.dll' ).should == 'my-command my_dll.dll'
    end

    it 'should use command options' do
      runner = MonoRunner.new( :command_options => '-my-option' )
      runner.get_command( 'my_dll.dll' ).should =~ /-my-option my_dll\.dll$/
    end

    it 'should handle multiple files' do
      runner = MonoRunner.new
      runner.get_command( ['my_dll.dll', 'my_other_dll.dll'] ).should =~
        /-nologo my_dll\.dll my_other_dll\.dll$/
    end
  end

  describe 'which' do
    before :each do
      ENV['PATH'] = '/my/path'
      ENV['PATHEXT'] = nil
    end

    it 'should return path to executable' do
      File.stub!( :executable? ){ true }
      
      Pathname.stub!( :new ) do
        mock( 'pathname', :realpath => '/my/path/myexe' )
      end

      MonoRunner.new.which( 'myexe' ).should == '/my/path/myexe'
    end

    it 'should return nil if missing file' do
      File.stub!( :executable? ){ false }

      MonoRunner.new.which( 'myexe' ).should be_nil
    end

  end

  describe 'mono_path' do
    
    it 'should return path to mono' do
      runner = MonoRunner.new

      runner.stub!( :which ) do
        mock( 'path', :parent => mock( 'path', :parent => '/my/path' ) )
      end

      runner.mono_path.should == '/my/path'
    end
  end

end
