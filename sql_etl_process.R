# setwd("C:/Columbia Schoolwork/2019 Spring/SQL and Relational Databases/Project")

require(dplyr)
require(tidyr)
require(stringr)

df <- read.csv(file='raw_dataset.csv')

######### split unatomic cells table ############### 
# Separate phone numbers into one per row
df2 <- separate_rows(df, supplier, sep = '\\|')
df2 <- separate_rows(df2, plants, sep = '\\|')
df2 <- separate_rows(df2, materials, sep = '\\,')


############ site table  ##############

df_email <- df %>% select(Product.ID, # Should rename first column in dataset, it's blank in there
                          Amazon.email, 
                          WAL.MART.email, 
                          TARGET.email,
                          FAMILY.DOLLAR.STORES.email,
                          DOLLAR.GENERAL.email,
                          CVS.email,
                          KROGER.email,
                          WALGREENS.email,
                          RITE.AID.CORP.email,
                          AHOLD.email,
                          SAFEWAY.email,
                          US.All.Other.Customers.email) %>% # add for all customers
   gather(customer, email, -Product.ID) %>% 
   distinct() %>% 
   mutate('customer' = str_sub(customer, 1, str_length(customer)-6)) %>% # strip off '.email' from end
   select('id' = Product.ID, customer, email)

df_zip <- df %>% select(Product.ID, # Should rename first column in dataset, it's blank in there
                        Amazon.zip, 
                        WAL.MART.zip, 
                        TARGET.zip,
                        FAMILY.DOLLAR.STORES.zip,
                        DOLLAR.GENERAL.zip,
                        CVS.zip,
                        KROGER.zip,
                        WALGREENS.zip,
                        RITE.AID.CORP.zip,
                        AHOLD.zip,
                        SAFEWAY.zip,
                        US.All.Other.Customers.zip) %>% # add for all customers
  gather(customer, zip, -Product.ID) %>% 
  distinct() %>% 
  mutate('customer' = str_sub(customer, 1, str_length(customer)-4)) %>% # strip off '.zip' from end
  select('id' = Product.ID, customer, zip)


df_address <- df %>% select(Product.ID, # Should rename first column in dataset, it's blank in there
                        Amazon.Site.Address, 
                        WAL.MART.Site.Address, 
                        TARGET.Site.Address,
                        FAMILY.DOLLAR.STORES.Site.Address,
                        DOLLAR.GENERAL.Site.Address,
                        CVS.Site.Address,
                        KROGER.Site.Address,
                        WALGREENS.Site.Address,
                        RITE.AID.CORP.Site.Address,
                        AHOLD.Site.Address,
                        SAFEWAY.Site.Address,
                        US.All.Other.Customers.Site.Address) %>% # add for all customers
  gather(customer, Site.Address, -Product.ID) %>% 
  distinct() %>% 
  mutate('customer' = str_sub(customer, 1, str_length(customer)-13)) %>% # strip off '.Site.Address' from end
  select('id' = Product.ID, customer, Site.Address)

df_phone <- df %>% select(Product.ID, # Should rename first column in dataset, it's blank in there
                          Amazon.phone, 
                          WAL.MART.phone, 
                          TARGET.phone,
                          FAMILY.DOLLAR.STORES.phone,
                          DOLLAR.GENERAL.phone,
                          CVS.phone,
                          KROGER.phone,
                          WALGREENS.phone,
                          RITE.AID.CORP.phone,
                          AHOLD.phone,
                          SAFEWAY.phone,
                          US.All.Other.Customers.phone) %>% # add for all customers
  gather(customer, phone, -Product.ID) %>% 
  distinct() %>% 
  mutate('customer' = str_sub(customer, 1, str_length(customer)-6)) %>% # strip off '.phone' from end
  select('id' = Product.ID, customer, phone)

df_sales <- df %>% select(Product.ID, # Should rename first column in dataset, it's blank in there
                          Amazon, 
                          WAL.MART, 
                          TARGET,
                          FAMILY.DOLLAR.STORES,
                          DOLLAR.GENERAL,
                          CVS,
                          KROGER,
                          WALGREENS,
                          RITE.AID.CORP,
                          AHOLD,
                          SAFEWAY,
                          US.All.Other.Customers, Date, Product) %>% # add for all customers, including dates
  gather(customer, sales, -Product.ID, -Date, -Product) %>% 
  distinct() %>% 
  select('id' = Product.ID, Date, customer, 'product_quantity' = sales, Product)

