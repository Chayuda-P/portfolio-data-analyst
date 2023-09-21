## Create_table part

CREATE TABLE Menu (
  	 menuID INT,
     Menu_name Text
);

CREATE TABLE invoice (
  	invoiceID INT,
  	customerID INT,
    invoice_date DATE
  );
  
  
CREATE TABLE invoice_item (
	invoice_item INT, 
  	invoiceID INT,
 	menuID INT,
  	unitprice REAL,
  	quantity INT
);


CREATE TABLE customers (
  customerID INT,
  firstname TEXT,
  lastname TEXT,
  city TEXT,
  countey TEXT
);


INSERT INTO Menu VALUES
(1, 'sushi'),
(2, 'smoke salmon'),
(3, 'kyudon');

INSERT INTO invoice VALUES
(1,1,'2023-05-02 12:05:00'),
(2,2,'2023-05-02 12:30:00'),
(3,3,'2023-05-02 12:22:00'),
(4,4,'2023-05-02 15:37:00'),
(5,5,'2023-05-02 16:09:00'),
(6,6,'2023-05-02 11:06:00'),
(7,7,'2023-05-02 15:15:00'),
(8,8,'2023-05-02 11:50:00'),
(9,9,'2023-05-02 14:09:00'),
(10,10,'2023-05-02 14:48:00'),
(11,11,'2023-05-02 12:00:00'),
(12,12,'2023-05-02 12:40:00');


INSERT INTO invoice_item VALUES
(1, 1, 2, 550 , 1),
(2, 1, 1, 700 , 1),
(3, 2, 1, 700, 1),
(4, 3, 3, 800, 2),
(5, 4, 1, 700, 2),
(6, 4, 3, 800, 3),
(7, 5, 2, 550, 10),
(8, 6, 1, 700 ,1),
(9, 6, 3, 800, 1),
(10, 7, 1, 700, 2),
(11, 7, 2, 550, 1),
(12, 8, 3, 800, 1),
(13, 9, 1, 700, 3),
(14, 10, 2, 550, 2),
(15, 10, 1, 700, 1),
(16, 11, 3, 800, 2),
(17, 12, 3, 800, 4);


INSERT INTO customers VALUES
(1,'Rin','Inoue', 'Osaka', 'Japan'),
(2,'Akio','Watanabe','Tokyo','Japan'),
(3,'Haruto','Suzuki','Tokyo','Japan'),
(4, 'Maria','Wang', 'Osaka', 'Japan'),
(5, 'Emily','Chen','Tokyo', 'Japan'),
(6, 'Yahigo','Mori','Tokyo', 'Japan'),
(7, 'teamin','Kim','Osaka', 'Japan'),
(8, 'Alex','Ikeda','Osaka', 'Japan'),
(9, 'Sakura','Goto','Tokyo', 'Japan'),
(10, 'Minako','Abe','Tokyo', 'Japan'),
(11, 'Hikaru','Yamada','Osaka', 'Japan'),
(12, 'Ichiro','Kudo','Osaka', 'Japan');

_____________________________

## Query part

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
