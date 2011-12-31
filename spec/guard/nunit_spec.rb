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

end
