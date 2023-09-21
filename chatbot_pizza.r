chatbot <- function () {
  print("Welcome to our Pizzeria")
  print("what's your name?")
  user_input <- readLines("stdin", n=1)
  print (paste("Hi" , user_input))

  pizza_id <-c("P1", "P2", "P3", "P4")
  pizza <- c("hawaiian", "seafood cocktail", "pepperoni", "cheese" )
  price <- c(250, 320, 270, 300)
  pizza_price <- data.frame(pizza_id , pizza, price)
  
  
  option_id <- c("op1", "op2", "op3", "op4", "op5", "op6")
  option <- c("pan medium" , "pan large", "crispy thin medium" ,  "crispy thin large", "cheese crust medium", "cheese crust large")
  option_price <- c(0, 100, 0, 100, 50, 100)
  pizza_option <- data.frame (option_id, option, option_price)
  
  
  print("What would you like to order?")
  print(pizza_price)
  print("please select pizza id")
  order <- readLines("stdin", n=1)
  print (pizza_option)
  print("please select option id")
  order_option <- readLines("stdin", n=1)

  print("summary order") 
  
  print(pizza_price [(pizza_price$pizza_id == order), ])
  print(pizza_option[(pizza_option$option_id == order_option), ])

  print("total price")
  pizza_cost <- pizza_price [(pizza_price$pizza_id == order), ]
  option_cost <- pizza_option[(pizza_option$option_id == order_option), ]
  
  
 main_menu <- pizza_cost$price  
 other_cost <- option_cost$option_price

print( main_menu + other_cost )
  
}

chatbot()
