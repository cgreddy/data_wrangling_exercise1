#correct misspellings

refine_original$company[grep('Groningensingel', refine_original$address)] <- "phillips"
refine_original$company[grep('Leeuwardenweg', refine_original$address)] <- "akzo"
refine_original$company[grep('ps', refine_original$company)] <- "phillips"
refine_original$company[grep('en', refine_original$company)] <- "van houten"
refine_original$company[grep('Jourestraat', refine_original$address)] <- "unilever"

#load packages
library(tidyr)
library(dplyr)

#Separate columns
refine_original <- separate(refine_original, Product.code...number, c("product_code", "product_number"), sep = "-")

#add product categories
product_category <- refine_original$product_code

#add product_category to refine_original
refine_original <- cbind(refine_original, product_category)

refine_original$product_category <- gsub('p', 'Smartphone', refine_original$product_category)
refine_original$product_category <- gsub('v', 'TV', refine_original$product_category)
refine_original$product_category <- gsub('x', 'Laptop', refine_original$product_category)
refine_original$product_category <- gsub('q', 'Tablet', refine_original$product_category)

#create column 'full_address';
refine_original <- unite(refine_original, full_address, address, city, country, sep = ", ")

#create dummy variables
company_phillips <- as.numeric(refine_original$company == 'phillips')
company_akzo <- as.numeric(refine_original$company == 'akzo')
company_van_houten <- as.numeric(refine_original$company == 'van houten')
company_unilever <- as.numeric(refine_original$company == 'unilever')

product_smartphone <- as.numeric(refine_original$product_category == 'Smartphone')
product_tv <- as.numeric(refine_original$product_category == 'TV')
product_laptop <- as.numeric(refine_original$product_category == 'Laptop')
product_tablet <- as.numeric(refine_original$product_category == 'Tablet')


#add dummy variables to dataframe
refine_original <- cbind(refine_original, company_phillips, company_akzo, company_van_houten, company_unilever)
refine_original <- cbind(refine_original, product_smartphone, product_tv, product_laptop, product_tablet)

refine_original %>% View()
