PIXEL_WIDTH = 16
HEADER_BYTES = 138

# Check arguments
unless (filename = ARGV[0]) && ARGV[0] != ""
  print "Enter a filename for input: "
  filename = STDIN.gets.chomp
end

# Confirm file type
unless filename.reverse[0..2].reverse == "bmp"
  print "Must be a bitmap file!"
  exit
end

# REMOVE 138 BYTES
file = File.open(filename, 'rb').read
file = file.byteslice(HEADER_BYTES..file.length)

# Flip image
newFile = ""
file.reverse.scan(/.{32}/).each do |line|
  newFile += line.scan(/../).reverse.join
end
file = newFile

# Parse
hexes = []
file.scan(/../).each_with_index do |word, i|
  word = word.bytes
  val = ""
  word.each do |w|
    val += w.to_s(16).rjust(2, "0")
  end
  hexes.push("0x" + val)
end

# Write out file
varname = filename.chomp('.bmp')
File.open varname + ".h", 'w' do |file|
  file.write("/* " + varname +" */\n")
  file.write("const int " + varname + "[256] = {")
  hexes.each_with_index do |hex, i|
    file.write "\n  " if i % PIXEL_WIDTH == 0
    file.write hex + ", "
  end
  file.write("\n};")
end
