require 'json'

table = {}
csv_path = "csv/#{ENV['CODE']}.csv"
count = 0
File.foreach(csv_path) {|l|
  count += 1
  next if count == 1
  r = l.strip.split(',').map{|v| v.to_i}
  table[r.shift] = r
} if File.exist?(csv_path)

while gets
  f = JSON.parse($_.strip)
  f['properties'].keys.each {|k|
    f['properties'][k.downcase] = f['properties'][k]
    f['properties'].delete(k)
  } 
  %w{obj_id}.each {|k|
    f['properties'].delete(k)
  }
  key_code = f['properties']['key_code']
  if (table[key_code]) 
    f['properties']['pop'] = table[key_code][0]
    f['properties']['pop_m'] = table[key_code][1]
    f['properties']['pop_f'] = table[key_code][2]
    f['properties']['hh'] = table[key_code][3]
    f['properties']['hh_p'] = table[key_code][4]
  end
  f['tippecanoe'] = {
    :layer => 'g5',
    :minzoom => 11,
    :maxzoom => 11
  }
  print "\x1e#{JSON.dump(f)}\n"
end

