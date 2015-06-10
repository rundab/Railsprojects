class Event < ActiveRecord::Base
  self.primary_key = :event_id
  belongs_to :zone, :foreign_key => 'event_enrollment_id'

  def self.pending_bill(thiszone, thismonth, thisyear)
    puts thiszone
    puts thismonth
    puts thisyear
    self.where(["event_enrollment_id = ? and month(event_timestamp) = ? and year(event_timestamp) = ?" , thiszone, thismonth, thisyear]).order("event_timestamp ASC")
   #self.where( ["month(event_timestamp)=? and event_enrollment_id = ? and year(event_timestamp) = ?", thismonth, thiszone, thisyear], :order => "event_timestamp ASC")
  end

end
