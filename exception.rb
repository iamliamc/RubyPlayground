require 'logger'
log = Logger.new(STDOUT)
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
