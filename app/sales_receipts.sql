-- view number of nulls in coffee.sales_reciepts
SELECT
    count(IF(transaction_id IS NULL, 1, NULL)) AS transaction_id_nulls,
    count(IF(transaction_date IS NULL, 1, NULL)) AS transaction_date_nulls,
    count(IF(transaction_time IS NULL, 1, NULL)) AS transaction_time_nulls,
    count(IF(sales_outlet_id IS NULL, 1, NULL)) AS sales_outlet_id_nulls,
    count(IF(staff_id IS NULL, 1, NULL)) AS staff_id_nulls,
    count(IF(customer_id IS NULL, 1, NULL)) AS customer_id_nulls,
    count(IF(instore_yn IS NULL, 1, NULL)) AS instore_yn_nulls,
    count(IF(`order` IS NULL, 1, NULL)) AS order_nulls,
    count(IF(line_item_id IS NULL, 1, NULL)) AS line_item_id_nulls,
    count(IF(product_id IS NULL, 1, NULL)) AS product_id_nulls,
    count(IF(quantity IS NULL, 1, NULL)) AS quantity_nulls,
    count(IF(line_item_amount IS NULL, 1, NULL)) AS line_item_amount_nulls,
    count(IF(unit_price IS NULL, 1, NULL)) AS unit_price_nulls,
    count(IF(promo_item_yn IS NULL, 1, NULL)) AS promo_item_yn_nulls
  FROM
    `erik-429611.coffee.sales_reciepts`;

select distinct customer_id
    FROM
    `erik-429611.coffee.sales_reciepts` 
    where instore_yn is null order by customer_id desc;
     --as it apears that all the null values are from store with id 8 and mostly from customer id 0

select * from  `erik-429611.coffee.sales_outlets` 
where sales_outlet_id =8;

select customer_id, count(*) from `erik-429611.coffee.customers` 
where customer_id in (
select distinct customer_id
    FROM
    `erik-429611.coffee.sales_reciepts` 
    where instore_yn is null order by customer_id desc

) group by customer_id;--apart from customers with id of 0 each unique id aprears only once 

---maybe to try and fill the null values with the modal values of such ideas in the instore_yn column

select customer_id from `coffee.sales_reciepts` where instore_yn is null;

create view coffee.sales_reciepts_update_view 
as
WITH customers_instore_ys as (
    SELECT 
        customer_id, 
        instore_yn,
        COUNT(customer_id) AS id_count
    FROM 
        `coffee.sales_reciepts`
    WHERE 
        customer_id IN (
            SELECT customer_id 
            FROM `coffee.sales_reciepts` 
            WHERE instore_yn IS NULL
        )
        AND instore_yn IS NOT NULL
    GROUP BY 
        customer_id, instore_yn
)

, ranked_cleaning_data as
(select *,RANK() OVER (PARTITION BY customer_id ORDER BY id_count DESC) AS data_rank

from 
    customers_instore_ys
ORDER BY 
    customers_instore_ys.id_count desc)

select customer_id,instore_yn from ranked_cleaning_data
where data_rank =1;

--starting the cleaning process
select * from coffee.sales_reciepts_update_view;

select sales_update.customer_id,sales_update.instore_yn, sales_reciepts.customer_id,sales_reciepts.instore_yn 
from 
 `coffee.sales_reciepts` as sales_reciepts join `coffee.sales_reciepts_update_view` as sales_update
 on sales_reciepts.customer_id=sales_update.customer_id
where sales_reciepts.instore_yn is null;



update `coffee.sales_reciepts`  as sales_reciepts
set sales_reciepts.instore_yn = sales_update.instore_yn
from `coffee.sales_reciepts_update_view` as sales_update
where  sales_update.customer_id=sales_reciepts.customer_id
and sales_reciepts.instore_yn is null;
