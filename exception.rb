require 'logger'

logfile = Logger.new('test.log')
log = Logger.new(STDOUT)

logfile.debug "debugging info"
logfile.info "general logs"
logfile.warn "oh my…this isn't good"
logfile.error "boom!"
logfile.fatal "oh crap…"

begin
  [2, 1].each do |n|
    if n <= 1
      raise Exception
      end
      puts n
    end
  rescue Exception
    log.info "Something in the array was greater than 1"
  end

begin
  [1, 2, 3].each do |n|
    n / 0
  end
rescue Exception => e
  log.error "#{e.message}"
end


logfile.close
log.close
