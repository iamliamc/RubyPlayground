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

logfile.close
log.close
