Dir.glob("csv/*.txt") {|path|
  code = File.basename(path, ".txt")[-4..-1].to_i
  File.open("csv/#{code}.csv", 'w') {|w|
    w.print "key_code,pop,pop_m,pop_f,hh,hh_p\n"
    count = 0
    File.foreach(path) {|l|
      count += 1
      next unless count > 2
      r = l.strip.split(',')
      w.print ([0, 4, 5, 6, 28, 29].map {|i| r[i]}).join(','), "\n"
    }
  }
}

