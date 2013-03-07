class DataLoader 

attr_accessor :class1, :class2, :training, :validation, :test

  def load
    
    @class1 = Array.new
    @class2 = Array.new
    @training = Array.new
    @validation = Array.new
    @test = Array.new
    
    
    File.open("data.cod", "r").each_line do |line|
      tokens = line.scan(/\S+/) #loading the line into an array of strings 
      
      #remove index
      tokens.shift 
      
      if tokens[46] == "0" && tokens[47] == "1" #separating the two classes
        @class1.push(tokens*" ")
      else
        @class2.push(tokens*" ")
      end
      
    end
    
    @class2.shift #remove the header
    
    @class1 = @class1.shuffle
    @class2 = @class2.shuffle
    
    # set testing set
    @test = @test  + @class1[0..999] + @class2[0..174]
    @test = @test.shuffle
    
    #set training set
    @training = @training + @class1[1000..2999] + @class2[175..524]*5 + @class2[175..424]
    @training = @training.shuffle
    
    #set validation set
    @validation = @validation + @class1[3000..3999] + @class2[525..699]*5 + @class2[525..649]
    @validation = @validation.shuffle
    
    # printing size of the arrays
    puts "Class 1: " + @class1.size.to_s #4000
    puts "Class 2: " + @class2.size.to_s #700
    puts "Testing set: " + @test.size.to_s #700
    puts "Training set: " + @training.size.to_s #700
    puts "Validation set: " + @validation.size.to_s #700
    
    write_file("Teste.txt", @test)
    write_file("Treinamento.txt", @training)
    write_file("Validacao.txt", @validation)
  end
  
  def write_file(file_path, contents)
    File.open(file_path, 'w') do |f2|  
      contents.each do |content|
        f2.puts content
      end
    end  
  end
  
  def print_file(file_path)
    
    File.open(file_path, "r").each_line do |line|
      puts line
    end  
    
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
