require 'spec_helper'

require 'guard-nunit/result_parser'

ResultParser = Guard::NUnit::ResultParser

describe Guard::NUnit::ResultParser do

  it 'should parse tests run' do
    parser = ResultParser.new( 'Tests run: 1234' )
    parser.tests_run.should == 1234
  end

  it 'should parse failed tests' do
    parser = ResultParser.new( 'Tests run: 1234, Failures: 5' )
    parser.failures.should == 5
  end

  it 'should parse time' do
    parser = ResultParser.new( 'Tests run: 1234, Time: 1.23 seconds' )
    parser.run_time.should == '1.23 seconds'
  end

  it 'should parse passing tests' do
    parser = ResultParser.new( 'Tests run: 1, Failures: 2, Not run: 3, Time: 4.265 seconds' )

    parser.tests_run.should == 1
    parser.failures.should == 2
    parser.run_time.should == '4.265 seconds'
  end

  it 'should parse multiple lines' do
    lines = ".\nTests run: 109, Failures: 0, Not run: 0, Time: 4.265 seconds"

    parser = ResultParser.new( lines )
    parser.tests_run.should == 109
  end

  describe 'is_passing' do
    it 'should be true if all tests passed' do
      parser = ResultParser.new( 'Tests run: 1234, Failures: 0' )
      parser.is_passing.should be_true
    end
  end
end
