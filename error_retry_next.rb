def error_handling_with_pass
  retries = 0
  begin
    yield
  rescue Exception => e
    puts e.message
    puts e.backtrace.join("\n")
    retries += 1
    if retries < 5
      puts "RETRYING"
      sleep 1
      retry
    else
      puts "ABANDONING PULL #{fail_msg}"
      # next
    end
  end
end

thing = {1 => ["1"], 2 => ["2"], 4 => ["3"]}

# error_handling_with_pass {
#   (1..4).each do |i|
#     puts thing[i][0]
#   end
# }

retries = 0
(1..4).each do |i|
  begin
    puts thing[i][0]
  rescue Exception => e
    retries += 1
    if retries < 5
      puts "Retrying"
      sleep 1
      retry
    else
      puts e
      next
    end
  end
end
