#Написати програму яка приймає на вхід "пиріг з родзинками"
#cake = 
#  ........
#  ..o.....
#  ...o....
#  ........
#// o это изюм
#Нам потрібно рівно розрізати пиріг на n маленьких прямокутних шматочків так, щоб у кожному маленькому пирізі була 1 родзинка. n не є аргументом, ця кількість родзинок усередині торта
#cake = 
#  ........
#  ..o.....
#  ...o....
#  ........
# 
#Результат ось такий масив
#  [
#     ........
#     ..o.....
#  ,
#     ...o....
#     ........
#  ]
#Кількість родзинок завжди більше 1 та менше 10.
#Якщо рішень кілька, виберіть те, що має найбільшу ширину першого елемента масиву.
#Поступово розрізати на n частин, що означає однакову площу. Але їхня форма може бути різною.
#Кожен шматок торта має бути прямокутним.

# Замороження рядка-літералу
# frozen_string_literal: true

def divide_cake(cake)
  total_raisins = cake.join.count('0')       # Підрахунок кількості родзинок
  total_area = cake.size * cake[0].size      # Загальна площа торта
  slice_area = total_area / total_raisins    # Площа одного шматка

  raise 'Raisins must be more than 1 and less than 10' unless total_raisins.between?(2, 9)
  raise 'Unable to cut cake' unless total_area % total_raisins == 0

  possible_slices = find_slices(cake, slice_area)    # Знаходження можливих шматків

  suitable_combinations = possible_slices.combination(total_raisins).select do |combo|
    check_fit(cake.map(&:dup), combo)
  end

  suitable_combinations.max_by { |slices| slices[0][0].size }
end

def find_slices(cake, slice_area)
  slices = []

  height, width = cake.size, cake[0].size

  (1..height).each do |slice_height|
    (1..width).each do |slice_width|
      next unless slice_height * slice_width == slice_area

      (0...(height - slice_height + 1)).each do |row_start|
        (0...(width - slice_width + 1)).each do |col_start|
          slice = extract_slice(cake, slice_height, slice_width, row_start, col_start)
          slices << slice if slice.join.count('0') == 1
        end
      end
    end
  end

  slices
end

def extract_slice(cake, height, width, row, col)
  slice = []
  (row...(row + height)).each do |i|
    slice << cake[i][col...(col + width)]
  end
  slice
end

def check_fit(original, slices)
  slices.each do |slice|
    placed = place_slice(original, slice)
    return false unless placed
  end
  true
end

def place_slice(cake, slice)
  height, width = slice.size, slice[0].size

  (0..(cake.size - height)).each do |row|
    (0..(cake[0].size - width)).each do |col|
      return mark_slice(cake, slice, row, col) if can_place_slice?(cake, slice, row, col)
    end
  end

  false
end

def can_place_slice?(cake, slice, row, col)
  slice.each_with_index do |slice_row, i|
    slice_row.chars.each_with_index do |char, j|
      next if char != '0'
      return false if cake[row + i][col + j] != '0'
    end
  end
  true
end

def mark_slice(cake, slice, row, col)
  slice.each_with_index do |slice_row, i|
    slice_row.chars.each_with_index do |char, j|
      if char == '0'
        cake[row + i][col + j] = '.' # Позначення розрізаної частини
      end
    end
  end
true
end
   



