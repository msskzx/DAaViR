library(data.table)
library(magrittr)
library(tidyr)

# Section 3
extdata_path <- "~/Documents/TUM/R/DAaViR/extdata/"
messy_dt <- fread(paste(extdata_path, "weather.txt", sep = ''))
head(messy_dt)

# 4. Create a tidy version of the weather dataset.
dt <- melt(messy_dt, id.vars = c("id", "year", "month", "element"),
           variable.name = "day",
           value.name = 'temp')
dt[, day := as.integer(gsub("d", "", day))]
dt <- unite(dt, "date", c("year", "month", "day"), sep = "-", remove = TRUE)
head(dt)

# Section 04 -Scattered data across many files
baby_names_path <- paste(extdata_path, "baby-names", sep = "")
files <- list.files(baby_names_path, full.names = TRUE)
names(files)
# 3. Read in the data from all files into one table.
# Hint: when you read many files and gather them into one table,
# be sure to add a column that identifies each file. rbindlist()
tables <- lapply(files, fread)
names(files) <- basename(files)
names(files)
dt <- rbindlist(tables, idcol = 'filename')
dt

# 4. Is the data tidy? If not, tidy it up.
dt <- separate(dt, col = "filename", into = c("year", "sex"), extra = "drop")
head(dt)

# Section 05 - Small case-study: cleaning up a gene-expression dataset in yeast
eqtl_path <- paste(extdata_path, "eqtl/", sep = "")
genotype_path <- paste(eqtl_path, "genotype.txt", sep = "")
genotype_dt <- fread(genotype_path)
head(genotype_dt[, 1:5])

growth_path <- paste(eqtl_path, "growth.txt", sep = "")
growth_dt <- fread(growth_path)
head(growth_dt)

# tidy tables: melt
genotype_dt <- melt(genotype_dt, id.vars = "strain", variable.name = "genotype", value.name = "marker")
head(genotype_dt)

growth_dt <- melt(growth_dt, id.vars = "strain", variable.name = "media", value.name = "growth_rate")
head(growth_dt)

# merge tables
dt <- merge(growth_dt, genotype_dt, by = "strain", allow.cartesian = TRUE)
head(dt)

# convert the categorical entries to factors.
# (Measuring the object size before and after shows that factors require less storage spac
object.size(dt)
dt[, genotype := as.factor(genotype)]
dt[, strain:= as.factor(strain)]
dt[, marker:= as.factor(marker)]
object.size(dt)
head(dt)

