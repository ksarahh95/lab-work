---
title: "week-8-lab-hw"
author: "Sarah Kim"
date: "March 1, 2017"
output: md_document

---

# Intro to R graphics with ggplot2
```{r}
rm(list=ls())
.First <- function() {
  options(width=70)
  options(useFancyQuotes=FALSE)
  require(ascii)
  require(xtable)
  require(ggplot2)
  require(scales)
  require(reshape2)
  require(plyr)
  theme_set(theme_bw())
  png <<- function(res=96, width=500, height=300, ...) grDevices::png(res=res, width=width, height=height, ...)
}
(load-file "../setupEnvironment.el")

```

## Example data: housing prices
```{r}
housing <- read.csv("~/Desktop/eeb-177/lab-work/exercise-8/Rgraphics/dataSets/landdata-states.csv")
head(housing[1:5])



```
```{r}
hist(housing$Home.Value)

```

```{r}
library(ggplot2)
ggplot(housing, aes(x = Home.Value))+ geom_histogram()
```
```{r}
plot(Home.Value ~ Date,
     data=subset(housing, State == "MA"))
points(Home.Value ~ Date, col="red",
       data=subset(housing, State == "TX"))
legend(1975, 400000,
       c("MA", "TX"), title="State",
       col=c("black", "red"),
       pch=c(1, 1))
ggplot(subset(housing, State %in% c("MA", "TX")),
       aes(x=Date,
           y=Home.Value,
           color=State))+
  geom_point()
```

```{r}
ggplot(hp2001Q1,
       aes(y = Structure.Cost, x = log(Land.Value))) +
  geom_point()
```
```{r}
hp2001Q1$pred.SC <- predict(lm(Structure.Cost ~ log(Land.Value), data = hp2001Q1))

p1 <- ggplot(hp2001Q1, aes(x = log(Land.Value), y = Structure.Cost))

p1 + geom_point(aes(color = Home.Value)) +
  geom_line(aes(y = pred.SC))
```
```{r}
p1 +
  geom_point(aes(color = Home.Value)) +
  geom_smooth()
```
```{r}
p1 + 
  geom_text(aes(label=State), size = 3)
```
```{r}
install.packages("ggrepel") 
library("ggrepel")
p1 + 
  geom_point() + 
  geom_text_repel(aes(label=State), size = 3)
```
```{r}
p1 +
  geom_point(aes(size = 2),# incorrect! 2 is not a variable
             color="red") # this is fine -- all points red
```
```{r}
p1 +
  geom_point(aes(color=Home.Value, shape = region))
```
# Exercise I
```{r}
dat <- read.csv("~/Desktop/eeb-177/lab-work/exercise-8/Rgraphics/dataSets/EconomistData.csv")

head(dat)
```
```{r}
#Exercise I: 1) Creating a scatterplot (CPI vs. HDI)
ggplot(dat, aes(x = CPI, y = HDI, size = HDI.Rank)) + geom_point(aes(size = 2, color = "blue", shape = Region))
```
```{r}
# Statistical Transformations
args(geom_histogram)
args(stat_bin)
```
#Setting Statistical Transformation Arguments
```{r}
p2 <- ggplot(housing, aes(x = Home.Value))
p2 + geom_histogram()
```
```{r}
p2 + geom_histogram(stat = "bin", binwidth = 4000)
```
```{r}
#Changing the Statistical Transformation
housing.sum <- aggregate(housing["Home.Value"], housing["State"], FUN=mean)
rbind(head(housing.sum), tail(housing.sum))
```

```{r}
ggplot(housing.sum, aes(x=State, y=Home.Value)) + 
  geom_bar(stat="identity")
```
#Exercise II
```{r}
dat <- read.csv("~/Desktop/eeb-177/lab-work/exercise-8/Rgraphics/dataSets/EconomistData.csv")

p2 <- ggplot(dat, aes(x=CPI, y=HDI, size = HDI.Rank))+ geom_point()
p2 + geom_point(aes(size=2), color="blue")
p2 + geom_point(aes(shape = Region, color = HDI.Rank))

p2 + geom_point(aes(color = HDI.Rank)) + geom_smooth()
p2 + geom_point(aes(color = HDI.Rank)) + stat_smooth()

dat$pred.SC <- predict(lm(HDI - log(CPI), data = dat)
p2 <- ggplot(dat, aes(x = log(CPI), y =HDI)
p2 + geom_point(aes(color = HDI.Rank)) + geom_line(aes(y = pred.SC))


```
```{r}
p3 <- ggplot(housing,
             aes(x = State,
                 y = Home.Price.Index)) + 
        theme(legend.position="top",
              axis.text=element_text(size = 6))
(p4 <- p3 + geom_point(aes(color = Date),
                       alpha = 0.5,
                       size = 1.5,
                       position = position_jitter(width = 0.25, height = 0)))
```
```{r}
p4 + scale_x_discrete(name="State Abbreviation") +
  scale_color_continuous(name="",
                         breaks = c(1976, 1994, 2013),
                         labels = c("'76", "'94", "'13"))
```
```{r}


p4 +
  scale_x_discrete(name="State Abbreviation") +
  scale_color_continuous(name="",
                         breaks = c(1976, 1994, 2013),
                         labels = c("'76", "'94", "'13"),
                         low = "blue", high = "red")


```
```{r}
p4 +
  scale_color_continuous(name="",
                         breaks = c(1976, 1994, 2013),
                         labels = c("'76", "'94", "'13"),
                         low = muted("blue"), high = muted("red"))
#muted fxn does not work for me
```
```{r}
p4 +
  scale_color_gradient2(name="",
                        breaks = c(1976, 1994, 2013),
                        labels = c("'76", "'94", "'13"),
                        low = muted("blue"),
                        high = muted("red"),
                        mid = "gray60",
                        midpoint = 1994)
#muted fxn does not work for me
```
```{r}
#Exercise 3
dat <- read.csv("~/Desktop/eeb-177/lab-work/exercise-8/Rgraphics/dataSets/EconomistData.csv")
ggplot(dat, aes(x = CPI, y = HDI, size = HDI.Rank)) + geom_point(aes(size = 2, color = "blue"))

ggplot(dat, aes(x=CPI, y=HDI)) + 
  geom_bar(stat="identity")

p3 <- ggplot(housing,
             aes(x = State,
                 y = Home.Price.Index)) + 
        theme(legend.position="top",
              axis.text=element_text(size = 6))
(p4 <- p3 + geom_point(aes(color = Date),
                       alpha = 0.5,
                       size = 1.5,
                       position = position_jitter(width = 0.25, height = 0)))
```

