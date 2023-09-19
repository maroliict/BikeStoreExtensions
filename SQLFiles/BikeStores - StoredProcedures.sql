/*
These stored procedures are simple created without error checking. 

*/
CREATE OR ALTER PROCEDURE CSP_AddBikeBrand
	@BrandName VARCHAR(255)  
AS
BEGIN
 SET NOCOUNT ON;
 INSERT INTO production.brands (brand_name) SELECT @BrandName;
 SELECT SCOPE_IDENTITY();
END
GO
--GetBikeBrandID
CREATE OR ALTER PROCEDURE CSP_GetBikeBrandID
	@BrandName VARCHAR(255),
	@ID INT OUTPUT
AS
BEGIN
 SET NOCOUNT ON;
 SELECT	
	@id=BRAND_ID
  FROM production.brands
 WHERE brand_name = @BrandName;
 SELECT @ID
END
GO
-- getstoreID
CREATE OR ALTER PROCEDURE CSP_GetStoreID
	@storeName VARCHAR(255),
    @ID INT OUTPUT
AS
BEGIN
 SET NOCOUNT ON;
 SELECT
	@ID=store_ID
  FROM sales.stores
 WHERE store_name = @storeName;
 SELECT @ID
END

-- Add Products
CREATE OR ALTER PROCEDURE CSP_NewProduct
	@ProductName VARCHAR(255),
	@brandID INT,
	@CatID INT,
	@ModelYear SMALLINT,
	@listPrice Decimal(10,2)

AS
BEGIN

INSERT INTO [production].[products]
           ([product_name]
           ,[brand_id]
           ,[category_id]
           ,[model_year]
           ,[list_price])
     SELECT
           @ProductName
           ,@brandid
           ,@catid
           ,@modelyear
           ,@listPrice;
	SELECT SCOPE_IDENTITY();
END
GO
-- Add Stock
CREATE OR ALTER PROCEDURE CSP_AddStock 
	  @StoreID AS INT
	, @ProductID as INT
	, @QT as INT
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO production.stocks(store_id, product_id, quantity) SELECT @StoreID, SUM(@ProductID), sum(@Qt);
	--INSERT INTO production.stocks(store_id, product_id, quantity) SELECT @StoreID, SUM(500+@ProductID), sum(2*@Qt);
    SELECT SCOPE_IDENTITY();
END
GO