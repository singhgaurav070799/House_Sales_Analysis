
select *
from dbo.raw_sales
--where postcode = '2618'

select top 10 datesold, COUNT(*) as number_of_sales
from dbo.raw_sales
group by datesold 
order by number_of_sales Desc


select top 10 postcode, Avg(price) as average_price_per_sale
from dbo.raw_sales
group by postcode 
order by average_price_per_sale Desc

select top 10 DATEPART(year, datesold) AS datesold,
       count(*) as lowest_number_of_sales
from dbo.raw_sales
group by datesold
order by lowest_number_of_sales ASC



WITH RankedSales AS (
    SELECT 
        postcode, 
        DATEPART(YEAR, datesold) AS sale_year, 
        SUM(price) AS yearly_price,
        ROW_NUMBER() OVER (PARTITION BY DATEPART(YEAR, datesold) ORDER BY SUM(price) DESC) AS rank
    FROM dbo.raw_sales
    GROUP BY postcode, DATEPART(YEAR, datesold)
)
SELECT 
    postcode, 
    sale_year, 
    yearly_price
FROM RankedSales
WHERE rank <= 6