df_dis <- df %>% select(Product.ID, # Should rename first column in dataset, it's blank in there
                          Amazon.Discount, 
                          WAL.MART.Discount, 
                          TARGET.Discount,
                          FAMILY.DOLLAR.STORES.Discount,
                          DOLLAR.GENERAL.Discount,
                          CVS.Discount,
                          KROGER.Discount,
                          WALGREENS.Discount,
                          RITE.AID.CORP.Discount,
                          AHOLD.Discount,
                          SAFEWAY.Discount,
                          US.All.Other.Customers.Discount) %>% # add for all customers
  gather(customer, Discount, -Product.ID) %>% 
  distinct() %>% 
  mutate('customer' = str_sub(customer, 1, str_length(customer)-9)) %>% # strip off '.Discount' from end
  select('id' = Product.ID, customer, "discount_rate" = Discount)




df_site_data <- df_email %>% inner_join(df_zip)
df_site_data <- df_site_data %>% inner_join(df_phone)
df_site_data <- df_site_data %>% inner_join(df_address)
df_site_data <- df_site_data %>% inner_join(df_sales)
df_site_data <- df_site_data %>% inner_join(df_dis)


## add unique site id to the duplicate rows of zipcodes as site id
df_site_data <- transform(df_site_data,site_id=as.numeric(factor(zip)))

## add unique id to the duplicate rows of discount as discount id
df_site_data <- transform(df_site_data,discount_id=as.numeric(factor(discount_rate)))

## add unique org ID in original df
df2 <- transform(df2,org_id=as.numeric(factor(Organization)))

## add order id to all rows, total 12000 orders
df_site_data <-  bind_cols('order_id' = sprintf('%d', 1:nrow(df_site_data)), df_site_data)



# need to repeat for all customer-specific attributes like phone, address
# all zips are put into df_zip table, then sequently linked to the cities table, then to states table

############ customers Table ###############
df_customers <- df_site_data %>% select(customer) %>% distinct()
df_customers <- bind_cols('customer_id' = sprintf('%d', 1:nrow(df_customers)), df_customers)
df_site_data <- df_site_data %>% inner_join(df_customers) ## add customer id in site table

########### cust_site table ############
df_cust_site <- df_site_data %>% select(customer_id, site_id)



#### materials table #####
df_materials <- df2 %>% select('material_name' = 'materials') %>% distinct()
df_materials <- bind_cols('material_id' = sprintf('%d', 1:nrow(df_materials)), df_materials)
df2 <- df2 %>% inner_join(df_materials, by=c('materials' = 'material_name'))

### suppliers table ####
df_suppliers <- df2 %>% select('supplier_name' = 'supplier') %>% distinct()
df_suppliers <- bind_cols('supplier_id' = sprintf('%d', 1:nrow(df_suppliers)), df_suppliers)
df2 <- df2 %>% inner_join(df_suppliers, by=c('supplier' = 'supplier_name'))

### supp_mater table ####
df_supp_mater <- df2 %>% select(supplier_id, material_id)






######  manufacturers table #######
df_manufacturers <- df2 %>% select('manu_name' = 'manufacturer') %>% distinct()
df_manufacturers <- bind_cols('manu_id' = sprintf('%d', 1:nrow(df_manufacturers)), df_manufacturers)
df2 <- df2 %>% inner_join(df_manufacturers, by=c('manufacturer' = 'manu_name'))


###### plants table ###
df_plants <- df2 %>% select('plant_name' = 'plants', 'manu_name' = 'manufacturer', manu_id) %>% distinct()
df_plants <- bind_cols('plant_id' = sprintf('%d', 1:nrow(df_plants)), df_plants) %>% 
  select(plant_id, manu_id, plant_name)

######  manu_supplier table #######
df_manu_supp <- df2 %>% select(manu_id, supplier_id )


