class PeopleController

require 'time'
  def initialize(params)
    @params = params
  end

  def normalize
     arr =[]
     s_arr =[]
  save_all =[]
  
    # get the data
    f2 = File.readlines('spec/fixtures/people_by_dollar.txt')
    f1 = File.readlines('spec/fixtures/people_by_percent.txt')

  

    # remove the newlines
    f1 = f1.map {|elem| elem.chomp}
    f2 = f2.map {|elem| elem.chomp}

    File.open('newFile.txt', 'w') do |output_file|
      #enumerate over the array length (take advantage of same size for both arrays)
      # f1.each_with_index do |elem, i|
      #    arr << elem
      # # output the string interpolation
      #  che2 = elem.gsub!(/[!@%&"]/, ',')
      #  rev = che2.split('')
     
      # # puts "REVERSER #{rev}"
      # output_file.puts "#{che2}" + "\n" 
      # end
       f1.each_with_index do |elem2, i|    
         
        if i == 0
  
      else
         che = elem2.gsub!(/[!@%&$"]/, ',').split(/\s*,\s*/)


          time = Time.parse(che[2])
          birthday = time.strftime("%-m/%-d/%Y")
     
         che[2]   = birthday
       
        
      # s_arr << che
       arr << che
 
      output_file.puts "#{che}" 
      end
        
     
       
      
      end

      f2.each_with_index do |elem2, i|    
        
        if i == 0
          puts "INDEX HEADER"
      else
         che = elem2.gsub!(/[!@%&$"]/, ',').split(/\s*,\s*/)
         puts "CHECK BRITHDAY INDEX #{che[1]}"
          puts "CHECK CIty INDEX #{che[0]}"
          time = Time.parse(che[1])
          birthday = time.strftime("%-m/%-d/%Y")
          puts "che2 BIRTHD TIME  #{birthday}"

          if che[0] == "LA"
            che[0] = "Los Angeles"
          else
            che[0] = "New York City"
          end
     
          che[0],che[3], che[1],che[2],che[3]   = che[3],che[0],che[0],birthday,che[2]
       
  
       s_arr << che
     
      output_file.puts "#{che.delete_at(3)}" 
      end
        
     
     
      end

    end
    puts "ARRAY---->>#{arr} and s_arr ARRAY---->>#{s_arr}"
    
    all_arr = arr.reverse + s_arr


    all_arr.each do |values|
     look ="#{values[0].strip}, #{values[1].strip}, #{values[2].strip}"
 
      
      puts "LookL ---->>>#{look}"
       save_all << look

    end
puts "SAVE ALL ---->>>#{save_all}"
  
      return save_all

   end

   

  private

  attr_reader :params
end

