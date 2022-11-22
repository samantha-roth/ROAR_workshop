# Exercise 1
# This code generates 20 sets of samples of size n=100k. 
# Each sample is drawn from a N(mu_i,5) for i={1,2,...,20} where mu_{1:20} = {10, 20, 30 ,...180,190,200}. 
# Note that it takes 5 seconds to generate a sample.
# The code generates a histogram for each set and saves it as a pdf. 
# We use 1 processors

setwd("/storage/work/svr5482/ROAR_workshop/exercise1")

setNum<-9
# Create a wrapper for the function
histCreate<- function(filetitle){
  Sys.sleep(5) # Forces a 5 second wait 
  data<-rnorm(100000,mean=10*filetitle,sd=sqrt(5)) # Draw 100k samples from N(mu,5)
  pdf(paste("Histogram",filetitle,".pdf",sep="")) # Create Histogram PDF
  hist(data, main =paste("Histogram: mean=",10*filetitle,sep=""))
  dev.off()
  return(data)
  
}

# run this using a for loop
findata<-matrix(NA,nrow=100000,ncol=setNum)
for(i in 1:setNum){
  print(paste("Generating Sample #",i))
  findata[,i]<-histCreate(i)
}
save(findata,file="findata.RData")
