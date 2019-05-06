setwd("C:/Columbia Schoolwork/2019 Spring/SQL and Relational Databases/Project/Upload tables")

require('RPostgreSQL')
require('dplyr')
require('tidyr')

con <- dbConnect(drv = dbDriver('PostgreSQL'), dbname = 'proj_5', 
                 host = 's19db.apan5310.com', port = 50205, user = 'postgres',
                 password = '3utmhnzw')

value <- read.csv('states.csv')

dbWriteTable(con, name ='states', value = value, row.names = FALSE,append = TRUE)

value <- read.csv('cities.csv')

dbWriteTable(con, name ='cities', value = value, row.names = FALSE,append = TRUE)


value <- read.csv('cust_site.csv')

dbWriteTable(con, name ='cust_site', value = value, row.names = FALSE,append = TRUE)

value <- read.csv('sites.csv')

dbWriteTable(con, name ='sites', value = value, row.names = FALSE,append = TRUE)

value <- read.csv('customers.csv')

dbWriteTable(con, name ='customers', value = value, row.names = FALSE,append = TRUE)

value <- read.csv('orders.csv')

dbWriteTable(con, name ='orders', value = value, row.names = FALSE,append = TRUE)

value <- read.csv('discounts.csv')

dbWriteTable(con, name ='discounts', value = value, row.names = FALSE,append = TRUE)

value <- read.csv('order_product.csv')

dbWriteTable(con, name ='order_product', value = value, row.names = FALSE,append = TRUE)


value <- read.csv('products.csv')

dbWriteTable(con, name ='products', value = value, row.names = FALSE,append = TRUE)

value <- read.csv('inventories.csv')

dbWriteTable(con, name ='inventories', value = value, row.names = FALSE,append = TRUE)


value <- read.csv('groups.csv')

dbWriteTable(con, name ='groups', value = value, row.names = FALSE,append = TRUE)


value <- read.csv('categories.csv')

dbWriteTable(con, name ='categories', value = value, row.names = FALSE,append = TRUE)


value <- read.csv('org_cat.csv')

dbWriteTable(con, name ='org_cat', value = value, row.names = FALSE,append = TRUE)


value <- read.csv('organizations.csv')

dbWriteTable(con, name ='organizations', value = value, row.names = FALSE,append = TRUE)


value <- read.csv('manufacturers.csv')

dbWriteTable(con, name ='manufacturers', value = value, row.names = FALSE,append = TRUE)


value <- read.csv('plants.csv')

dbWriteTable(con, name ='plants', value = value, row.names = FALSE,append = TRUE)


value <- read.csv('manu_supp.csv')

dbWriteTable(con, name ='manu_supp', value = value, row.names = FALSE,append = TRUE)



value <- read.csv('suppliers.csv')

dbWriteTable(con, name ='suppliers', value = value, row.names = FALSE,append = TRUE)


value <- read.csv('supp_mater.csv')

dbWriteTable(con, name ='supp_mater', value = value, row.names = FALSE,append = TRUE)


value <- read.csv('materials.csv')

dbWriteTable(con, name ='materials', value = value, row.names = FALSE,append = TRUE)







# Free up resources
dbDisconnect(con)
rm(list=ls())