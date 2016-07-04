flintstones_hash = {}

flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

flintstones.each do |name|
  flintstones_hash[name] = flintstones.index(name)
end
