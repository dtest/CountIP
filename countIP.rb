class LogReader
  def readLog
    # Log File
    puts "Logfile? "
    logFile = STDIN.gets.chop #chops off the endline from the entry
    
    @logContents = IO.read(logFile)
  end
  
  def contentSlice (arr)
    # Return top X amount
    puts "How many? "
    logSlice = STDIN.gets.chop.to_i #chops new line and converts to integer

    arr = arr.sort {|a,b| b[1]<=>a[1]} #sorts reverse
    arr = arr.slice(0,logSlice)
    return arr
  end
  
  def parseTopIP
    ips = {} 
    self.readLog
    @logContents.scan(/ \d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3} /).each do |ip|
      ips[ip] = ips.fetch(ip, 0)+1
    end
    
    ips = self.contentSlice(ips)
    
    puts "Top Accesses by IP:"
    ips.each{ |ip,count| puts "#{ip}: #{count}"}
  end
  
#  def parsePages
#    pages = {}
#    self.readLog

#    # exclude list
#    puts "Exclude patterns: (enter one per line...blank line indicates complete list)"
#    excludes = []
#    while true
#      print "pattern> "; STDOUT.flush; pat = gets.chop
#      break if pat.empty?
#      excludes << Regexp.new(pat)
#    end

#    puts excludes

#    @logContents.scan(/GET(.*)HTTP/).each do |page|
#      toInclude = 1
#      excludes.each do |pat|
#       if (page =~ pat) 
#	 toInclude = false
#       end
#      end 
#      if (toInclude)
#      	pages[page] = pages.fetch(page, 0)+1
#      end
#    end
   
#    pages = self.contentSlice(pages) # sorts and grabs appropriate amount of pages

#    puts "\nTop Pages Accessed:"
#    pages.each{ |page,count| puts "#{page}: #{count}"}    
# end
end

#choices = ["parseTopIP", "parsePages"]

#print "Type of Parse? ( "
#choices.each {|method| print "#{method} "} 
#print ") "
#parseMethod = STDIN.gets.chop
parseMethod = "parseTopIP"

(LogReader.new).send(parseMethod)
