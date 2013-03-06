class DataLoader 

attr_accessor :class1, :class2

  def load
    
    @class1 = Array.new
    @class2 = Array.new
    
    File.open("data.cod", "r").each_line do |line|
      tokens = line.scan(/\S+/) #loading the line into an array of strings 
      
      if tokens[47] == "0" && tokens[48] == "1" #separating the two classes
        @class1.push(tokens)
      else
        @class2.push(tokens)
      end  
      
    end
    
    puts "Classe 1: " + @class1.size.to_s
    puts "Classe 2: " + @class2.size.to_s
  end
  
  def testScan
    sentence = "The     winter is   comming"
    tokens = sentence.scan(/\S+/)
    puts tokens
  end
  
end


loader = DataLoader.new
loader.load
#loader.testScan
