SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[View_Orderbook]
AS
SELECT       
	SC.last_name + ', ' + SC.first_name AS Customername
	, SC.customer_id
	, SC.city as CustomerCIty
	, SO.order_id
	, SO.order_date
	, SO.order_status
	, OI.quantity
	, OI.list_price
	, OI.discount
	, (OI.quantity * OI.list_price) * (1 - OI.discount) AS OrderTotal
	, st.store_id
	, ST.store_name
	, ST.city as StoreLocation
	, SF.last_name + ', ' + SF.first_name AS Staffmember
	, sf.staff_id
	, SF.active
FROM            sales.orders AS SO INNER JOIN
                         sales.stores AS ST ON SO.store_id = ST.store_id INNER JOIN
                         sales.customers AS SC ON SO.customer_id = SC.customer_id INNER JOIN
                         sales.staffs AS SF ON SO.staff_id = SF.staff_id INNER JOIN
                         sales.order_items AS OI ON SO.order_id = OI.order_id
GO