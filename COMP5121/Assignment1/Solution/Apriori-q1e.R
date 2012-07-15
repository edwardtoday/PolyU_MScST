df <- read.csv("data-q1e.csv", header=TRUE, sep=",", na.strings="")

summary(df$Product, maxsum=20) # try to find errors in the Product column

# Fix typos and different in cases
df$Product[df$Product == "case" | df$Product == "CASE" | df$Product == "Cese"] <- "Case"
df$Product[df$Product == "desktop" | df$Product == "Desjtop"] <- "Desktop"
df$Product[df$Product == "Diaplay Card"] <- "Display Card"
df$Product[df$Product == "printer"] <- "Printer"
df$Product[df$Product == "SPeaker"] <- "Speaker"

# The data should be consistent now
summary(df$Product, maxsum=20) # try to find errors in the Product column

# Exclude NA's
numbers.present <- rowSums(df != "") # the number of valid data points in each row
good.rows <- which(numbers.present == 2) # find the complete rows (with both TID and product valid)
df.NAexcluded <- df[good.rows,] # now we have the table without NA rows

# Rows with NA values should be removed so far
summary(df.NAexcluded$Product, maxsum=12)

names(df.NAexcluded) <- NULL
write.table(df.NAexcluded, "data-q1e-clean.csv", sep=",", col.names=F, row.names=F,quote=F)

library(arules);

# Load the transaction data from file
trans <- read.transactions(file="data-q1e-clean.csv", format="single", sep=",", cols=c(1,2), rm.duplicates=T)

# Show the number of transactions
length(trans)

# You may use the following command to view the transactions
# inspect(trans)

# Use Apriori algorithm to find association rules
rules <- apriori(trans, parameter=list(supp=0.15, conf=0.8))

# View the rules found
inspect(rules)

# Define the interestingness measurement
AltI <- function(x,transactions) interestMeasure(x, method = "support", transactions)*interestMeasure(x, method = "confidence", transactions)*interestMeasure(x, method = "lift", transactions)

# Find interesting rules using Apriori
rules <- apriori(trans, parameter=list(supp=0.14, conf=0.87))
quality(rules) <- cbind(quality(rules), interestingness = AltI(rules, trans))
summary(rules)

# Level 2 abstraction
transl2 <- read.transactions(file="data-q1e-l2.csv", format="single", sep=",", cols=c(1,2), rm.duplicates=T)
rulesl2 <- apriori(transl2, parameter=list(supp=0.2, conf=0.85))
inspect(rulesl2)

# Level 3 abstraction
transl3 <- read.transactions(file="data-q1e-l3.csv", format="single", sep=",", cols=c(1,2), rm.duplicates=T)
rulesl3 <- apriori(transl3, parameter=list(supp=0.2, conf=0.8))
inspect(rulesl3)

# Cross level abstraction
transcross <- read.transactions(file="data-q1e-cross.csv", format="single", sep=",", cols=c(1,2), rm.duplicates=T)
rulescross <- apriori(transcross, parameter=list(supp=0.2, conf=0.8))
inspect(rulescross)