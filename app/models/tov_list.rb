class TovList

  attr_reader :starttime, :endtime, :cost, :value, :tolist, :mo, :yr, :zone, :total_cost, :total_time
  attr_writer :zone, :mo, :yr

def build_list(zoneid, mo, yr)
  @tolist=[]
  @ovrs = Event.pending_bill(zoneid, mo, yr)
  @cost= @total_time = 0
  i=0
  lday_of_mth = count_of_day = 0
  x = @ovrs.size-1
  while  i <= x
    ov = Tov.new
    if i == 0 # first time through
      if @ovrs[i].value == 0 # first event an off, spans month, throw out
        i+=1
      end
    end
    ov.starttime = @ovrs[i].event_timestamp
    ov.startvalue = @ovrs[i].value
    if ((i+1)<= x )
      ov.endtime = @ovrs[i+1].event_timestamp
      ov.endvalue = @ovrs[i+1].value
    else
      ov.endtime = ov.endvalue = nil
    end
    puts "i= #{i} #{ov.startvalue.to_i} #{ov.endvalue.to_i}"
    if event_valid?(ov)
      ov.valid=true
      ov.duration = ((ov.endtime-ov.starttime)/60.0).floor
      wd=ov.starttime.strftime("%a")
      day_of_mth = ov.starttime.strftime("%d")
      first_of_day = (day_of_mth != lday_of_mth) ? true : false
      if (first_of_day)
        count_of_day = 1
      end
      if (day_of_mth == lday_of_mth)
        count_of_day += 1
      end
      if (wd == "Sat")
        if (first_of_day)
          allowed_time = 300
        end
      end
      @total_time += ov.duration
      ov.cost = ov.duration/60.0 * @zone.sqft * @zone.ot_charge
    else
      ov.valid = false
      ov.duration = 0
      ov.cost = 0
      @total_time += ov.duration
    end
    @cost += ov.cost
    @tolist << ov
    i+=2
    lday_of_mth = day_of_mth
  end
  #puts "#{@ovrs.size}"
  #@ovrs.each do | t |
  #  puts "#{t.event_timestamp} #{t.from_state} #{t.to_state} "
  #end

end
  private

  def eventlistlength?(ln)
    return (ln.modulo(2)==0) ? true : false
  end

  def event_valid?(ov)
    return ((ov.startvalue.to_i == 1) && (ov.endvalue.to_i == 0)) ? true : false
  end
end
