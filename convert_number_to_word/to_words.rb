class Numberswords
    def in_words(n)

    words_hash = {0=>"zero",1=>"one",2=>"two",3=>"three",4=>"four",5=>"five",6=>"six",7=>"seven",8=>"eight",9=>"nine",
                    10=>"ten",11=>"eleven",12=>"twelve",13=>"thirteen",14=>"fourteen",15=>"fifteen",16=>"sixteen",
                     17=>"seventeen", 18=>"eighteen",19=>"nineteen",
                    20=>"twenty",30=>"thirty",40=>"forty",50=>"fifty",60=>"sixty",70=>"seventy",80=>"eighty",90=>"ninety"}

     scale = [000=>"",1000=>"thousand",1000000=>" million",1000000000=>" billion",1000000000000=>" trillion", 1000000000000000=>" quadrillion"]


    if words_hash.has_key?(n) 
      words_hash[n]

      #still working on this middle part. Anything above 999 will not work
     elsif n>= 1000  
     print  n.to_s.scan(/.{1,3}/) do |number|
            print number
      end



      #print value = n.to_s.reverse.scan(/.{1,3}/).inject([]) { |first_part,second_part| first_part << (second_part == "000" ? "" : second_part.reverse.to_i.in_words) }
      #(value.each_with_index.map { |first_part,second_part| first_part == "" ? "" : first_part + scale[second_part] }-[""]).reverse.join(" ")

    elsif n <= 99
       return [words_hash[n - n%10],words_hash[n%10]].join(" ")
    else
      words_hash.merge!({ 100=>"hundred" })
      ([(n%100 < 20 ? n%100 : n.to_s[2].to_i), n.to_s[1].to_i*10, 100, n.to_s[0].to_i]-[0]-[10])
        .reverse.map { |num| words_hash[num] }.join(" ")
    end
  end
end

#test code
test = Numberswords.new
#puts "Escreva seu número:"
#input = gets
puts test.in_words(229)

