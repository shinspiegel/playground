# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

airlines = Airline.create([
    {name: "United Airllines", image_url: "https://google.com.br"},
    {name: "Brazil Airllines", image_url: "https://google.com.br"},
    {name: "Non-Brazil Airllines", image_url: "https://google.com.br"},
    {name: "UnUnited Airllines", image_url: "https://google.com.br"},
    {name: "Reforced Airllines", image_url: "https://google.com.br"},
])

reviews = Review.create([
    {title: "What?", description: "What is this?", score: 5, airline: airlines[0]},
    {title: "No", description: "no no!", score: 1, airline: airlines[0]},
    {title: "Super!", description: "Love it", score: 1, airline: airlines[1]},
])
