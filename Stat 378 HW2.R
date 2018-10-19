source("/Users/liyuhan/Documents/GitHub/assignment-2-liyuhan529/Functions.R")

# Creating test data
trueA <- 5
trueB <- 0
trueSd <- 10
sampleSize <- 31

# create independent x-values 
x <- (-(sampleSize - 1) / 2): ((sampleSize - 1) / 2)
# create dependent values according to ax + b + N(0,sd)
y <-  trueA * x + trueB + rnorm(n = sampleSize, mean = 0, sd = trueSd)

plot(x, y, main = "Test Data")



# Example: plot the likelihood profile of the slope a
slopevalues <- function(x) { return (likelihood(c(x, trueB, trueSd)))}
slopelikelihoods <- lapply(seq(3, 7, by = .05), slopevalues)
plot(seq(3, 7, by = .05), slopelikelihoods, type = "l", xlab = "values of slope parameter a", ylab = "Log likelihood")



## Starting at a random parameter value
## Choosing a new parameter value close to the old value based on some probability density that is called the proposal function
## Jumping to this new point with a probability p(new)/p(old), where p is the target function, and p>1 means jumping as well

startvalue = c(4,0,10)
chain = run_metropolis_MCMC(startvalue, 10000)

burnIn = 5000
acceptance = 1-mean(duplicated(chain[-(1:burnIn),]))

### Summary: #######################


# for comparison:
summary(lm(y~x))

compare_outcomes=function(iteration){
  result_a=matrix(rep(0,20),ncol=2)
  #create the matrix that would save the result later
  
  for(i in 1:10){
    startvalue=c()
    startvalue[1]=runif(1,0,10)
    startvalue[2]=rnorm(1,0,5)
    startvalue[3]=runif(1,0,30)
    #determine the randomly selected start value for each loop, and save them into a vector
    
    chain=run_metropolis_MCMC(startvalue,iteration)
    #run the MCMC alagorithm defined previously, and save the result of each iteration in "chain"
    
    result_a[i, ] <- c(mean(chain[,1]), sd(chain[,1]))
    #save the mean value and sd of a in the result matrix
  }
  print(result_a)
}

compare_outcomes(1000)
compare_outcomes(10000)
compare_outcomes(100000)
