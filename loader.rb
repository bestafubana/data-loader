class DataLoader 

attr_accessor :class1, :class2, :training, :validation, :test

  def load
    
    @class1 = Array.new
    @class2 = Array.new
    @training = Array.new
    @validation = Array.new
    @test = Array.new
    
    
    File.open("data.cod", "r").each_line do |line|
      #loading the line into an array of strings 
      tokens = line.scan(/\S+/) 
      
      #remove index (first column)
      tokens.shift 
      
      #separating the two classes
      if tokens[46] == "0" && tokens[47] == "1" 
        @class1.push(tokens*" ")
      else
        @class2.push(tokens*" ")
      end
      
    end
    
    #remove the header (first row)
    @class2.shift 
    
    #shuffle the elements of the classes
    @class1 = @class1.shuffle
    @class2 = @class2.shuffle
    
    # set testing set
    @test = @test  + @class1[0..9999] + @class2[0..174]
    @test = @test.shuffle
    
    #set training set
    @training = @training + @class1[10000..29999] + @class2[175..524] + @class2[175..224]
    #@training = @training + @class1[10000..10349] + @class2[175..524]
    @training = @training.shuffle
    
    #set validation set
    @validation = @validation + @class1[30000..39999] + @class2[525..699]*57 + @class2[525..549]
    #@validation = @validation + @class1[30000..30174] + @class2[525..699]
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
