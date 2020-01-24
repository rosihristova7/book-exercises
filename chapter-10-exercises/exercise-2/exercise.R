# Exercise 2: working with data frames

# Create a vector of 100 employees ("Employee 1", "Employee 2", ... "Employee 100")
# Hint: use the `paste()` function and vector recycling to add a number to the word
# "Employee"
employees <- paste("Employee", 1:100)


# Create a vector of 100 random salaries for the year 2017
# Use the `runif()` function to pick random numbers between 40000 and 50000
salaries_2017 <- runif(100, 40000, 50000)


# Create a vector of 100 annual salary adjustments between -5000 and 10000.
# (A negative number represents a salary decrease due to corporate greed)
# Again use the `runif()` function to pick 100 random numbers in that range.
adjustments <- runif(100, -5000, 10000)


# Create a data frame `salaries` by combining the 3 vectors you just made
# Remember to set `stringsAsFactors=FALSE`!
salaries <- data.frame(employees, salaries_2017, adjustments, stringsAsFactors = FALSE)
View(salaries)

# Add a column to the `salaries` data frame that represents each person's
# salary in 2018 (e.g., with the salary adjustment added in).
salaries$salaries_2018 <- salaries$salaries_2017 + salaries$adjustments


# Add a column to the `salaries` data frame that has a value of `TRUE` if the 
# person got a raise (their salary went up)
salaries$got_raise <- salaries$salaries_2018 - salaries$salaries_2017 > 0


### Retrieve values from your data frame to answer the following questions
### Note that you should get the value as specific as possible (e.g., a single
### cell rather than the whole row!)

# What was the 2018 salary of Employee 57
salary_2018_employee_57 <- salaries[salaries$employees == "Employee 57", "salaries_2018"]
print(salary_2018_employee_57)

# How many employees got a raise?
employees_with_raise <- nrow(salaries[salaries$got_raise == TRUE, ])
print(employees_with_raise)

# What was the dollar value of the highest raise?
highest_raise <- salaries[salaries$adjustments == max(salaries$adjustments), "adjustments"]
print(highest_raise)

# What was the "name" of the employee who received the highest raise?
employee_highest_raise <- salaries[salaries$adjustments == max(salaries$adjustments), "employees"]
print(employee_highest_raise)

# What was the largest decrease in salaries between the two years?
lowest_cut <- salaries[salaries$adjustments == min(salaries$adjustments), "adjustments"]
print(lowest_cut)

# What was the name of the employee who recieved largest decrease in salary?
employee_lowest_cut <- salaries[salaries$adjustments == min(salaries$adjustments), "employees"]
print(employee_lowest_cut)

# What was the average salary change?
salary_change <- mean(salaries$adjustments)
print(salary_change)

# For people who did not get a raise, how much money did they lose on average?
paycut <- salaries[salaries$got_raise == FALSE, ]
mean(paycut$adjustments)
# could also do it like this: mean( salaries[salaries$got_raise == FALSE, "adjustments"] )

## Consider: do the above averages match what you expected them to be based on 
## how you generated the salaries? - yes, they do match

# Write a .csv file of your salary data to your working directory
write.csv(salaries, "salaries_output.csv")

