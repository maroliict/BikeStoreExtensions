USE [BikeStores_2022]
GO

/****** Object:  StoredProcedure [dbo].[csp_SalesData]    Script Date: 8/16/2023 10:52:41 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[csp_SalesData] 

	@Year int = NULL
AS
BEGIN
		SELECT Store_name ,sum(OrderTotal) as Turnover from dbo.View_orderbook where YEAR(order_date)= @year Group by Store_name    

END
GO

