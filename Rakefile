desc 'extract source files to src'
task :extract do
  raise 'extract has been done.'
  Dir.glob("#{ENV['HOME']}/Downloads/QDDSWQ*.zip") {|path|
    sh "unzip #{path} -d src"
  }
end

desc 'extract csv files to csv'
task :extract_csv do
  raise 'extract has been done.'
  Dir.glob("#{ENV['HOME']}/Downloads/tbl*.zip") {|path|
    sh "unzip #{path} -d csv"
  }
end

desc 'create csv files for tile-join'
task :create_csv do
  sh "ruby create_csv.rb"
end

desc 'create tiles in mbtiles'
task :tiles do
  Dir.glob('src/*.shp') {|path|
    code = File.basename(path, ".shp")[-4..-1].to_i
    sh "ogr2ogr -f GeoJSONSeq /vsistdout/ #{path} -mapFieldType All=Integer64 | CODE=#{code} ruby filter.rb | tippecanoe -f -o mbtiles/#{code}.mbtiles"
  }
  sh "tile-join -f -o tiles.mbtiles mbtiles/*.mbtiles"
end

desc 'extract tiles into filesystem'
task :fs do
  sh "tile-join --force --no-tile-compression " +
    "--output-to-directory=docs/zxy --no-tile-size-limit tiles.mbtiles"
end

desc 'create style.json'
task :style do
  sh "parse-hocon conf/style.conf > docs/style.json"
  sh "gl-style-validate docs/style.json"
end

desc 'host the site locally'
task :host do
  sh "budo -d docs"
end

