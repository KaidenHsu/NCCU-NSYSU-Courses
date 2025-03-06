library(tidyverse)
challenge <- read_csv(readr_example("challenge.csv"))
write_csv(challenge, "challenge.csv")

# store data in R’s custom binary format called RDS
write_rds(challenge, "challenge.rds")
read_rds("challenge.rds")

# write_rds() vs. save()
mod <- lm(mpg ~ wt, data = mtcars)
mod

save(mod, file = "mymodel.rda")
ls()
load(file = "mymodel.rda")
ls()

saveRDS(mod, "mymodel.rds")
mod2 <- readRDS("mymodel.rds")
ls()
identical(mod, mod2, ignore.environment = TRUE)
