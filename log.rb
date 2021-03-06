def add_to_db(name:, ingredients:, date:)
  meal = Meal.create(name: name, created_at: date)
  ingredients.each do |ingredient|
    name, quantity = ingredient.split(',')
    ingredient_model = Ingredient.first(Sequel.like(:name, "#{name}%"))
    raise IngredientNotFound, "#{name} not found!" unless ingredient_model

    meal.add_new ingredient_model, quantity
  end
end

# TRUNCATE ALL DATA!!! All real data is logged below and is recreated on each run
DB << "TRUNCATE quantities, meals, metas CASCADE"

today = Date.new(2018, 6, 1) # FRI 1 JUN
add_to_db(
  name: 'Alpro Porridge w/ Banana & Almonds',
  ingredients: ['Porridge,50', 'Fage,50', 'Banana,1', 'Alpro Coconut,200', 'Almonds,30', 'Chia seeds,10'],
  date: today
)
add_to_db(
  name: 'PreWO Soreen & Choc Milk',
  ingredients: ['Choc milk,100', 'Soreen,2'],
  date: today
)
add_to_db(
  name: 'PostWO SIS Rego',
  ingredients: ['Rego,50'],
  date: today
)
add_to_db(
  name: 'Chilli on Sourdough',
  ingredients: ['Sourdough,185', 'Chilli,360', 'Fage,50'],
  date: today
)
add_to_db(
  name: '3 Scoop Huel & PB shake',
  ingredients: ['Huel,112', 'Peanut butter,25', 'Choc shot,15', 'Alpro Coconut,100'],
  date: today
)
add_to_db(
  name: 'Biltong snack',
  ingredients: ['Biltong,1'],
  date: today
)
add_to_db(
  name: 'Hot choc w/o milk',
  ingredients: ['Hot choc,14'],
  date: today
)
meals = Meal.where(created_at: today)
Meta.create(date: today, garmin_total_calories: 2804, garmin_active_calories: 867, steps: 21575)
day = Day.new(date: today, meals: meals)
puts day.summary

today = Date.new(2018, 6, 2) # SAT 2 JUN
add_to_db(
  name: 'Scrambled eggs on toast',
  ingredients: ['Eggs,147', 'Sourdough,90', 'Butter,6.5'],
  date: today
)
add_to_db(
  name: 'Two flat peaches',
  ingredients: ['Flat peach,2'],
  date: today
)
add_to_db(
  name: 'Costa chicken sandwich and granola',
  ingredients: ['Costa chicken salad sandwich,1', 'Costa granola square,1'],
  date: today
)
add_to_db(
  name: 'Lamb koftas, houmous & cous cous',
  ingredients: ['Lamb koftas,120', 'Moroccan cous cous,150', 'Reduced fat houmous,60'],
  date: today
)
add_to_db(
  name: 'Hot choc',
  ingredients: ['Hot choc,14'],
  date: today
)
add_to_db(
  name: 'BBQ belly & kebabs',
  ingredients: ['Chicken kebab,4', 'Pork belly,200', 'Creamy coleslaw,75', 'Heineken,1'],
  date: today
)
add_to_db(
  name: 'Hot choc',
  ingredients: ['Hot choc,14'],
  date: today
)
# meals = Meal.where(created_at: today)
# Meta.create(date: today, garmin_total_calories: 2691, garmin_active_calories: 754, steps: 11242)
# day = Day.new(date: today, meals: meals)
# puts day.summary

