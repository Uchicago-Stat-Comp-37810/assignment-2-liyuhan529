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

######################################################################


# Example: plot the likelihood profile of the slope a
slopevalues <- function(x) { return (likelihood(c(x, trueB, trueSd)))}
slopelikelihoods <- lapply(seq(3, 7, by = .05), slopevalues)
plot(seq(3, 7, by = .05), slopelikelihoods, type = "l", xlab = "values of slope parameter a", ylab = "Log likelihood")

######################################################################
# Prior distribution

######################################################################

# Posterior distribution

######################################################################

######## Metropolis algorithm ################ 

## Starting at a random parameter value
## Choosing a new parameter value close to the old value based on some probability density that is called the proposal function
## Jumping to this new point with a probability p(new)/p(old), where p is the target function, and p>1 means jumping as well

startvalue = c(4,0,10)
chain = run_metropolis_MCMC(startvalue, 10000)

burnIn = 5000
acceptance = 1-mean(duplicated(chain[-(1:burnIn),]))

######################################################################
### Summary: #######################



# for comparison:
summary(lm(y~x))