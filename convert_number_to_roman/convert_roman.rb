# Write a program to convert a natural number to its Roman number equivalent. See

# https://en.wikipedia.org/wiki/Roman_numerals for the rules concerning the construction of Roman numbers using Roman numerals.

# Created by Celio T. Alonso
def to_roman(digits)
  numeral_sets = {  1=>['I', 'V', 'X'], 
                   10=>['X', 'L', 'C'], 
                  100=>['C', 'D', 'M'], 
                 1000=>['M', "\u2181", "\u2182"] }

  str = ''
  digits.reverse.each.with_index do |d, ix|
      set = numeral_sets[10**ix]
      case d
          when 0 then roman = ''
          when 1..3 then roman = set[0] * d
          when 4 then roman = "%s%s" % [set[0], set[1]]
          when 5 then roman = set[1]
          when 6..8 then roman = "%s%s" % [set[1], set[0] * (d-5)]
          when 9 then roman = "%s%s" % [set[0], set[2]]
      end
      str = str.insert(0, roman)
  end
  str
end


puts to_roman [1,4] # expected XIV
puts to_roman [2,9] # expected XIX
puts to_roman [4,5,4] # expected CDLIV
puts to_roman [2,0,1,9] # expected MMXIX
