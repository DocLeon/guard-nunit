require 'spec_helper'

require 'guard/nunit/notification'

Notification = Guard::NUnit::Notification

describe Guard::NUnit::Notification do
  describe 'build_message' do
    it 'should create message' do
      Notification.build_message( '1.23 seconds', 12, 0 ).should == 
        "Tests run: 12, Failures: 0\nTime: 1.23 seconds"
    end

    it 'should include pending' do
      Notification.build_message( '1.23 seconds', 12, 0, 1 ).should == 
        "Tests run: 12, Failures: 0, Pending: 1\nTime: 1.23 seconds"
    end
  end

  describe 'notify' do
    it 'should notify of success' do
      ::Guard::Notifier.should_receive( :notify ).with( 'message', :image => :success, :priority => -2, :title => 'NUnit results' )
      Notification.notify( 'message', true )
    end

    it 'should notify of failure' do
      ::Guard::Notifier.should_receive( :notify ).with( 'message', :image => :failed, :priority => 2, :title => 'NUnit results' )
      Notification.notify( 'message', false )
    end
  end

  describe 'notify_results' do
    it 'should notify of success' do
      message = "Tests run: 12, Failures: 0\nTime: 1.23 seconds"

      ::Guard::Notifier.should_receive( :notify ).with( message, :image => :success, :priority => -2, :title => 'NUnit results' )
      Notification.notify_results( '1.23 seconds', 12, 0 )
    end

    it 'should notify of failure' do
      message = "Tests run: 12, Failures: 1\nTime: 1.23 seconds"

      ::Guard::Notifier.should_receive( :notify ).with( message, :image => :failed, :priority => 2, :title => 'NUnit results' )
      Notification.notify_results( '1.23 seconds', 12, 1 )
    end
  end
end
