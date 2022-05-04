require 'enumerator'
 
module RomanTranslator
 
  def self.included(target)
    return if target != Fixnum && target != String
 
    func_name = 'to_roman'
    call_func = 'to_roman_from_number'
    func_name = 'from_roman' if target == String
    call_func = 'to_number_from_roman' if target == String
 
    target.class_eval <<-ruby_eval, __FILE__, __LINE__ + 1
      def #{func_name}
        #{call_func}(self)
      end
    ruby_eval
  end
 
private
 
  NUM_TO_ROM = {
    1 => 'I', 4 => 'IV', 5 => 'V', 9 => 'IX', 10 => 'X', 40 => 'XL', 50 => 'L',
    90 => 'XC', 100 => 'C', 400 => 'CD', 500 => 'D', 900 => 'CM', 1000 => 'M'
  }
 
  ROM_TO_NUM = NUM_TO_ROM.invert
 
  def to_roman_from_number(num)
    numbers = NUM_TO_ROM.keys.sort.reverse
    str = num.to_s
    res = ""
    zeros = str.length - 1
    str.each_byte do |c|
      num = c.chr.to_i * (10 ** zeros)
      fill = 0
      numbers.each do |v|
        while ((fill + v) <= num) do
          fill += v
          res << NUM_TO_ROM[v]
          break if v == num
        end
      end
      zeros -= 1
    end
    res
  end
 
  def to_number_from_roman(roman)
    array = roman.split(//)
    lookahead = 1
    skip = false
    array.inject(0) do |result, char1|
      num1 = ROM_TO_NUM[char1]
      if skip
        skip = false
        next(result)
      end
      num2 = ROM_TO_NUM[array[lookahead]]
      if num2.nil? || num1 >= num2 then
        result += num1
      else
        result += num2 - num1
        skip = true
      end
      lookahead += 1
      result
    end
  end
 
end
 
class Fixnum
  include RomanTranslator
end
 
class String
  include RomanTranslator
end

   puts 2229.to_roman #=> "MMCCXXIX"
   puts "MMCCXXIX".from_roman #=> 2229
   puts 2009.to_roman.from_roman #=> 2009