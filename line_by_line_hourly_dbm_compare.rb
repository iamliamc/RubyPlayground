require 'date'
require 'fileutils'
require 'csv'
require 'optparse'

# How to run:
# ruby compare-dbm-reports.rb -f "./analysis/Daily_Line_Stats_last_7_days_4_00_AM_until_Nov._17th_2017_2016-09-30-0815.csv","./analysis/Daily_Line_Stats_last_7_days_4_30_AM_until_Nov._17th_2017_2016-09-30-0846.csv"

options = {}
parser = OptionParser.new do |opts|
  opts.banner = "Usage: #{$0} [options]"
  opts.on("-f", "-f \"File1\",\"File2\"", Array, "Two DBM line item stats files to compare") do |f|
    options[:file1] = f[0]
    options[:file2] = f[1]
  end
  opts.on("-d", "-d\"Day1\",\"Day2\"", Array, "Process two days") do |f|
    puts "Implement Multi - Days Here"
  end
end.parse!

def hashify_csv csv, time
  csv.each_with_object({}) do |row, obj|
    obj[[row["Date"], row["Advertiser"], row["Advertiser ID"], row["Insertion Order"], row["Insertion Order ID"], row["Line Item"], row["Line Item ID"]]] = {row: row, time: time}
  end
end

def prepare_file file
  date_regex = /.*days_(.*)_until.*_(.*)-\d{4}\.csv\z/
  report = CSV.read(file, :headers=>true)
  time = date_regex.match(file)[1]
  report = report.select{|row| row["Date"] != nil && !row["Date"].include?(":")}
  hashify_csv(report.sort_by{|h| [h["Date"], h["Line Item ID"]]}, time)
end

def prepare_files files, from='./analysis/'
  files.each_with_object([]) do |f, obj|
    obj.push(prepare_file(from + f))
  end
end

def day_files day, from='./analysis'
  Dir.entries(from).select{ |entry| entry =~ /#{day}-\d{4}\.csv\z/ }.sort
end

def all_keys_list hashes
  k_list = []
  hashes.each do |h|
    k_list += h.keys
  end
  k_list.uniq
end

def compile_lines_by_time csv_hashes
  all_keys = all_keys_list(csv_hashes)
  all_keys.each_with_object({}) do |k, lines_by_hour|
    lines_by_hour[k] = {}
    csv_hashes.each do |c_hash|
      if c_hash[k].nil?
      else
        lines_by_hour[k][c_hash[k][:time]] = c_hash[k][:row]
      end
    end
  end
end

def determine_lines_with_difference lines_by_time
  lines_by_time.keys.each do |k|
    if lines_by_time[k].values.map{|row| row["Impressions"]}.uniq.length > 1
    else
      lines_by_time.delete(k)
    end
  end
  lines_by_time
end

def output_writter processed_lines_by_time
  headers = ["Date", "Advertiser", "Advertiser ID", "Insertion Order", "Insertion Order ID", "Line Item", "Line Item ID", "4_00_AM", "4_30_AM", "5_00_AM", "5_30_AM", "6_00_AM", "6_30_AM", "7_00_AM", "7_30_AM", "8_00_AM", "8_30_AM"]
  CSV.open("./analysis/line_by_line_hourly_impressions_analysis.csv", "w") do |csv|
    csv << headers
    processed_lines_by_time.keys.each_with_object([]) do |k, row|
      row = k
      processed_lines_by_time[k].values.each do |v|
        row.push(v["Impressions"])
      end
      csv << row
    end
  end
end

if __FILE__ == $0
  puts day_files "2016-09-29"
  lines_by_time = determine_lines_with_difference(compile_lines_by_time(prepare_files(day_files "2016-09-29")))
  output_writter(lines_by_time)

end
