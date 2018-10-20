#!/usr/bin/env python
# coding: utf-8

# In[1]:


cars = 100
#give a certain value to a variable

space_in_a_car = 4.0
#give a certain value to a variable

drivers = 30
#give a certain value to a variable

passengers = 90
#give a certain value to a variable

cars_not_driven = cars - drivers
#define a new variable using varaibles previously defined

cars_driven = drivers
#define a new variable using varaibles previously defined

carpool_capacity = cars_driven * space_in_a_car
#define a new variable using varaibles previously defined

average_passengers_per_car = passengers / cars_driven
#define a new variable using varaibles previously defined


print("There are", cars, "cars available.")
print("There are only", drivers, "drivers available.")
print("There will be", cars_not_driven, "empty cars today.")
print("We can transport", carpool_capacity, "people today.")
print("We have", passengers, "to carpool today.")
print("We need to put about", average_passengers_per_car,
      "in each car.")
#show the actual value of certain variables.


# # Study Drills
# #When I wrote this program the first time I had a mistake, and Python told me about it like this:
# 
# Traceback (most recent call last):
#   File "ex4.py", line 8, in <module>  
#   average_passengers_per_car = car_pool_capacity / passenger  
# NameError: name 'car_pool_capacity' is not defined
#  
# Explanation:The author used the wrong name for the varialble that causes the error. In line 7, the author define the variable as "carpool_capacity", but he later used the variable as "car_pool_capacity" in line 8, which have not been defined. Thus python didn't know what the variable refers to.

# # More study drills
# 1.I used 4.0 for space_in_a_car, but is that necessary? What happens if it's just 4?  
# 2.Remember that 4.0 is a floating point number. It's just a number with a decimal point, and you need 4.0 instead of just 4 so that it is floating point.  
# 3.Write comments above each of the variable assignments.  
# 4.Make sure you know what = is called (equals) and that its purpose is to give data (numbers, strings, etc.) names (cars_driven, passengers).  
# 5.Remember that _ is an underscore character.  
# 6.Try running python3.6 from the Terminal as a calculator like you did before, and use variable names to do your calculations. Popular variable names are also i, x, and j.
# 

# 
# #1. The change seems to be unnecessary in this case, since the output didn't change. But it may be necessary in other cases.
# #3. See the comments above.
# #6. done
# 
