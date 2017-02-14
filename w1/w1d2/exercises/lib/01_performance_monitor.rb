require "time"

def measure(number = 1, &prc)
  start_time = Time.now
  number.times { prc.call }
  end_time = Time.now
  total_time = (end_time - start_time) / number
end
