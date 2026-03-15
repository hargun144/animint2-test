x=c(5,15,25,35,45,55,65,75)
f=c(20,45,85,160,70,55,35,30)
m=rep(x,f)
hist(m,
main="WEEKLY WAGES OF WORKERS",
xlab="wages",
ylab="no. of workers",
col='red')