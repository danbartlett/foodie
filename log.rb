# FRIDAY, 01 JUN 2018
# Porridge w/ Alpro, Banana & Almonds
breakfast = Meal.new(name: 'Alpro Porridge w/ Banana & Almonds', ingredients: ['Porridge,50', 'Fage,50', 'Banana,1', 'Alpro Coconut,200', 'Almonds,30', 'Chia seeds,10'])

# PWO Soreen and Choc Milk
pre_wo_snack = Meal.new(name: 'Soreen & Choc Milk', ingredients: ['Choc milk,100', 'Soreen,2'])

# Rego
post_wo_snack = Meal.new(name: 'SIS Rego', ingredients: ['Rego,50'])

# Chilli on Sourdough
lunch = Meal.new(name: 'Chilli on Sourdough', ingredients: ['Sourdough,185', 'Chilli,360', 'Fage,50'])

dinner_shake = Meal.new(name: 'Huel & PB shake', ingredients: ['Huel,112', 'Peanut butter,25', 'Choc shot,15', 'Alpro Coconut,100'])

biltong = Meal.new(name: 'Biltong snack', ingredients: ['Biltong,30'])
hot_choc = Meal.new(name: 'Hot choc w/o milk', ingredients: ['Hot choc,14.5'])

Day.new(breakfast, pre_wo_snack, post_wo_snack, lunch, dinner_shake, biltong, hot_choc)

puts Ingredient.first.summary

# SAT 02 JUN
scrambled_eggs = Meal.new(name: 'Scrambled eggs on toast', ingredients: ['Eggs,147', 'Sourdough,90', 'Butter,6.5'])
puts scrambled_eggs.summary

peaches = Meal.new(name: 'Two flat peaches', ingredients: ['Flat peach,2'])
puts peaches.summary

costa = Meal.new(name: 'Costa chicken sandwich and granola', ingredients: ['Costa chicken salad sandwich,1', 'Costa granola square,1'])
puts costa.summary

saturday = Day.new(scrambled_eggs, peaches, costa)
puts saturday.summary


