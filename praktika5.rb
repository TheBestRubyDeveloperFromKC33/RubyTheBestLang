#Реалізуйте метод, який повертатиме true, якщо заданий аргумент строки є IPv4-адресою - чотири числа (0-255), розділені крапками.
#Він повинен приймати лише адреси в канонічному представленні, тобто без ведучих нулів, пропусків тощо.

# Замороження рядка-літералу
# frozen_string_literal: true

def is_valid_ipv4?(address)
  # Перевірка формату IPv4 за допомогою регулярного виразу
  return false unless address.match?(/^\d{1,3}(\.\d{1,3}){3}$/)

  octets = address.split('.')

  # Переконуємось, що кожен октет є числом від 0 до 255 і не містить ведучих нулів
  octets.all? do |octet|
    octet_value = octet.to_i
    octet_value.between?(0, 255) && octet_value.to_s == octet
  end
end

# Перевірка вхідних аргументів
if ARGV.length != 1
  puts "Please provide a single IPv4 address"
  exit
end

input_ip = ARGV[0]

# Виведення результату валідації
puts is_valid_ipv4?(input_ip) ? "Valid IPv4 address" : "Invalid IPv4 address"
