# top 20 sales for the product;
SELECT product_name, total_sales FROM products
WHERE total_sales > 1000000
ORDER BY total_sales desc
limit (20);

# average discount received by the customers
SELECT customer_name, avg(discount_rate) as Average_discount_rate
FROM discounts
JOIN orders on discounts.discount_id = orders.discount_id JOIN customers on orders.customer_id = customers.customer_id
GROUP BY customer_name
ORDER BY Average_discount_rate DESC;


# insert new customers       
INSERT INTO customers(customer_name, customer_id, customer_ceo, customer_website, customer_description)
VALUES ('Costco',13, 'Walter Craig Jelinek', 'https://www.costco.com/', 'Wholesales Club'),
	   ('Wegmans', 14, 'Colleen Wegman', 'https://www.wegmans.com/', 'Grocery store chain'),
	   ('Aldi', 15, 'Marc Heußinger', 'https://www.aldi.us/', 'European chain');
       
# insert new potential sites
INSERT INTO sites(site_id, site_address, zipcode, longitude, latitude, city_id)
VALUES (280, '3525 Progress Drive', 83702, -116.1966137, 43.593522, 265);



# Update the discount_rate;
UPDATE discounts
	SET discount_rate = discount_rate * 0.95
	WHERE discount_rate >= 0.7;
























