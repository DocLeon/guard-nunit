require 'spec_helper'

describe Guard::NUnit do
  let ( :default_options ){ { :all_on_start => true } }
  subject { Guard::NUnit.new }

  describe "start" do
    it 'should run all if all_on_start option is set' do
      subject.should_receive( :run_all )
      subject.start
    end
  end

  describe 'parse_results' do
    before :each do
      @parser = Guard::NUnit::ResultParser.new( '' )
      Guard::NUnit::ResultParser.stub!( :new ){ @parser }
      Guard::NUnit::Notification.stub( :notify_results ){ }
    end

    it 'should throw :task_has_failed on failure' do
      @parser.stub!( :is_passing? ){ false }

      lambda {
        subject.parse_results( '' )
      }.should throw_symbol :task_has_failed
    end
  end

end
