#Треба написати програму, яка перетворює римську цифру в ціле число та навпаки.

#Сучасні римські цифри записуються, виражаючи кожну цифру окремо, починаючи з крайньої лівої цифри та пропускаючи будь-яку цифру зі значенням нуль. Римськими цифрами 1990 позначається: 1000=M, 900=CM, 90=XC; в результаті MCMXC. 2008 записується як 2000=MM, 8=VIII; або MMVIII. 1666 використовує кожен римський символ у порядку спадання: MDCLXVI.

#Діапазон введення: 1 <= n < 4000
#4 має бути представлено як IV.

# Замороження рядка-літералу
# frozen_string_literal: true

ROMAN_NUMERALS = {'M' => 1000, 'CM' => 900, 'D' => 500, 'CD' => 400, 
                  'C' => 100, 'XC' => 90, 'L' => 50, 'XL' => 40, 
                  'X' => 10, 'IX' => 9, 'V' => 5, 'IV' => 4, 'I' => 1}

def convert_to_roman(number)
  raise "Number must be between 1 and 3999" unless (1..3999).include?(number)

  roman = ""
  ROMAN_NUMERALS.each do |key, val|
    while number >= val
      roman += key
      number -= val
    end
  end

  roman
end

def convert_from_roman(roman_str)
  raise "Invalid Roman numeral format" unless roman_str.match?(/\A[MCDLXVI]+\z/)

  total = 0
  previous_val = 0

  roman_str.each_char do |char|
    val = ROMAN_NUMERALS[char]
    total += val > previous_val ? val - 2 * previous_val : val
    previous_val = val
  end

  total
end

if ARGV.length != 2
  puts "Please input two values: one integer and one Roman numeral"
  exit
end

puts convert_to_roman(ARGV[0].to_i)
puts convert_from_roman(ARGV[1])
