library(arules)

# Load the transaction data from file
data_q1b <- read.transactions(file="data-q1b.csv", format="basket", sep=",")

# Show the number of transactions
length(data_q1b)

# You may use the following command to view the transactions
# inspect(data_q1e)

# Use Apriori algorithm to find association rules with min_sup=0.09, min_conf=0.83
rules_q1b <- apriori(data_q1b, parameter=list(supp=0.139, conf=0.849))

# View the rules found
inspect(rules_q1b)
