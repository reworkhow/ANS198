#### ANS198 - Introduction to Animal Data Science

# Week2: Load data, data visualization

#-------------------------------------------------------------------------------
# Setting Up A Data Analysis 

# 1. Create a project folder.
# 2. Download the data (and move it to the project folder).
# 3. Load the data.

# Files & Paths --------------------

# In order to load the data, you need to tell R where the data is.
# Get the path to the working directory.
getwd()

# Set the working directory.
setwd("/Users/haocheng/Desktop/ANS198")

# List files in working directory.
list.files()

# read data
dogs = readRDS("dogs_full.rds")
# Source: https://informationisbeautiful.net/visualizations/best-in-show-whats-the-top-data-dog/
#datadog: datadog score
#popularity: popularity ranking, 1=most popular
#longevity: life expectancy (years)
#ailments: number of congenital ailments
#grooming: grooming required once overy data/week/...
#kids: suitability for childern (high/medium/low)


# Checking Structure --------------------
# Once you've loaded the data, the natural first step is to check how the data
# is structured.

# Get number of columns/rows.
ncol(dogs)
nrow(dogs)

dim(dogs)

# What are the column names?
colnames(dogs)

rownames(dogs)

# What is the overall STRucture of the data?
str(dogs)

# Summarizing Data --------------------
# R also has functions to help you summarize the content of the data.

# Get top 6 rows.
head(dogs)

# Get top 10 rows.
head(dogs, 10)

# Get bottom 6 rows.
tail(dogs)

# Get statistical summaries.
summary(dogs)

# Other summary statistics.
?mean
?median
?sd
?var

mean(c(1, 2, 3))

# Subsets --------------------

# We need to extract a single column. We can use $ to get a column by name.
dogs$height

sd(dogs$height)

# NA stands for "not available", a missing value. When the data set was
# created, the author didn't include a value for that measurement.
#
# Many functions have an na.rm parameter, which you can use to tell R to ignore
# missing values.
sd(dogs$height, na.rm = TRUE)


# you can check for NAs with:
is.na(dogs$height)

# You can get frequency counts for a categorical variable with table().
table(dogs$group)

# TRUE/FALSE values are categories, so you can also use table() to count the
# number of NAs in a vector or column.
table(is.na(dogs$height))


# There's another way to subset that's more general than $.
#
# With [, ] you can get specific rows and columns.
dogs[1, 1]
#    ^  ^----- column
#    |-------- row


dogs[1, 4]

# A blank entry in [, ] means all rows or all columns.
dogs[1, ] # row 1, all columns

is.na(dogs[, 1])

# Q: How can we find out the row numbers for rows with NAs?
#
# A: Use which() to find positions of TRUEs in a logical vector.
which(is.na(dogs$height))


#----------------------------------------------------------
#-----Visualization
# Install package on machine (do one time)
# or Tools -> Install Packages
install.packages("ggplot2")

# Load a package (do every time you restart R)
library("ggplot2")

# Grammar of Graphics --------------------
# Layer 1: Data
ggplot(data=dogs)

# Layer 2: GEOMetry -- shapes to represent data
ggplot(data=dogs) + geom_point()

# Layer 3: AESthetic -- "wires" between geometry and data
ggplot(data=dogs) + geom_point(aes(x = datadog, y = popularity))

#equivalently,
ggplot(data=dogs, aes(x = datadog, y = popularity)) + 
  geom_point()


# Add another geom to add breed names to the plot
ggplot(data=dogs, aes(x = datadog, y = popularity)) + 
  geom_point() +
  geom_text(aes(label = breed))


# Add colors for each group
ggplot(dogs, aes(x = datadog, y = popularity, color = group)) +
  geom_point() +
  geom_text(aes(label = breed))

# Depending on where we set the color aesthetic, color gets added to the
# points, the text, or both.
#add color to points:
ggplot(dogs, aes(x = datadog, y = popularity)) +
  geom_point(aes(color = group)) +
  geom_text(aes(label = breed))
#also add color to text:
ggplot(dogs, aes(x = datadog, y = popularity)) +
  geom_point(aes(color = group)) +
  geom_text(aes(label = breed,color = group))


# Adjust the text, so it's not on top of points
# you can modify text alignment with the vjust and hjust aesthetics. These can be
# a character ("left", "middle", "right", "bottom", "center", "top")

ggplot(dogs, aes(x = datadog, y = popularity, color = group)) + 
  geom_point() +
  geom_text(aes(label = breed), hjust = "left", vjust = "top") 


# Layer 5: LABELS
ggplot(dogs, aes(x = datadog, y = popularity, color = group)) +
  geom_point() +
  geom_text(aes(label = breed), hjust = "left", vjust = "top") +
  labs(title = "Best in Show", x = "Computed DataDog Score",
       y = "AKC Popularity Ranking")
  

# You can save the last plot you created to your working directory with:
ggsave("dogs_plot.png")



#Bar plot #this is the questions
ggplot(dogs, aes(x = group, fill = size)) +
  geom_bar(position = "dodge")


# ggplot2 cheat sheet
# https://www.rstudio.com/resources/cheatsheets/