today = Date.new(2018, 6, 3) # SUN 3 JUN
add_to_db(
  name: 'LC breakfast',
  ingredients: ['Fage,100', 'Almonds,50','Caramel rice cake,2'],
  date: today
)
add_to_db(
  name: 'Cous Cous & biltong',
  ingredients: ['Reduced fat houmous,60', 'Moroccan cous cous,100', 'Biltong,1'],
  date: today
)
add_to_db(
  name: 'Nine bar!',
  ingredients: ['Nine bar,1'],
  date: today
)
add_to_db(
  name: 'PreWO Chia Charge',
  ingredients: ['Chia charge banana,1'],
  date: today
)
add_to_db(
  name: 'PostWO Banana & PB toast',
  ingredients: ['Banana,1', 'Sourdough,66', 'Peanut butter,30'],
  date: today
)
add_to_db(
  name: 'Salmon & broc',
  ingredients: ['Frozen salmon fillet,1', 'Tenderstem broccoli,100', 'Heineken,1'],
  date: today
)
add_to_db(
  name: 'Huel & snack',
  ingredients: ['Huel,74','Flapjack,0.5', 'Hot choc,14'],
  date: today
)
# meals = Meal.where(created_at: today)
# Meta.create(date: today, garmin_total_calories: 2821, garmin_active_calories: 884, steps: 18402)
# day = Day.new(date: today, meals: meals)
# puts day.summary

today = Date.new(2018, 6, 4) # MON 4 JUN
add_to_db(
  name: '4 egg scramble',
  ingredients: ['Eggs,200', 'Sourdough,65', 'Butter,10'],
  date: today
)
add_to_db(
  name: 'Chilli, sweet pot & salad',
  ingredients: ['Chilli,300', 'Sweet potato,226', 'Omega seed mix,15'],
  date: today
)
add_to_db(
  name: 'PostWO snack',
  ingredients: ['Flapjack,1','Coconut milk,150', 'Biltong,1', 'Apple,125'],
  date: today
)
add_to_db(
  name: 'Dins',
  ingredients: ['Sausages,3', 'Reduced fat houmous,57', 'Sourdough,65', 'Butter,5'],
  date: today
)
add_to_db(
  name: 'Hot choc made completely with milk',
  ingredients: ['Hot choc,14', 'Milk,200'],
  date: today
)
# Resting: 1937
meals = Meal.where(created_at: today)
Meta.create(date: today, garmin_total_calories: 2727, garmin_active_calories: 790, steps: 16737)
day = Day.new(date: today, meals: meals)
puts day.summary

today = Date.new(2018, 6, 5) # TUES 5 JUN
add_to_db(
  name: '3 scoop Huel w/ milk',
  ingredients: ['Huel,112', 'Milk,200'],
  date: today
)
add_to_db(
  name: 'PreWO banana & flapjack',
  ingredients: ['Flapjack,1', 'Banana,1'],
  date: today
)
add_to_db(
  name: 'Wagas & Picnic hot choc',
  ingredients: ['Grilled tuna,1', 'Power juice,1', 'Picnic hot chocolate,1'],
  date: today
)
add_to_db(
  name: 'Cheese, oatcakes & apple',
  ingredients: ['Oatcake,4', 'Apple,125', 'Cheese,20', 'Biltong,1'],
  date: today
)
add_to_db(
  name: 'Sliders, sweet pot & salad',
  ingredients: ['Chorizo/chicken sliders,3', 'Omega seed mix,10', 'Sweet potato,161', 'Avocado,1', 'Tesco rice cake,2', 'Hot choc,14'], # Half av
  date: today
)
puts Meal.last.summary
meals = Meal.where(created_at: today)
Meta.create(date: today, garmin_total_calories: 2711, garmin_active_calories: 774, steps: 16427)
day = Day.new(date: today, meals: meals)
puts day.summary

today = Date.new(2018, 6, 6) # WEDS 6 JUN
add_to_db(
  name: '3 egg scrambled eggs on toast',
  ingredients: ['Eggs,147', 'Sourdough,90', 'Butter,6.5'],
  date: today
)
add_to_db(
  name: 'Mackerel & Sweet Potato Salad',
  ingredients: ['Sweet potato,274', 'Mackerel,141', 'Omega seed mix,10'],
  date: today
)
puts Meal.last.summary
meals = Meal.where(created_at: today)
Meta.create(date: today, garmin_total_calories: 2711, garmin_active_calories: 774, steps: 16427)
day = Day.new(date: today, meals: meals)
puts day.summary
