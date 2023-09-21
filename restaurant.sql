.open restarant.db
. mod column

WITH sub1 AS (SELECT * FROM customer JOIN invoice 
on customer.customer_id = invoice.customer_id
JOIN invoice_item  
ON invoice.invoice_id = invoice_item.invoice_id) , sub2 AS (
  SELECT 
  menu_name,
	unitprice * quantity AS Total,
  invoice_id
FROM menu JOIN invoice_item
ON menu.menu_id = invoice_item.menu_id
)

SELECT 
	sub1.invoice_id,
	sub1.city AS branch,
  sub2.menu_name AS food_order,
	sub1.quantity,
	sub1.unitprice,
  unitprice * quantity AS Total
FROM sub1 JOIN sub2 
ON sub1.invoice_id = sub2.invoice_id
ORDER BY city;



WITH sub1 AS (SELECT * FROM customer JOIN invoice 
on customer.customer_id = invoice.customer_id
JOIN invoice_item  
ON invoice.invoice_id = invoice_item.invoice_id) , sub2 AS (
  SELECT 
  menu_name,
	unitprice * quantity AS Total,
  invoice_id
FROM menu JOIN invoice_item
ON menu.menu_id = invoice_item.menu_id
)

  
SELECT
  branch,
  SUM (Total),
  COUNT (quantity)
FROM (SELECT 
	sub1.invoice_id,
	sub1.city AS branch,
  sub2.menu_name AS food_order,
	sub1.quantity,
	sub1.unitprice,
  unitprice * quantity AS Total
FROM sub1 JOIN sub2 
ON sub1.invoice_id = sub2.invoice_id)
  GROUP BY branch
  ;


SELECT invoice_id,
  STRFTIME('%Y-%m', date) AS monthid,
  STRFTIME('%H:%M', time)
  FROM invoice;


SELECT time,
CASE 
  WHEN time < "13:00" THEN 'Lunch' 
  ELSE 'other'
END AS period

FROM invoice;
