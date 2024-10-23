#!/usr/bin/env crystal
# extracts the fasta files form a BTK CSV and fires off curl vs Claudias BLAST server
# uses Heng Li's fasta parser from Klib

require "option_parser"
require "klib"

include Klib

btk = ""
fasta = ""
outdir = "test"

OptionParser.parse do |parser|
  parser.banner = "Usage: decon_blastBTK --btk BTK_CSV_FILE --fasta FASTAFILE --outdir OUT_DIR"
  parser.on("-b BTK_CSV_FILE", "--btk=BTK_CSV_FILE", "BTK CSV file") { |b| btk = b }
  parser.on("-f FASTA_FILE", "--fasta=FASTA_FILE", "FASTA file of the assembly (can be compressed)") { |f| fasta = f }
  parser.on("-o OUT_DIR", "--outdir=OUT_DIR", "output directory") { |o| outdir = o }
  parser.on("-h", "--help", "Show this help") do
    puts parser
    exit
  end
  parser.invalid_option do |flag|
    STDERR.puts "ERROR: #{flag} is not a valid option."
    STDERR.puts parser
    exit(1)
  end
end

def parse_btk_file(file : String)
  i = [] of String
  header = 0
  File.each_line(file) do |line|
    header += 1
    next if header == 1
    if /TRUE/i.match(line)
      columns = line.delete('"').split(',')
      i << columns[-1]
    end
  end
  i
end

ids = parse_btk_file(btk)

Dir.mkdir_p(outdir)

channel = Channel(String).new
done = Channel(Nil).new
[35227, 35228, 35229].each { |p|
  spawn do
    while f = channel.receive
      if f == "done"
        done.send(nil)
        break
      else
        puts "processing(#{p}) #{f}  at #{Time.local.to_local}"
        system("curl -s -T #{f} http://172.27.25.136:#{p} > #{f}.blast_out")
      end
    end
  end
}

fp = GzipReader.new(fasta)
fx = FastxReader.new(fp)
fx.each { |e|
  if ids.includes? e.name
    file = "#{outdir}/#{e.name}.fa"
    File.open(file, "w") { |f|
      f.puts ">#{e.name}"
      f.puts e.seq
    }
    puts "adding #{file}"
    channel.send(file)
  end
  puts e.name
}
3.times { |_| channel.send("done") }
3.times do
  puts "got"
  done.receive
end
