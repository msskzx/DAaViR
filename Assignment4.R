library(ggplot2)
library(data.table)
library(magrittr) # Needed for %>% operator library(tidyr)
library(ggrepel)

# Section 02 - Reproducing a plot with ggplot2
data(mpg)
mpg <- as.data.table(mpg)
ggplot(mpg, aes(cty, hwy, color=factor(year))) + geom_point() + geom_smooth(method="lm")

# Section 03 - Visualizing distributions
iris <- as.data.table(iris)
iris

# 2. How are the lengths and widths of sepals and petals distributed?
# Make one plot of the distributions with multiple facets.
# Hint: You will need to reshape your data so that the different measurements
# (petal length, sepal length, etc.) are in one column and the values in another.
# Remember which is the best plot for visualizing distributions.
iris_melt <- melt(iris, id.vars = c("Species"))
iris_melt

ggplot(iris_melt, aes(value)) + geom_histogram() + facet_wrap(~variable)

# 4. Visualize the lengths and widths of the sepals and petals
# from the iris data with boxplots.
ggplot(iris_melt, aes(variable, value)) + geom_boxplot()

# 6.  Alternatives to boxplot are violin plots (geom_violin()).
# Try combining a boxplot with a violinplot to show the the lengths and widths
# of the sepals and petals from the iris data.
ggplot(iris_melt, aes(variable, value)) +
  geom_violin() +
  geom_boxplot(width=0.03)

ggplot(iris_melt, aes(variable, value, color = Species)) +
  geom_dotplot(binaxis="y", stackdir="centerwhole", dotsize=0.3)

# Section 04 - Visualizing relationships between continuous variables
# 2. Do petal lengths and widths correlate in every species? Show this with a plot.
ggplot(iris,aes(Petal.Length,Petal.Width, color = Species)) + geom_point()

ggplot(iris,aes(Petal.Length,Petal.Width)) + geom_point() +
  facet_wrap(~Species, scales = "free")

# Section 05 - Axes scaling and text labeling
medals_path = paste(extdata_path, "medals.csv", sep = "")
medals_dt <- fread(medals_path)
ggplot(medals_dt, aes(population, total)) + 
  geom_point() + 
  scale_x_log10() + 
  scale_y_log10() + 
  geom_text_repel(aes(label=code))
