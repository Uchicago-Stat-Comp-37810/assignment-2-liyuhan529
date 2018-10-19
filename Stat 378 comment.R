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

# This part is just producing the test data under certain conditions. They initially set the x values
# around 0, and produce y values with a variance added to it.

######################################################################
likelihood <- function(param){
  a = param[1]
  b = param[2]
  sd = param[3]
 # save each parameter in the linear model as a vector
  
  pred = a * x + b
  singlelikelihoods = dnorm(y, mean = pred, sd = sd, log = T)
  #define the likelihood function of the model(using the log form)
  sumll = sum(singlelikelihoods)
  #compute the value of likelihood function
  return (sumll)   
}

# Example: plot the likelihood profile of the slope a
slopevalues <- function(x) { return (likelihood(c(x, trueB, trueSd)))}
# Define the function to compute the value of likelihood function as the slope changes, while intercept and variance are set
# to the true value.
slopelikelihoods <- lapply(seq(3, 7, by = .05), slopevalues)
# Give values to the slope and run the function.
plot(seq(3, 7, by = .05), slopelikelihoods, type = "l", xlab = "values of slope parameter a", ylab = "Log likelihood")
# Make the plot between the value of likelihood function and the slope a. The larger the value, 
# the more likely the slope is.

######################################################################
# Prior distribution
prior <- function(param){
  a = param[1]
  b = param[2]
  sd = param[3]
  #name the original value of each parameter
  aprior = dunif(a, min = 0, max = 10, log = T)
  #use uniform distributon to describe prior slope
  bprior = dnorm(b, sd = 5, log = T)
  #use normal distribution to describe prior intercept
  sdprior = dunif(sd, min = 0, max = 30, log = T)
  #use uniform distributon to describe prior variance
  return(aprior + bprior + sdprior)
  #compute the value of likelihood function with prior distribution
}



######################################################################

# Posterior distribution
posterior <- function(param){
  return (likelihood(param) + prior(param))
  #compute the value of likelihood function for posterior distribution
}

######################################################################

######## Metropolis algorithm ################ 

## Starting at a random parameter value
## Choosing a new parameter value close to the old value based on some probability density that is called the proposal function
## Jumping to this new point with a probability p(new)/p(old), where p is the target function, and p>1 means jumping as well
proposalfunction <- function(param){
  return(rnorm(3,mean = param, sd= c(0.1,0.5,0.3)))
}
  # define the proposal function which produce the next value of iteration based only on the current value
run_metropolis_MCMC <- function(startvalue, iterations){
  chain = array(dim = c(iterations+1,3))
  # create the array which saves the value of each iteration later
  chain[1,] = startvalue
  # save the start value in the first row of the array
  for (i in 1:iterations){
    proposal = proposalfunction(chain[i,])
  # choose a new parameter value close to the old value based on the proposal function defined above 
    probab = exp(posterior(proposal) - posterior(chain[i,]))
  # calculate the probability of accepting the new value
    if (runif(1) < probab){
      chain[i+1,] = proposal
    }else{
      chain[i+1,] = chain[i,]
    }
  # decide whether to choose the new value or still be the old value 
  }
  return(chain)
}

startvalue = c(4,0,10)
# determine the start value
chain = run_metropolis_MCMC(startvalue, 10000)
# set the number of iterations to be 10000, and save the result of all iterations in the array called "chain"

burnIn = 5000
acceptance = 1-mean(duplicated(chain[-(1:burnIn),]))
# discard the initial iterations thet may be influenced by start values, and compute the acceptance rate
######################################################################
### Summary: ## #####################

par(mfrow = c(2,3))
hist(chain[-(1:burnIn),1],nclass=30, , main="Posterior of a", xlab="True value = red line" )
abline(v = mean(chain[-(1:burnIn),1]))
# plot the posterior distribution of a
abline(v = trueA, col="red" )
# true value of a
hist(chain[-(1:burnIn),2],nclass=30, main="Posterior of b", xlab="True value = red line")
abline(v = mean(chain[-(1:burnIn),2]))
# plot the posterior distribution of b
abline(v = trueB, col="red" )
# true value of b
hist(chain[-(1:burnIn),3],nclass=30, main="Posterior of sd", xlab="True value = red line")
abline(v = mean(chain[-(1:burnIn),3]) )
# plot the posterior distribution of sd
abline(v = trueSd, col="red" )
# true value of sd
plot(chain[-(1:burnIn),1], type = "l", xlab="True value = red line" , main = "Chain values of a", )
abline(h = trueA, col="red" )
plot(chain[-(1:burnIn),2], type = "l", xlab="True value = red line" , main = "Chain values of b", )
abline(h = trueB, col="red" )
plot(chain[-(1:burnIn),3], type = "l", xlab="True value = red line" , main = "Chain values of sd", )
abline(h = trueSd, col="red")
# compare the sample values and true values of a, b, and sd in 5000~10000th iterations

# for comparison:
summary(lm(y~x))
# compare the result of iterations to the linear model