#### organizations table #####
df_organizations <- df2 %>% select('org_name' = 'Organization') %>% distinct()
df_organizations <- bind_cols('org_id' = sprintf('%d', 1:nrow(df_organizations)), df_organizations)




### categories table ##
df_categories <- df2 %>% select('cat_name' = 'Category') %>% distinct()
df_categories <- bind_cols('cat_id' = sprintf('%d', 1:nrow(df_categories)), df_categories)
df2 <- df2 %>% inner_join(df_categories, by=c('Category' = 'cat_name'))

##org_cat table ##
df_org_cat <- df2 %>% select(org_id,cat_id)

## groups table ##
df_groups <- df2 %>% select('group_name' = 'Group', cat_id) %>% distinct()
df_groups <- bind_cols('group_id' = sprintf('%d', 1:nrow(df_groups)), df_groups)
df2 <- df2 %>% inner_join(df_groups, by=c('Group' = 'group_name'))


## products table ##
df_products <- df2 %>% select('product_id'='Product.ID','product_name' = 'Product',  'total_sales' = 'Sales', 'total_units' = 'Units', group_id,manu_id) %>% distinct()


## inventories table ##
df_inventories <- df2 %>% select('product_id'='Product.ID', 'inv_quantity', 'inv_dep') %>% distinct()

## discount table ##
df_discounts <- df_site_data %>% select('discount_id', 'discount_rate')


## order table ##
df_orders <- df_site_data %>% select('order_id', 'customer_id','Date', 'discount_id') %>% distinct()

## order_product table ##
df_order_product <- df_site_data %>% select('product_id'='id','order_id','product_quantity')





############ write all tables ###################

write.csv(df_cust_site,'C:/Columbia Schoolwork/2019 Spring/SQL and Relational Databases/Project/Upload tables/cust_site.csv')

write.csv(df_orders,'C:/Columbia Schoolwork/2019 Spring/SQL and Relational Databases/Project/Upload tables/orders.csv')

write.csv(df_discounts,'C:/Columbia Schoolwork/2019 Spring/SQL and Relational Databases/Project/Upload tables/discounts.csv')

write.csv(df_order_product,'C:/Columbia Schoolwork/2019 Spring/SQL and Relational Databases/Project/Upload tables/order_product.csv')

write.csv(df_products,'C:/Columbia Schoolwork/2019 Spring/SQL and Relational Databases/Project/Upload tables/products.csv')

write.csv(df_inventories,'C:/Columbia Schoolwork/2019 Spring/SQL and Relational Databases/Project/Upload tables/inventories.csv')

write.csv(df_groups,'C:/Columbia Schoolwork/2019 Spring/SQL and Relational Databases/Project/Upload tables/groups.csv')

write.csv(df_categories,'C:/Columbia Schoolwork/2019 Spring/SQL and Relational Databases/Project/Upload tables/categories.csv')

write.csv(df_org_cat,'C:/Columbia Schoolwork/2019 Spring/SQL and Relational Databases/Project/Upload tables/org_cat.csv')

write.csv(df_organizations,'C:/Columbia Schoolwork/2019 Spring/SQL and Relational Databases/Project/Upload tables/organizations.csv')

write.csv(df_manufacturers,'C:/Columbia Schoolwork/2019 Spring/SQL and Relational Databases/Project/Upload tables/manufacturers.csv')

write.csv(df_plants,'C:/Columbia Schoolwork/2019 Spring/SQL and Relational Databases/Project/Upload tables/plants.csv')

write.csv(df_manu_supp,'C:/Columbia Schoolwork/2019 Spring/SQL and Relational Databases/Project/Upload tables/manu_supp.csv')

write.csv(df_suppliers,'C:/Columbia Schoolwork/2019 Spring/SQL and Relational Databases/Project/Upload tables/suppliers.csv')

write.csv(df_supp_mater,'C:/Columbia Schoolwork/2019 Spring/SQL and Relational Databases/Project/Upload tables/supp_mater.csv')

write.csv(df_materials,'C:/Columbia Schoolwork/2019 Spring/SQL and Relational Databases/Project/Upload tables/materials.csv')



# Free up resources
dbDisconnect(con)
rm(list=ls())

