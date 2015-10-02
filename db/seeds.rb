# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Category.destroy_all
MenuItem.destroy_all
Order.destroy_all
Barista.destroy_all


coffee = Category.create({name: 'coffee'})
tea = Category.create({name: 'tea'})

tall = Category.create({name: 'tall'})
grande = Category.create({name: 'grande'})
venti = Category.create({name: 'venti'})

hazelnut = Category.create({name: 'hazelnut'})
cinnamon = Category.create({name: 'cinnamon'})
pumpkin_spice = Category.create({name: 'pumpkin_spice'})


americano = MenuItem.create({name: 'americano', price_in_cents: 4_00})
americano.categories.push(tall)
americano.categories.push(coffee)


americano_2 = MenuItem.create({name: 'americano', price_in_cents: 6_00})
americano_2.categories.push(grande)
americano_2.categories.push(coffee)


americano_3 = MenuItem.create({name: 'americano', price_in_cents: 8_00})
americano_3.categories.push(venti)
americano_3.categories.push(coffee)


latte = MenuItem.create({name: 'latte', price_in_cents: 4_00})
latte.categories.push(tall)
latte.categories.push(coffee)


latte_2 = MenuItem.create({name: 'latte', price_in_cents: 6_00})
latte_2.categories.push(grande)
latte_2.categories.push(coffee)


latte_3 = MenuItem.create({name: 'latte', price_in_cents: 8_00})
latte_3.categories.push(venti)
latte_3.categories.push(coffee)

chai_tea_latte = MenuItem.create({name: 'Chai Tea', price_in_cents: 9_00})
chai_tea_latte.categories.push(tea)

barista = Barista.create_with_code(name: 'Sid')

order = Order.create_for(barista)
order.menu_items.push(latte_3)
order.menu_items.push(latte_2)
order.amount_in_cents += (latte_3.price_in_cents  + latte_2.price_in_cents)
order.accept!

order2 = Order.create_for(barista)
order2.menu_items.push(chai_tea_latte)
order2.amount_in_cents += chai_tea_latte.price_in_cents
order2.accept!

order3 = Order.create_for(barista)
order3.menu_items.push(americano_2)
order3.amount_in_cents += americano_2.price_in_cents
order2.accept!


order4 = Order.create_for(barista)
order4.menu_items.push(americano_2)
order4.menu_items.push(americano)
order4.menu_items.push(chai_tea_latte)
order4.amount_in_cents += (americano_2.price_in_cents + chai_tea_latte.price_in_cents + americano.price_in_cents)
order4.accept!

MenuItem.joins(:order, :categories).
    where('orders.id = ? AND categories.id IN (?)',
          o.id,
          [Category.find_by_name('coffee').id,
           Category.find_by_name('tea').id
          ])


