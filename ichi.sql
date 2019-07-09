with agg_customer_order_types as (

  select
    date(order_time, '+07:00') order_date
    ,customer_no
    ,string_agg(distinct order_type,',' order by order_type) order_types
  from
    `bi-dwh-dev-01.source.daily_order`
  where
    order_status = 'Completed'
  group by
    1,2

)

, agg_customer_order_payments as (

  select
    date(order_time, '+07:00') order_date
    ,customer_no
    ,string_agg(distinct order_payment,'&' order by order_payment) order_payments
  from
    `bi-dwh-dev-01.source.daily_order`
  where
    order_status = 'Completed'
  group by
    1,2

)

, agg_customer_orders as (

  select
    aot.order_date
    ,aot.customer_no
    ,(length(order_types) - length(replace(order_types, ',', '')) + 1) no_of_services
    ,order_types
    ,order_payments
  from
    agg_customer_order_types aot
      left join agg_customer_order_payments aop
        on aop.order_date = aot.order_date
        and aop.customer_no = aot.customer_no
  order by
    1,2
  
)

, customers_by_services as (

  select
    order_date
    ,no_of_services
    ,count(customer_no) total_customer
  from
    agg_customer_orders
  group by
    1,2

)

, customers_by_order_payments_and_types as (

  select
    order_date
    ,order_types
    ,order_payments
    ,no_of_services
    ,count(customer_no) total_customer_per_order_type
  from
    agg_customer_orders
  group by
    1,2,3,4

)

select
	cbs.order_date
	,cbs.no_of_services
	,sum(total_customer) total_customer
	,order_types order_type
  ,sum(total_customer_per_order_type) total_customer_per_order_type
  ,order_payments order_payment
from
	customers_by_services cbs
		left join customers_by_order_payments_and_types cbpt
			on cbpt.order_date = cbs.order_date
			and cbpt.no_of_services = cbs.no_of_services
group by
	1,2,4,6
order by
	1,2