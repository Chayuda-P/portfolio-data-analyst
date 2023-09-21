---
title: "data visualization HM-01"
author: "by Pang"
date: "created 2023-09-12"
output:
  pdf_document: default
  html_document: default
---
---

```{r echo=FALSE, message=FALSE, warning=FALSE}
library(tidyverse)
library(patchwork)
library(ggthemes)
```

## msleep
msleep is mammals sleep dataset for understanding mammalian sleep

## let's explore msleep!

The first chart illustrates time that mammals take sleep. They take from 2 hours until 20 hours, but most of mammals sleep approximately 10 hours.

```{r echo=FALSE, message=TRUE, warning=TRUE}
g1 <- ggplot(msleep , aes(x = sleep_total))+ 
  geom_histogram(bins = 20 , fill = "#a0cff2") +
  theme_minimal()

g2 <- ggplot(msleep , aes(x = sleep_total))+ 
  geom_boxplot()+
  theme_minimal()

g1 + g2

```

```{r echo=TRUE, warning=FALSE, paged.print=TRUE}
fivenum(msleep$sleep_total)
```

---

```{r echo=FALSE, message=FALSE, warning=FALSE}

bwt300 <- msleep %>% 
  filter(bodywt < 180) 


ggplot(bwt300 , aes(bodywt , sleep_total , col = vore)) +
  geom_point(size = 3, alpha = 0.7) +
  geom_smooth(method = lm , col = "#011f8a" , fill = "#fce8f4") +
  theme_minimal()+
  scale_color_manual (values = c("#ff8b61" ,"#cfed0e", "#5ce0b9", "#e1b1fc")) +
  labs( title = "relationship between body weight and amount of sleep times",    
        x = "body weight (kg)",    
        y = "amount of sleep times(hour)",    
        caption = "Source : msleep from ggplot2")

```

This graph shows relationship between weight and sleep time. Smaller mammals tend to sleep longer than bigger mammals.
Carnivore mammals are different. They, love sleeping, sleep more than 10 hours.

**Example of carnivore mammals**

```{r echo=FALSE, message=FALSE, warning=FALSE, paged.print=TRUE}
msleep %>%
  select(name , bodywt , sleep_total) %>%
  filter(bodywt > 25) %>%
  arrange(-sleep_total) %>%
  print(n=10)
```

---

## Sleep Cycle

During sleep, the mammalian brain transitions through repeated cycles of non-rapid-eye-movement (NREM) and rapid-eye-movement (REM) sleep. The physiological implementation of this slow ultradian brain rhythm is largely unknown. Two differing dynamical mechanisms have been proposed to underlie the NREM-REM cycle. 
And total sleep is made up of several rounds of the sleep cycle.Not all sleep cycles are the same length

*Source : Modeling the mammalian sleep cycle, sleepfoundation*

```{r echo=FALSE, message=FALSE, warning=FALSE, paged.print=TRUE}

ggplot(msleep , aes(sleep_cycle , sleep_total)) +
  geom_smooth(col = "#606060FF", fill = "#D6ED17FF"  , na.rm = TRUE) +
  theme_minimal()+
  labs( title = "relationship between sleep cycle and total sleep time",    
        x = "sleep cycle (hour)",    
        y = "total sleep time")
```

This graph shows that mammals which have low sleep cycle tend to take longer sleep than mammals which have high sleep cycle.

---

## mpg

The mpg is data set contains a subset of the fuel economy data.
It contains only models which had a new release every year between 1999 and 2008 - this was used as a proxy for the popularity of the car.

```{r echo=FALSE, message=FALSE, warning=FALSE, paged.print=TRUE}
ggplot(mpg , aes(displ , cty , col = cty )) +
  geom_point(size = 2 , alpha = 0.8)+
  geom_smooth(col = "#ffe70f", alpha = 0.5)+
  theme_minimal()+
  scale_color_gradient(low="#bca4f5",high="#79d1b7")+
  facet_wrap(~class , ncol = 4)+
  labs( title = "relationship between displ and city mpg ",    
      x = " engine displacement (litre) ",    
      y = "city miles per gallon")
```

## let's explore mpg!

Those graphs show that engine displacement affects city miles per gallon. If engine displacement is low, city miles per gallon will be high. 
If engine displacement is high , city miles per gallon will be lower.

---

## Final graph shows classes of car from each manufacturer

```{r echo=FALSE, fig.height=10, fig.width=10, message=FALSE, warning=FALSE, paged.print=TRUE}
ggplot(mpg , aes(manufacturer , fill = class)) +
  geom_bar() +
  theme_minimal()+
  scale_fill_manual(values = c("#d73027",
"#f46d43","#313695", "#74add1" ,"#fee090" , "#fdae61","#4575b4"))+
  labs( x = "manufacturer",    
        caption = "Source : mpg from ggplot2")

```


#### If you are looking for eco car for driving in a city, I would recommend subcompact car and compact car.


**choice 1 : subcompact cars**

```{r echo=FALSE, message=TRUE, warning=FALSE, paged.print=TRUE}
subcompact_choice <- mpg %>%
  filter(class == "subcompact") %>%
  select(manufacturer , model , year , displ, cyl ,trans  , cty)%>%
  arrange(-cty) %>%
  head(10)
subcompact_choice
```

**choice 2 : compact cas**

```{r echo=FALSE, message=TRUE, warning=FALSE, paged.print=TRUE}
compact_choice <- mpg %>%
  filter(class == "compact") %>%
  select(manufacturer , model , year , displ, cyl ,trans  , cty)%>%
  arrange(-cty) %>%
  head(10)
compact_choice
