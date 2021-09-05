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
    f1 = File.readlines('spec/fixtures/people_by_percent.txt')
    f2 = File.readlines('spec/fixtures/people_by_dollar.txt')
    

    # remove the newlines
    f1 = f1.map {|elem| elem.chomp}
    f2 = f2.map {|elem| elem.chomp}

    #testing output on a different txt file
    File.open('newFile.txt', 'w') do |output_file|
      #enumerate over the array length (take advantage of same size for both arrays)   
      
      # Looping through file 1 to read the lines
      f1.each_with_index do |element, i|            
      if i == 0
        #If it is the header in the file then ignore
      else

        data_from_file = element.gsub!(/[!@%&$"]/, ',').split(/\s*,\s*/)  #removing all symbols from the data in the txt
        
         #formatting birthdate from file
        time = Time.parse(data_from_file[2])  
        birthday = time.strftime("%-m/%-d/%Y")
        data_from_file[2] = birthday
        
        #push all data from file to an array
        arr << data_from_file
        output_file.puts "#{data_from_file}"  #push to newFile.txt
      end   
      end


      # Looping through file 2 to read the lines
      f2.each_with_index do |element, i|    
        
        if i == 0
         #If it is the header in the file then ignore
       else

         data_from_file2 = element.gsub!(/[!@%&$"]/, ',').split(/\s*,\s*/) #removing all $% symbols from the data in the txt
        
          #formatting birthdate from file
          time = Time.parse(data_from_file2[1])
          birthday = time.strftime("%-m/%-d/%Y")
          data_from_file2[2] = birthday

          #Need to format the City to match whats is in the spec
          if data_from_file2[0] == "LA"
            data_from_file2[0] = "Los Angeles"
          else
            data_from_file2[0] = "New York City"
          end


          #Swapping positions from the datafile array
          data_from_file2[0],data_from_file2[3], data_from_file2[1],data_from_file2[2],data_from_file2[3]   = data_from_file2[3],data_from_file2[0],data_from_file2[0],birthday,data_from_file2[2]
       
          #push all data from file 2 to an array
          s_arr << data_from_file2
     
          output_file.puts "#{data_from_file2.delete_at(3)}"  #deleting lastname from array -- not needed
      end
      end

    end
  
  
    all_arr = arr.reverse + s_arr  # i reversed array in file one and merged with array in file 2

    #looping throughr array and assigning data to a new array to match the spec
    all_arr.each do |values|
     data_together ="#{values[0].strip}, #{values[1].strip}, #{values[2].strip}"
      save_all << data_together
    end

    return save_all

   end

   

  private

  attr_reader :params
end

