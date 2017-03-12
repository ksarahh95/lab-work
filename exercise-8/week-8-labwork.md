---
title: "EEB177-exercise 8"
author: "Sarah Kim"
date: "March 1, 2017"
output: md_document

---

## Exploring the Cocoli Dataset
```{r}
cocoli_dat <- read.table("~/Desktop/eeb-177/class-assignments-2/classwork-21-feb/cocoli.txt", header = TRUE)
head(cocoli_dat)
str(cocoli_dat)

View(cocoli_dat)

sizes_in_1994 <- cocoli_dat$dbh1
names(sizes_in_1994) <- cocoli_dat$tag
sizes_in_1994[1] # subset a vector by position
sizes_in_1994["000001"] # subset a vector by name

sizes_in_1994 <- cocoli_dat$dbh2
names(sizes_in_1994) <- cocoli_dat$tag

sizes_in_1994 <- cocoli_dat$dbh3
names(sizes_in_1994) <- cocoli_dat$tag

# find all instances of dbh = 171
sizes_in_1994 == 171

# we want to know the fate of all trees that began 1994 with dbh 171
# first, make a list of trees that we 171 dbh in 1994:
trees_171_1994 = which(sizes_in_1994 == 171)
trees_171_1994

# in the 1997 list, find these individuals that used to eb 171mm
sizes_in_1997[trees_171_1994]

## Calculate RGR between 1997-1994
# (size in 1997 - size in 1994)/size in 1994
yearly_RGR_1 = ((cocoli_dat$dbh2-cocoli_dat$dbh1)/(cocoli_dat$dbh1))/3

#add the RR column
cocoli_dat$rgr1 = yearly_RGR_1

View(cocoli_dat)

hist(cocoli_dat$dbh1, xlab = "DBH in 1994 (mm)", main = "Distributions of sizes in 1994", col = "purple", xlim = c(0,2000))
```
```{r}
library(ggplot2)
ggplot(cocoli_dat) + geom_histogram(aes(dbh1)) + geom_histogram(aes(dbh2), col = "red") + ggtitle("Distribution sizes in 1994") #use cocoli data to make histogram and use dbh1 column to make histogram

```

