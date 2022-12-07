#!/usr/bin/env crystal
# extracts the fasta files form a BTK CSV and fires off curl vs Claudias BLAST server
# uses Heng Li's fasta parser from Klib

require "option_parser"
require "klib"

include Klib

btk=""
fasta=""
outdir="test"

OptionParser.parse do |parser|
	parser.banner = "Usage: decon_blastBTK --btk BTK_CSV_FILE --fasta FASTAFILE --outdir OUT_DIR"
	parser.on("-b BTK_CSV_FILE","--btk=BTK_CSV_FILE","BTK CSV file"){|b|btk=b}
	parser.on("-f FASTA_FILE","--fasta=FASTA_FILE","FASTA file of the assembly (can be compressed)"){|f|fasta=f}
	parser.on("-o OUT_DIR","--outdir=OUT_DIR","output directory"){|o|outdir=o}
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

ids= [] of String
header=0
File.each_line(btk) do |line|
	header += 1
	next if header == 1
	if /TRUE/i.match(line)
		columns=line.delete('"').split(',')
		ids << columns[-1]
	end
end

Dir.mkdir_p(outdir)

fp = GzipReader.new(fasta)
fx = FastxReader.new(fp)
while (r = fx.read) >= 0
 	if ids.includes? fx.name.to_s
		file="#{outdir}/#{fx.name.to_s}.fa"
		File.open(file,"w"){|f|
	 		f.puts ">#{fx.name.to_s}"
			f.puts fx.seq.to_s
		}
		system("curl -T #{file} http://172.27.25.136:35227 > #{file}.blast_out")
 	end
end