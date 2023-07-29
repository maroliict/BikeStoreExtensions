/*
Need to create data for the years 2019 till 2023
For ease of use: No new categories or brands.

only 
    Store was placed to Oslo
    newer products and the 
    same customers for the new products.
    Stock updates.


*/

-- Modify Columns...
ALTER Table sales.stores Alter COLUMN zip_code VARCHAR(10);
exec sp_rename 'sales.stores.State' , 'Country', 'COLUMN';


-- Contstraints should make names unique
ALTER TABLE Production.brands       ADD CONSTRAINT UQ_brand_name        UNIQUE(brand_name);
ALTER TABLE Production.categories   ADD CONSTRAINT UQ_cat_name          UNIQUE(Category_name)
ALTER TABLE Production.products     ADD CONSTRAINT UQ_prodname_modyear  UNIQUE(product_name,model_year)
-- Create some Store Procs for later usage
-- AddBikeBrand
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


/*
Declare all required Parameters Following below examples.
DECLARE @BRANDID AS INT; 
DECLARE @BRANDID2 as INT;
--SET @BRANDID = NULL;
EXEC @brandid	=	dbo.CSP_GetBikebrandID 'cube', @BRANDID OUTPUT
EXEC @BRANDID2	=	dbo.csp_getbikebrandid 'Trek', @BRANDID2 OUTPUT
select 'Blah' =  @brandid
Select 'boeboe' = @BRANDID2
*/



- Product data
-- 2019 Products
EXEC csp_NewProduct  'Trek 820 - 2019'                                  ,9,6,2019,379.99
EXEC csp_NewProduct  'Ritchey Timberwolf Frameset - 2019'               ,5,6,2019,749.99
EXEC csp_NewProduct  'Surly Wednesday Frameset - 2019'                  ,8,6,2019,999.99
EXEC csp_NewProduct  'Trek Fuel EX 8 29 - 2019'                         ,9,6,2019,2899.99
EXEC csp_NewProduct  'Heller Shagamaw Frame - 2019'                     ,3,6,2019,1320.99
EXEC csp_NewProduct  'Surly Ice Cream Truck Frameset - 2019'            ,8,6,2019,469.99
EXEC csp_NewProduct  'Trek Slash 8 27.5 - 2019'                         ,9,6,2019,3999.99
EXEC csp_NewProduct  'Trek Remedy 29 Carbon Frameset - 2019'            ,9,6,2019,1799.99
EXEC csp_NewProduct  'Trek Conduit+ - 2019'                             ,9,5,2019,2999.99
EXEC csp_NewProduct  'Surly Straggler - 2019'                           ,8,4,2019,1549.50
EXEC csp_NewProduct  'Surly Straggler 650b - 2019'                      ,8,4,2019,1680.99
EXEC csp_NewProduct  'Electra Townie Original 21D - 2019'               ,1,3,2019,549.99
EXEC csp_NewProduct  'Electra Cruiser 1 (24-Inch) - 2019'               ,1,3,2019,269.99
EXEC csp_NewProduct  'Electra Girl''s Hawaii 1 (16-inch) - 2015/2019'   ,1,3,2019,269.99
EXEC csp_NewProduct  'Electra Moto 1 - 2019'                            ,1,3,2019,529.99
EXEC csp_NewProduct  'Electra Townie Original 7D EQ - 2019'             ,1,3,2019,599.99
EXEC csp_NewProduct  'Pure Cycles Vine 8-Speed - 2019'                  ,4,3,2019,429.50
EXEC csp_NewProduct  'Pure Cycles Western 3-Speed - Women''s - 2015/2019',4,3,2019,449.50
EXEC csp_NewProduct  'Pure Cycles William 3-Speed - 2019'               ,4,3,2019,449.50
EXEC csp_NewProduct  'Electra Townie Original 7D EQ - Women''s - 2019'  ,1,3,2019,599.99
EXEC csp_NewProduct  'Electra Cruiser 1 (24-Inch) - 2019'               ,1,1,2019,269.99
EXEC csp_NewProduct  'Electra Girl''s Hawaii 1 (16-inch) - 2015/2019'   ,1,1,2019,269.99
EXEC csp_NewProduct  'Electra Girl''s Hawaii 1 (20-inch) - 2015/2019'   ,1,1,2019,299.99
EXEC csp_NewProduct  'Electra Townie Original 21D - 2019'               ,1,2,2019,549.99
EXEC csp_NewProduct  'Electra Townie Original 7D - 2015/2019'           ,1,2,2019,499.99
EXEC csp_NewProduct  'Electra Townie Original 7D EQ - 2019'             ,1,2,2019,599.99
EXEC csp_NewProduct  'Surly Big Dummy Frameset - 2019'                  ,8,6,2019,999.99
EXEC csp_NewProduct  'Surly Karate Monkey 27.5+ Frameset - 2019'        ,8,6,2019,2499.99
EXEC csp_NewProduct  'Trek X-Caliber 8 - 2019'                          ,9,6,2019,999.99
EXEC csp_NewProduct  'Surly Ice Cream Truck Frameset - 2019'            ,8,6,2019,999.99
EXEC csp_NewProduct  'Surly Wednesday - 2019'                           ,8,6,2019,1632.99
EXEC csp_NewProduct  'Trek Farley Alloy Frameset - 2019'                ,9,6,2019,469.99
EXEC csp_NewProduct  'Surly Wednesday Frameset - 2019'                  ,8,6,2019,469.99
EXEC csp_NewProduct  'Trek Session DH 27.5 Carbon Frameset - 2019'      ,9,6,2019,469.99
EXEC csp_NewProduct  'Sun Bicycles Spider 3i - 2019'                    ,7,6,2019,832.99
EXEC csp_NewProduct  'Surly Troll Frameset - 2019'                      ,8,6,2019,832.99
EXEC csp_NewProduct  'Haro Flightline One ST - 2019'                    ,2,6,2019,379.99
EXEC csp_NewProduct  'Haro Flightline Two 26 Plus - 2019'               ,2,6,2019,549.99
EXEC csp_NewProduct  'Trek Stache 5 - 2019'                             ,9,6,2019,1499.99
EXEC csp_NewProduct  'Trek Fuel EX 9.8 29 - 2019'                       ,9,6,2019,4999.99
EXEC csp_NewProduct  'Haro Shift R3 - 2019'                             ,2,6,2019,1469.99
EXEC csp_NewProduct  'Trek Fuel EX 5 27.5 Plus - 2019'                  ,9,6,2019,2299.99
EXEC csp_NewProduct  'Trek Fuel EX 9.8 27.5 Plus - 2019'                ,9,6,2019,5299.99
EXEC csp_NewProduct  'Haro SR 1.1 - 2019'                               ,2,6,2019,539.99
EXEC csp_NewProduct  'Haro SR 1.2 - 2019'                               ,2,6,2019,869.99
EXEC csp_NewProduct  'Haro SR 1.3 - 2019'                               ,2,6,2019,1409.99
EXEC csp_NewProduct  'Trek Remedy 9.8 - 2019'                           ,9,6,2019,5299.99
EXEC csp_NewProduct  'Trek Emonda S 4 - 2019'                           ,9,7,2019,1499.99
EXEC csp_NewProduct  'Trek Domane SL 6 - 2019'                          ,9,7,2019,3499.99
EXEC csp_NewProduct  'Trek Silque SLR 7 Women''s - 2019'                ,9,7,2019,5999.99
EXEC csp_NewProduct  'Trek Silque SLR 8 Women''s - 2019'                ,9,7,2019,6499.99
EXEC csp_NewProduct  'Surly Steamroller - 2019'                         ,8,7,2019,875.99
EXEC csp_NewProduct  'Surly Ogre Frameset - 2019'                       ,8,7,2019,749.99
EXEC csp_NewProduct  'Trek Domane SL Disc Frameset - 2019'              ,9,7,2019,3199.99
EXEC csp_NewProduct  'Trek Domane S 6 - 2019'                           ,9,7,2019,2699.99
EXEC csp_NewProduct  'Trek Domane SLR 6 Disc - 2019'                    ,9,7,2019,5499.99
EXEC csp_NewProduct  'Trek Emonda S 5 - 2019'                           ,9,7,2019,1999.99
EXEC csp_NewProduct  'Trek Madone 9.2 - 2019'                           ,9,7,2019,4999.99
EXEC csp_NewProduct  'Trek Domane S 5 Disc - 2019'                      ,9,7,2019,2599.99
EXEC csp_NewProduct  'Sun Bicycles ElectroLite - 2019'                  ,7,5,2019,1559.99
EXEC csp_NewProduct  'Trek Powerfly 8 FS Plus - 2019'                   ,9,5,2019,4999.99
EXEC csp_NewProduct  'Trek Boone 7 - 2019'                              ,9,4,2019,3499.99
EXEC csp_NewProduct  'Trek Boone Race Shop Limited - 2019'              ,9,4,2019,3499.99
EXEC csp_NewProduct  'Electra Townie Original 7D - 2019'                ,1,3,2019,489.99
EXEC csp_NewProduct  'Sun Bicycles Lil Bolt Type-R - 2019'              ,7,3,2019,346.99
EXEC csp_NewProduct  'Sun Bicycles Revolutions 24 - 2019'               ,7,3,2019,250.99
EXEC csp_NewProduct  'Sun Bicycles Revolutions 24 - Girl''s - 2019'     ,7,3,2019,250.99
EXEC csp_NewProduct  'Sun Bicycles Cruz 3 - 2019'                       ,7,3,2019,449.99
EXEC csp_NewProduct  'Sun Bicycles Cruz 7 - 2019'                       ,7,3,2019,416.99
EXEC csp_NewProduct  'Electra Amsterdam Original 3i - 2015/2019'        ,1,3,2019,659.99
EXEC csp_NewProduct  'Sun Bicycles Atlas X-Type - 2019'                 ,7,3,2019,416.99
EXEC csp_NewProduct  'Sun Bicycles Biscayne Tandem 7 - 2019'            ,7,3,2019,619.99
EXEC csp_NewProduct  'Sun Bicycles Brickell Tandem 7 - 2019'            ,7,3,2019,749.99
EXEC csp_NewProduct  'Electra Cruiser Lux 1 - 2019'                     ,1,3,2019,439.99
EXEC csp_NewProduct  'Electra Cruiser Lux Fat Tire 1 Ladies - 2019'     ,1,3,2019,599.99
EXEC csp_NewProduct  'Electra Girl''s Hawaii 1 16" - 2019'              ,1,3,2019,299.99
EXEC csp_NewProduct  'Electra Glam Punk 3i Ladies'' - 2019'             ,1,3,2019,799.99
EXEC csp_NewProduct  'Sun Bicycles Biscayne Tandem CB - 2019'           ,7,3,2019,647.99
EXEC csp_NewProduct  'Sun Bicycles Boardwalk (24-inch Wheels) - 2019'   ,7,3,2019,402.99
EXEC csp_NewProduct  'Sun Bicycles Brickell Tandem CB - 2019'           ,7,3,2019,761.99
EXEC csp_NewProduct  'Electra Amsterdam Fashion 7i Ladies'' - 2019'     ,1,3,2019,1099.99
EXEC csp_NewProduct  'Electra Amsterdam Original 3i Ladies'' - 2019'    ,1,3,2019,659.99
EXEC csp_NewProduct  'Trek Boy''s Kickster - 2015/2019'                 ,9,1,2019,149.99
EXEC csp_NewProduct  'Sun Bicycles Lil Kitt''n - 2019'                  ,7,1,2019,109.99
EXEC csp_NewProduct  'Haro Downtown 16 - 2019'                          ,2,1,2019,329.99
EXEC csp_NewProduct  'Trek Girl''s Kickster - 2019'                     ,9,1,2019,149.99
EXEC csp_NewProduct  'Trek Precaliber 12 Boys - 2019'                   ,9,1,2019,189.99
EXEC csp_NewProduct  'Trek Precaliber 12 Girls - 2019'                  ,9,1,2019,189.99
EXEC csp_NewProduct  'Trek Precaliber 16 Boys - 2019'                   ,9,1,2019,209.99
EXEC csp_NewProduct  'Trek Precaliber 16 Girls - 2019'                  ,9,1,2019,209.99
EXEC csp_NewProduct  'Trek Precaliber 24 (21-Speed) - Girls - 2019'     ,9,1,2019,349.99
EXEC csp_NewProduct  'Haro Shredder 20 - 2019'                          ,2,1,2019,209.99
EXEC csp_NewProduct  'Haro Shredder 20 Girls - 2019'                    ,2,1,2019,209.99
EXEC csp_NewProduct  'Haro Shredder Pro 20 - 2019'                      ,2,1,2019,249.99
EXEC csp_NewProduct  'Electra Girl''s Hawaii 1 16" - 2019'              ,1,1,2019,299.99
EXEC csp_NewProduct  'Electra Moto 3i (20-inch) - Boy''s - 2019'        ,1,1,2019,349.99
EXEC csp_NewProduct  'Electra Savannah 3i (20-inch) - Girl''s - 2019'   ,1,1,2019,349.99
EXEC csp_NewProduct  'Electra Straight 8 3i (20-inch) - Boy''s - 2019'  ,1,1,2019,489.99
EXEC csp_NewProduct  'Electra Sugar Skulls 1 (20-inch) - Girl''s - 2019',1,1,2019,299.99
EXEC csp_NewProduct  'Electra Townie 3i EQ (20-inch) - Boys'' - 2019'   ,1,1,2019,489.99
EXEC csp_NewProduct  'Electra Townie 7D (20-inch) - Boys'' - 2019'      ,1,1,2019,339.99
EXEC csp_NewProduct  'Electra Townie Original 7D - 2019'                ,1,2,2019,489.99
EXEC csp_NewProduct  'Sun Bicycles Streamway 3 - 2019'                  ,7,2,2019,551.99
EXEC csp_NewProduct  'Sun Bicycles Streamway - 2019'                    ,7,2,2019,481.99
EXEC csp_NewProduct  'Sun Bicycles Streamway 7 - 2019'                  ,7,2,2019,533.99
EXEC csp_NewProduct  'Sun Bicycles Cruz 3 - 2019'                       ,7,2,2019,449.99
EXEC csp_NewProduct  'Sun Bicycles Cruz 7 - 2019'                       ,7,2,2019,416.99
EXEC csp_NewProduct  'Sun Bicycles Cruz 3 - Women''s - 2019'            ,7,2,2019,449.99
EXEC csp_NewProduct  'Sun Bicycles Cruz 7 - Women''s - 2019'            ,7,2,2019,416.99
EXEC csp_NewProduct  'Sun Bicycles Drifter 7 - 2019'                    ,7,2,2019,470.99
EXEC csp_NewProduct  'Sun Bicycles Drifter 7 - Women''s - 2019'         ,7,2,2019,470.99
EXEC csp_NewProduct  'Trek 820 - 2019'                                  ,9,6,2019,379.99
EXEC csp_NewProduct  'Trek Marlin 5 - 2019'                             ,9,6,2019,489.99
EXEC csp_NewProduct  'Trek Marlin 6 - 2019'                             ,9,6,2019,579.99
EXEC csp_NewProduct  'Trek Fuel EX 8 29 - 2019'                         ,9,6,2019,3199.99
EXEC csp_NewProduct  'Trek Marlin 7 - 2019'                             ,9,6,2019,749.99
EXEC csp_NewProduct  'Trek Ticket S Frame - 2019'                       ,9,6,2019,1469.99
EXEC csp_NewProduct  'Trek X-Caliber 8 - 2019'                          ,9,6,2019,999.99
EXEC csp_NewProduct  'Trek Kids'' Neko - 2019'                          ,9,6,2019,469.99
EXEC csp_NewProduct  'Trek Fuel EX 7 29 - 2019'                         ,9,6,2019,2499.99
EXEC csp_NewProduct  'Surly Big Fat Dummy Frameset - 2019'	            ,8,6,2019,469.99
EXEC csp_NewProduct  'Surly Pack Rat Frameset - 2019'	                ,8,6,2019,469.99
EXEC csp_NewProduct  'Surly ECR 27.5 - 2019'	                        ,8,6,2019,1899.00
EXEC csp_NewProduct  'Trek X-Caliber 7 - 2019'	                        ,9,6,2019,919.99
EXEC csp_NewProduct  'Trek Stache Carbon Frameset - 2019'	            ,9,6,2019,919.99
EXEC csp_NewProduct  'Heller Bloodhound Trail - 2019'	                ,3,6,2019,2599.00
EXEC csp_NewProduct  'Trek Procal AL Frameset - 2019'	                ,9,6,2019,1499.99
EXEC csp_NewProduct  'Trek Procaliber Frameset - 2019'	                ,9,6,2019,1499.99
EXEC csp_NewProduct  'Trek Remedy 27.5 C Frameset - 2019'	            ,9,6,2019,1499.99
EXEC csp_NewProduct  'Trek X-Caliber Frameset - 2019'	                ,9,6,2019,1499.99
EXEC csp_NewProduct  'Trek Procaliber 6 - 2019'	                        ,9,6,2019,1799.99
EXEC csp_NewProduct  'Heller Shagamaw GX1 - 2019'	                    ,3,6,2019,2599.00
EXEC csp_NewProduct  'Trek Fuel EX 5 Plus - 2019'	                    ,9,6,2019,2249.99
EXEC csp_NewProduct  'Trek Remedy 7 27.5 - 2019'	                    ,9,6,2019,2999.99
EXEC csp_NewProduct  'Trek Remedy 9.8 27.5 - 2019'	                    ,9,6,2019,4999.99
EXEC csp_NewProduct  'Trek Stache 5 - 2019'	                            ,9,6,2019,1599.99
EXEC csp_NewProduct  'Trek Fuel EX 8 29 XT - 2019'	                    ,9,6,2019,3199.99
EXEC csp_NewProduct  'Trek Powerfly 5 - 2019'	                        ,9,5,2019,3499.99
EXEC csp_NewProduct  'Trek Powerfly 5 FS - 2019'	                    ,9,5,2019,4499.99
EXEC csp_NewProduct  'Trek Powerfly 5 Women - 2019'	                    ,9,5,2019,3499.99
EXEC csp_NewProduct  'Trek Powerfly 7 FS - 2019'	                    ,9,5,2019,4999.99
EXEC csp_NewProduct  'Trek Super Commuter+ 7 - 2019'	                ,9,5,2019,3599.99
EXEC csp_NewProduct  'Trek Super Commuter+ 8S - 2019'	                ,9,5,2019,4999.99
-- 2020 products
EXEC csp_NewProduct  'Trek 820 - 2020'                                  ,9,6,2020,379.99
EXEC csp_NewProduct  'Ritchey Timberwolf Frameset - 2020'               ,5,6,2020,749.99
EXEC csp_NewProduct  'Surly Wednesday Frameset - 2020'                  ,8,6,2020,999.99
EXEC csp_NewProduct  'Trek Fuel EX 8 29 - 2020'                         ,9,6,2020,2899.99
EXEC csp_NewProduct  'Heller Shagamaw Frame - 2020'                     ,3,6,2020,1320.99
EXEC csp_NewProduct  'Surly Ice Cream Truck Frameset - 2020'            ,8,6,2020,469.99
EXEC csp_NewProduct  'Trek Slash 8 27.5 - 2020'                         ,9,6,2020,3999.99
EXEC csp_NewProduct  'Trek Remedy 29 Carbon Frameset - 2020'            ,9,6,2020,1799.99
EXEC csp_NewProduct  'Trek Conduit+ - 2020'                             ,9,5,2020,2999.99
EXEC csp_NewProduct  'Surly Straggler - 2020'                           ,8,4,2020,1549.50
EXEC csp_NewProduct  'Surly Straggler 650b - 2020'                      ,8,4,2020,1680.99
EXEC csp_NewProduct  'Electra Townie Original 21D - 2020'               ,1,3,2020,549.99
EXEC csp_NewProduct  'Electra Cruiser 1 (24-Inch) - 2020'               ,1,3,2020,269.99
EXEC csp_NewProduct  'Electra Girl''s Hawaii 1 (16-inch) - 2015/2020'   ,1,3,2020,269.99
EXEC csp_NewProduct  'Electra Moto 1 - 2020'                            ,1,3,2020,529.99
EXEC csp_NewProduct  'Electra Townie Original 7D EQ - 2020'             ,1,3,2020,599.99
EXEC csp_NewProduct  'Pure Cycles Vine 8-Speed - 2020'                  ,4,3,2020,429.50
EXEC csp_NewProduct  'Pure Cycles Western 3-Speed - Women''s - 2015/2020',4,3,2020,449.50
EXEC csp_NewProduct  'Pure Cycles William 3-Speed - 2020'               ,4,3,2020,449.50
EXEC csp_NewProduct  'Electra Townie Original 7D EQ - Women''s - 2020'  ,1,3,2020,599.99
EXEC csp_NewProduct  'Electra Cruiser 1 (24-Inch) - 2020'               ,1,1,2020,269.99
EXEC csp_NewProduct  'Electra Girl''s Hawaii 1 (16-inch) - 2015/2020'   ,1,1,2020,269.99
EXEC csp_NewProduct  'Electra Girl''s Hawaii 1 (20-inch) - 2015/2020'   ,1,1,2020,299.99
EXEC csp_NewProduct  'Electra Townie Original 21D - 2020'               ,1,2,2020,549.99
EXEC csp_NewProduct  'Electra Townie Original 7D - 2015/2020'           ,1,2,2020,499.99
EXEC csp_NewProduct  'Electra Townie Original 7D EQ - 2020'             ,1,2,2020,599.99
EXEC csp_NewProduct  'Surly Big Dummy Frameset - 2020'                  ,8,6,2020,999.99
EXEC csp_NewProduct  'Surly Karate Monkey 27.5+ Frameset - 2020'        ,8,6,2020,2499.99
EXEC csp_NewProduct  'Trek X-Caliber 8 - 2020'                          ,9,6,2020,999.99
EXEC csp_NewProduct  'Surly Ice Cream Truck Frameset - 2020'            ,8,6,2020,999.99
EXEC csp_NewProduct  'Surly Wednesday - 2020'                           ,8,6,2020,1632.99
EXEC csp_NewProduct  'Trek Farley Alloy Frameset - 2020'                ,9,6,2020,469.99
EXEC csp_NewProduct  'Surly Wednesday Frameset - 2020'                  ,8,6,2020,469.99
EXEC csp_NewProduct  'Trek Session DH 27.5 Carbon Frameset - 2020'      ,9,6,2020,469.99
EXEC csp_NewProduct  'Sun Bicycles Spider 3i - 2020'                    ,7,6,2020,832.99
EXEC csp_NewProduct  'Surly Troll Frameset - 2020'                      ,8,6,2020,832.99
EXEC csp_NewProduct  'Haro Flightline One ST - 2020'                    ,2,6,2020,379.99
EXEC csp_NewProduct  'Haro Flightline Two 26 Plus - 2020'               ,2,6,2020,549.99
EXEC csp_NewProduct  'Trek Stache 5 - 2020'                             ,9,6,2020,1499.99
EXEC csp_NewProduct  'Trek Fuel EX 9.8 29 - 2020'                       ,9,6,2020,4999.99
EXEC csp_NewProduct  'Haro Shift R3 - 2020'                             ,2,6,2020,1469.99
EXEC csp_NewProduct  'Trek Fuel EX 5 27.5 Plus - 2020'                  ,9,6,2020,2299.99
EXEC csp_NewProduct  'Trek Fuel EX 9.8 27.5 Plus - 2020'                ,9,6,2020,5299.99
EXEC csp_NewProduct  'Haro SR 1.1 - 2020'                               ,2,6,2020,539.99
EXEC csp_NewProduct  'Haro SR 1.2 - 2020'                               ,2,6,2020,869.99
EXEC csp_NewProduct  'Haro SR 1.3 - 2020'                               ,2,6,2020,1409.99
EXEC csp_NewProduct  'Trek Remedy 9.8 - 2020'                           ,9,6,2020,5299.99
EXEC csp_NewProduct  'Trek Emonda S 4 - 2020'                           ,9,7,2020,1499.99
EXEC csp_NewProduct  'Trek Domane SL 6 - 2020'                          ,9,7,2020,3499.99
EXEC csp_NewProduct  'Trek Silque SLR 7 Women''s - 2020'                ,9,7,2020,5999.99
EXEC csp_NewProduct  'Trek Silque SLR 8 Women''s - 2020'                ,9,7,2020,6499.99
EXEC csp_NewProduct  'Surly Steamroller - 2020'                         ,8,7,2020,875.99
EXEC csp_NewProduct  'Surly Ogre Frameset - 2020'                       ,8,7,2020,749.99
EXEC csp_NewProduct  'Trek Domane SL Disc Frameset - 2020'              ,9,7,2020,3199.99
EXEC csp_NewProduct  'Trek Domane S 6 - 2020'                           ,9,7,2020,2699.99
EXEC csp_NewProduct  'Trek Domane SLR 6 Disc - 2020'                    ,9,7,2020,5499.99
EXEC csp_NewProduct  'Trek Emonda S 5 - 2020'                           ,9,7,2020,1999.99
EXEC csp_NewProduct  'Trek Madone 9.2 - 2020'                           ,9,7,2020,4999.99
EXEC csp_NewProduct  'Trek Domane S 5 Disc - 2020'                      ,9,7,2020,2599.99
EXEC csp_NewProduct  'Sun Bicycles ElectroLite - 2020'                  ,7,5,2020,1559.99
EXEC csp_NewProduct  'Trek Powerfly 8 FS Plus - 2020'                   ,9,5,2020,4999.99
EXEC csp_NewProduct  'Trek Boone 7 - 2020'                              ,9,4,2020,3499.99
EXEC csp_NewProduct  'Trek Boone Race Shop Limited - 2020'              ,9,4,2020,3499.99
EXEC csp_NewProduct  'Electra Townie Original 7D - 2020'                ,1,3,2020,489.99
EXEC csp_NewProduct  'Sun Bicycles Lil Bolt Type-R - 2020'              ,7,3,2020,346.99
EXEC csp_NewProduct  'Sun Bicycles Revolutions 24 - 2020'               ,7,3,2020,250.99
EXEC csp_NewProduct  'Sun Bicycles Revolutions 24 - Girl''s - 2020'     ,7,3,2020,250.99
EXEC csp_NewProduct  'Sun Bicycles Cruz 3 - 2020'                       ,7,3,2020,449.99
EXEC csp_NewProduct  'Sun Bicycles Cruz 7 - 2020'                       ,7,3,2020,416.99
EXEC csp_NewProduct  'Electra Amsterdam Original 3i - 2015/2020'        ,1,3,2020,659.99
EXEC csp_NewProduct  'Sun Bicycles Atlas X-Type - 2020'                 ,7,3,2020,416.99
EXEC csp_NewProduct  'Sun Bicycles Biscayne Tandem 7 - 2020'            ,7,3,2020,619.99
EXEC csp_NewProduct  'Sun Bicycles Brickell Tandem 7 - 2020'            ,7,3,2020,749.99
EXEC csp_NewProduct  'Electra Cruiser Lux 1 - 2020'                     ,1,3,2020,439.99
EXEC csp_NewProduct  'Electra Cruiser Lux Fat Tire 1 Ladies - 2020'     ,1,3,2020,599.99
EXEC csp_NewProduct  'Electra Girl''s Hawaii 1 16" - 2020'              ,1,3,2020,299.99
EXEC csp_NewProduct  'Electra Glam Punk 3i Ladies'' - 2020'             ,1,3,2020,799.99
EXEC csp_NewProduct  'Sun Bicycles Biscayne Tandem CB - 2020'           ,7,3,2020,647.99
EXEC csp_NewProduct  'Sun Bicycles Boardwalk (24-inch Wheels) - 2020'   ,7,3,2020,402.99
EXEC csp_NewProduct  'Sun Bicycles Brickell Tandem CB - 2020'           ,7,3,2020,761.99
EXEC csp_NewProduct  'Electra Amsterdam Fashion 7i Ladies'' - 2020'     ,1,3,2020,1099.99
EXEC csp_NewProduct  'Electra Amsterdam Original 3i Ladies'' - 2020'    ,1,3,2020,659.99
EXEC csp_NewProduct  'Trek Boy''s Kickster - 2015/2020'                 ,9,1,2020,149.99
EXEC csp_NewProduct  'Sun Bicycles Lil Kitt''n - 2020'                  ,7,1,2020,109.99
EXEC csp_NewProduct  'Haro Downtown 16 - 2020'                          ,2,1,2020,329.99
EXEC csp_NewProduct  'Trek Girl''s Kickster - 2020'                     ,9,1,2020,149.99
EXEC csp_NewProduct  'Trek Precaliber 12 Boys - 2020'                   ,9,1,2020,189.99
EXEC csp_NewProduct  'Trek Precaliber 12 Girls - 2020'                  ,9,1,2020,189.99
EXEC csp_NewProduct  'Trek Precaliber 16 Boys - 2020'                   ,9,1,2020,209.99
EXEC csp_NewProduct  'Trek Precaliber 16 Girls - 2020'                  ,9,1,2020,209.99
EXEC csp_NewProduct  'Trek Precaliber 24 (21-Speed) - Girls - 2020'     ,9,1,2020,349.99
EXEC csp_NewProduct  'Haro Shredder 20 - 2020'                          ,2,1,2020,209.99
EXEC csp_NewProduct  'Haro Shredder 20 Girls - 2020'                    ,2,1,2020,209.99
EXEC csp_NewProduct  'Haro Shredder Pro 20 - 2020'                      ,2,1,2020,249.99
EXEC csp_NewProduct  'Electra Girl''s Hawaii 1 16" - 2020'              ,1,1,2020,299.99
EXEC csp_NewProduct  'Electra Moto 3i (20-inch) - Boy''s - 2020'        ,1,1,2020,349.99
EXEC csp_NewProduct  'Electra Savannah 3i (20-inch) - Girl''s - 2020'   ,1,1,2020,349.99
EXEC csp_NewProduct  'Electra Straight 8 3i (20-inch) - Boy''s - 2020'  ,1,1,2020,489.99
EXEC csp_NewProduct  'Electra Sugar Skulls 1 (20-inch) - Girl''s - 2020',1,1,2020,299.99
EXEC csp_NewProduct  'Electra Townie 3i EQ (20-inch) - Boys'' - 2020'   ,1,1,2020,489.99
EXEC csp_NewProduct  'Electra Townie 7D (20-inch) - Boys'' - 2020'      ,1,1,2020,339.99
EXEC csp_NewProduct  'Electra Townie Original 7D - 2020'                ,1,2,2020,489.99
EXEC csp_NewProduct  'Sun Bicycles Streamway 3 - 2020'                  ,7,2,2020,551.99
EXEC csp_NewProduct  'Sun Bicycles Streamway - 2020'                    ,7,2,2020,481.99
EXEC csp_NewProduct  'Sun Bicycles Streamway 7 - 2020'                  ,7,2,2020,533.99
EXEC csp_NewProduct  'Sun Bicycles Cruz 3 - 2020'                       ,7,2,2020,449.99
EXEC csp_NewProduct  'Sun Bicycles Cruz 7 - 2020'                       ,7,2,2020,416.99
EXEC csp_NewProduct  'Sun Bicycles Cruz 3 - Women''s - 2020'            ,7,2,2020,449.99
EXEC csp_NewProduct  'Sun Bicycles Cruz 7 - Women''s - 2020'            ,7,2,2020,416.99
EXEC csp_NewProduct  'Sun Bicycles Drifter 7 - 2020'                    ,7,2,2020,470.99
EXEC csp_NewProduct  'Sun Bicycles Drifter 7 - Women''s - 2020'         ,7,2,2020,470.99
EXEC csp_NewProduct  'Trek 820 - 2020'                                  ,9,6,2020,379.99
EXEC csp_NewProduct  'Trek Marlin 5 - 2020'                             ,9,6,2020,489.99
EXEC csp_NewProduct  'Trek Marlin 6 - 2020'                             ,9,6,2020,579.99
EXEC csp_NewProduct  'Trek Fuel EX 8 29 - 2020'                         ,9,6,2020,3199.99
EXEC csp_NewProduct  'Trek Marlin 7 - 2020'                             ,9,6,2020,749.99
EXEC csp_NewProduct  'Trek Ticket S Frame - 2020'                       ,9,6,2020,1469.99
EXEC csp_NewProduct  'Trek X-Caliber 8 - 2020'                          ,9,6,2020,999.99
EXEC csp_NewProduct  'Trek Kids'' Neko - 2020'                          ,9,6,2020,469.99
EXEC csp_NewProduct  'Trek Fuel EX 7 29 - 2020'                         ,9,6,2020,2499.99
EXEC csp_NewProduct  'Surly Big Fat Dummy Frameset - 2020'	            ,8,6,2020,469.99
EXEC csp_NewProduct  'Surly Pack Rat Frameset - 2020'	                ,8,6,2020,469.99
EXEC csp_NewProduct  'Surly ECR 27.5 - 2020'	                        ,8,6,2020,1899.00
EXEC csp_NewProduct  'Trek X-Caliber 7 - 2020'	                        ,9,6,2020,919.99
EXEC csp_NewProduct  'Trek Stache Carbon Frameset - 2020'	            ,9,6,2020,919.99
EXEC csp_NewProduct  'Heller Bloodhound Trail - 2020'	                ,3,6,2020,2599.00
EXEC csp_NewProduct  'Trek Procal AL Frameset - 2020'	                ,9,6,2020,1499.99
EXEC csp_NewProduct  'Trek Procaliber Frameset - 2020'	                ,9,6,2020,1499.99
EXEC csp_NewProduct  'Trek Remedy 27.5 C Frameset - 2020'	            ,9,6,2020,1499.99
EXEC csp_NewProduct  'Trek X-Caliber Frameset - 2020'	                ,9,6,2020,1499.99
EXEC csp_NewProduct  'Trek Procaliber 6 - 2020'	                        ,9,6,2020,1799.99
EXEC csp_NewProduct  'Heller Shagamaw GX1 - 2020'	                    ,3,6,2020,2599.00
EXEC csp_NewProduct  'Trek Fuel EX 5 Plus - 2020'	                    ,9,6,2020,2249.99
EXEC csp_NewProduct  'Trek Remedy 7 27.5 - 2020'	                    ,9,6,2020,2999.99
EXEC csp_NewProduct  'Trek Remedy 9.8 27.5 - 2020'	                    ,9,6,2020,4999.99
EXEC csp_NewProduct  'Trek Stache 5 - 2020'	                            ,9,6,2020,1599.99
EXEC csp_NewProduct  'Trek Fuel EX 8 29 XT - 2020'	                    ,9,6,2020,3199.99
EXEC csp_NewProduct  'Trek Powerfly 5 - 2020'	                        ,9,5,2020,3499.99
EXEC csp_NewProduct  'Trek Powerfly 5 FS - 2020'	                    ,9,5,2020,4499.99
EXEC csp_NewProduct  'Trek Powerfly 5 Women - 2020'	                    ,9,5,2020,3499.99
EXEC csp_NewProduct  'Trek Powerfly 7 FS - 2020'	                    ,9,5,2020,4999.99
EXEC csp_NewProduct  'Trek Super Commuter+ 7 - 2020'	                ,9,5,2020,3599.99
EXEC csp_NewProduct  'Trek Super Commuter+ 8S - 2020'	                ,9,5,2020,4999.99
-- 2021 Products
EXEC csp_NewProduct  'Trek 820 - 2021'                                  ,9,6,2021,379.99
EXEC csp_NewProduct  'Ritchey Timberwolf Frameset - 2021'               ,5,6,2021,749.99
EXEC csp_NewProduct  'Surly Wednesday Frameset - 2021'                  ,8,6,2021,999.99
EXEC csp_NewProduct  'Trek Fuel EX 8 29 - 2021'                         ,9,6,2021,2899.99
EXEC csp_NewProduct  'Heller Shagamaw Frame - 2021'                     ,3,6,2021,1320.99
EXEC csp_NewProduct  'Surly Ice Cream Truck Frameset - 2021'            ,8,6,2021,469.99
EXEC csp_NewProduct  'Trek Slash 8 27.5 - 2021'                         ,9,6,2021,3999.99
EXEC csp_NewProduct  'Trek Remedy 29 Carbon Frameset - 2021'            ,9,6,2021,1799.99
EXEC csp_NewProduct  'Trek Conduit+ - 2021'                             ,9,5,2021,2999.99
EXEC csp_NewProduct  'Surly Straggler - 2021'                           ,8,4,2021,1549.50
EXEC csp_NewProduct  'Surly Straggler 650b - 2021'                      ,8,4,2021,1680.99
EXEC csp_NewProduct  'Electra Townie Original 21D - 2021'               ,1,3,2021,549.99
EXEC csp_NewProduct  'Electra Cruiser 1 (24-Inch) - 2021'               ,1,3,2021,269.99
EXEC csp_NewProduct  'Electra Girl''s Hawaii 1 (16-inch) - 2015/2021'   ,1,3,2021,269.99
EXEC csp_NewProduct  'Electra Moto 1 - 2021'                            ,1,3,2021,529.99
EXEC csp_NewProduct  'Electra Townie Original 7D EQ - 2021'             ,1,3,2021,599.99
EXEC csp_NewProduct  'Pure Cycles Vine 8-Speed - 2021'                  ,4,3,2021,429.50
EXEC csp_NewProduct  'Pure Cycles Western 3-Speed - Women''s - 2015/2021',4,3,2021,449.50
EXEC csp_NewProduct  'Pure Cycles William 3-Speed - 2021'               ,4,3,2021,449.50
EXEC csp_NewProduct  'Electra Townie Original 7D EQ - Women''s - 2021'  ,1,3,2021,599.99
EXEC csp_NewProduct  'Electra Cruiser 1 (24-Inch) - 2021'               ,1,1,2021,269.99
EXEC csp_NewProduct  'Electra Girl''s Hawaii 1 (16-inch) - 2015/2021'   ,1,1,2021,269.99
EXEC csp_NewProduct  'Electra Girl''s Hawaii 1 (20-inch) - 2015/2021'   ,1,1,2021,299.99
EXEC csp_NewProduct  'Electra Townie Original 21D - 2021'               ,1,2,2021,549.99
EXEC csp_NewProduct  'Electra Townie Original 7D - 2015/2021'           ,1,2,2021,499.99
EXEC csp_NewProduct  'Electra Townie Original 7D EQ - 2021'             ,1,2,2021,599.99
EXEC csp_NewProduct  'Surly Big Dummy Frameset - 2021'                  ,8,6,2021,999.99
EXEC csp_NewProduct  'Surly Karate Monkey 27.5+ Frameset - 2021'        ,8,6,2021,2499.99
EXEC csp_NewProduct  'Trek X-Caliber 8 - 2021'                          ,9,6,2021,999.99
EXEC csp_NewProduct  'Surly Ice Cream Truck Frameset - 2021'            ,8,6,2021,999.99
EXEC csp_NewProduct  'Surly Wednesday - 2021'                           ,8,6,2021,1632.99
EXEC csp_NewProduct  'Trek Farley Alloy Frameset - 2021'                ,9,6,2021,469.99
EXEC csp_NewProduct  'Surly Wednesday Frameset - 2021'                  ,8,6,2021,469.99
EXEC csp_NewProduct  'Trek Session DH 27.5 Carbon Frameset - 2021'      ,9,6,2021,469.99
EXEC csp_NewProduct  'Sun Bicycles Spider 3i - 2021'                    ,7,6,2021,832.99
EXEC csp_NewProduct  'Surly Troll Frameset - 2021'                      ,8,6,2021,832.99
EXEC csp_NewProduct  'Haro Flightline One ST - 2021'                    ,2,6,2021,379.99
EXEC csp_NewProduct  'Haro Flightline Two 26 Plus - 2021'               ,2,6,2021,549.99
EXEC csp_NewProduct  'Trek Stache 5 - 2021'                             ,9,6,2021,1499.99
EXEC csp_NewProduct  'Trek Fuel EX 9.8 29 - 2021'                       ,9,6,2021,4999.99
EXEC csp_NewProduct  'Haro Shift R3 - 2021'                             ,2,6,2021,1469.99
EXEC csp_NewProduct  'Trek Fuel EX 5 27.5 Plus - 2021'                  ,9,6,2021,2299.99
EXEC csp_NewProduct  'Trek Fuel EX 9.8 27.5 Plus - 2021'                ,9,6,2021,5299.99
EXEC csp_NewProduct  'Haro SR 1.1 - 2021'                               ,2,6,2021,539.99
EXEC csp_NewProduct  'Haro SR 1.2 - 2021'                               ,2,6,2021,869.99
EXEC csp_NewProduct  'Haro SR 1.3 - 2021'                               ,2,6,2021,1409.99
EXEC csp_NewProduct  'Trek Remedy 9.8 - 2021'                           ,9,6,2021,5299.99
EXEC csp_NewProduct  'Trek Emonda S 4 - 2021'                           ,9,7,2021,1499.99
EXEC csp_NewProduct  'Trek Domane SL 6 - 2021'                          ,9,7,2021,3499.99
EXEC csp_NewProduct  'Trek Silque SLR 7 Women''s - 2021'                ,9,7,2021,5999.99
EXEC csp_NewProduct  'Trek Silque SLR 8 Women''s - 2021'                ,9,7,2021,6499.99
EXEC csp_NewProduct  'Surly Steamroller - 2021'                         ,8,7,2021,875.99
EXEC csp_NewProduct  'Surly Ogre Frameset - 2021'                       ,8,7,2021,749.99
EXEC csp_NewProduct  'Trek Domane SL Disc Frameset - 2021'              ,9,7,2021,3199.99
EXEC csp_NewProduct  'Trek Domane S 6 - 2021'                           ,9,7,2021,2699.99
EXEC csp_NewProduct  'Trek Domane SLR 6 Disc - 2021'                    ,9,7,2021,5499.99
EXEC csp_NewProduct  'Trek Emonda S 5 - 2021'                           ,9,7,2021,1999.99
EXEC csp_NewProduct  'Trek Madone 9.2 - 2021'                           ,9,7,2021,4999.99
EXEC csp_NewProduct  'Trek Domane S 5 Disc - 2021'                      ,9,7,2021,2599.99
EXEC csp_NewProduct  'Sun Bicycles ElectroLite - 2021'                  ,7,5,2021,1559.99
EXEC csp_NewProduct  'Trek Powerfly 8 FS Plus - 2021'                   ,9,5,2021,4999.99
EXEC csp_NewProduct  'Trek Boone 7 - 2021'                              ,9,4,2021,3499.99
EXEC csp_NewProduct  'Trek Boone Race Shop Limited - 2021'              ,9,4,2021,3499.99
EXEC csp_NewProduct  'Electra Townie Original 7D - 2021'                ,1,3,2021,489.99
EXEC csp_NewProduct  'Sun Bicycles Lil Bolt Type-R - 2021'              ,7,3,2021,346.99
EXEC csp_NewProduct  'Sun Bicycles Revolutions 24 - 2021'               ,7,3,2021,250.99
EXEC csp_NewProduct  'Sun Bicycles Revolutions 24 - Girl''s - 2021'     ,7,3,2021,250.99
EXEC csp_NewProduct  'Sun Bicycles Cruz 3 - 2021'                       ,7,3,2021,449.99
EXEC csp_NewProduct  'Sun Bicycles Cruz 7 - 2021'                       ,7,3,2021,416.99
EXEC csp_NewProduct  'Electra Amsterdam Original 3i - 2015/2021'        ,1,3,2021,659.99
EXEC csp_NewProduct  'Sun Bicycles Atlas X-Type - 2021'                 ,7,3,2021,416.99
EXEC csp_NewProduct  'Sun Bicycles Biscayne Tandem 7 - 2021'            ,7,3,2021,619.99
EXEC csp_NewProduct  'Sun Bicycles Brickell Tandem 7 - 2021'            ,7,3,2021,749.99
EXEC csp_NewProduct  'Electra Cruiser Lux 1 - 2021'                     ,1,3,2021,439.99
EXEC csp_NewProduct  'Electra Cruiser Lux Fat Tire 1 Ladies - 2021'     ,1,3,2021,599.99
EXEC csp_NewProduct  'Electra Girl''s Hawaii 1 16" - 2021'              ,1,3,2021,299.99
EXEC csp_NewProduct  'Electra Glam Punk 3i Ladies'' - 2021'             ,1,3,2021,799.99
EXEC csp_NewProduct  'Sun Bicycles Biscayne Tandem CB - 2021'           ,7,3,2021,647.99
EXEC csp_NewProduct  'Sun Bicycles Boardwalk (24-inch Wheels) - 2021'   ,7,3,2021,402.99
EXEC csp_NewProduct  'Sun Bicycles Brickell Tandem CB - 2021'           ,7,3,2021,761.99
EXEC csp_NewProduct  'Electra Amsterdam Fashion 7i Ladies'' - 2021'     ,1,3,2021,1099.99
EXEC csp_NewProduct  'Electra Amsterdam Original 3i Ladies'' - 2021'    ,1,3,2021,659.99
EXEC csp_NewProduct  'Trek Boy''s Kickster - 2015/2021'                 ,9,1,2021,149.99
EXEC csp_NewProduct  'Sun Bicycles Lil Kitt''n - 2021'                  ,7,1,2021,109.99
EXEC csp_NewProduct  'Haro Downtown 16 - 2021'                          ,2,1,2021,329.99
EXEC csp_NewProduct  'Trek Girl''s Kickster - 2021'                     ,9,1,2021,149.99
EXEC csp_NewProduct  'Trek Precaliber 12 Boys - 2021'                   ,9,1,2021,189.99
EXEC csp_NewProduct  'Trek Precaliber 12 Girls - 2021'                  ,9,1,2021,189.99
EXEC csp_NewProduct  'Trek Precaliber 16 Boys - 2021'                   ,9,1,2021,209.99
EXEC csp_NewProduct  'Trek Precaliber 16 Girls - 2021'                  ,9,1,2021,209.99
EXEC csp_NewProduct  'Trek Precaliber 24 (21-Speed) - Girls - 2021'     ,9,1,2021,349.99
EXEC csp_NewProduct  'Haro Shredder 20 - 2021'                          ,2,1,2021,209.99
EXEC csp_NewProduct  'Haro Shredder 20 Girls - 2021'                    ,2,1,2021,209.99
EXEC csp_NewProduct  'Haro Shredder Pro 20 - 2021'                      ,2,1,2021,249.99
EXEC csp_NewProduct  'Electra Girl''s Hawaii 1 16" - 2021'              ,1,1,2021,299.99
EXEC csp_NewProduct  'Electra Moto 3i (20-inch) - Boy''s - 2021'        ,1,1,2021,349.99
EXEC csp_NewProduct  'Electra Savannah 3i (20-inch) - Girl''s - 2021'   ,1,1,2021,349.99
EXEC csp_NewProduct  'Electra Straight 8 3i (20-inch) - Boy''s - 2021'  ,1,1,2021,489.99
EXEC csp_NewProduct  'Electra Sugar Skulls 1 (20-inch) - Girl''s - 2021',1,1,2021,299.99
EXEC csp_NewProduct  'Electra Townie 3i EQ (20-inch) - Boys'' - 2021'   ,1,1,2021,489.99
EXEC csp_NewProduct  'Electra Townie 7D (20-inch) - Boys'' - 2021'      ,1,1,2021,339.99
EXEC csp_NewProduct  'Electra Townie Original 7D - 2021'                ,1,2,2021,489.99
EXEC csp_NewProduct  'Sun Bicycles Streamway 3 - 2021'                  ,7,2,2021,551.99
EXEC csp_NewProduct  'Sun Bicycles Streamway - 2021'                    ,7,2,2021,481.99
EXEC csp_NewProduct  'Sun Bicycles Streamway 7 - 2021'                  ,7,2,2021,533.99
EXEC csp_NewProduct  'Sun Bicycles Cruz 3 - 2021'                       ,7,2,2021,449.99
EXEC csp_NewProduct  'Sun Bicycles Cruz 7 - 2021'                       ,7,2,2021,416.99
EXEC csp_NewProduct  'Sun Bicycles Cruz 3 - Women''s - 2021'            ,7,2,2021,449.99
EXEC csp_NewProduct  'Sun Bicycles Cruz 7 - Women''s - 2021'            ,7,2,2021,416.99
EXEC csp_NewProduct  'Sun Bicycles Drifter 7 - 2021'                    ,7,2,2021,470.99
EXEC csp_NewProduct  'Sun Bicycles Drifter 7 - Women''s - 2021'         ,7,2,2021,470.99
EXEC csp_NewProduct  'Trek 820 - 2021'                                  ,9,6,2021,379.99
EXEC csp_NewProduct  'Trek Marlin 5 - 2021'                             ,9,6,2021,489.99
EXEC csp_NewProduct  'Trek Marlin 6 - 2021'                             ,9,6,2021,579.99
EXEC csp_NewProduct  'Trek Fuel EX 8 29 - 2021'                         ,9,6,2021,3199.99
EXEC csp_NewProduct  'Trek Marlin 7 - 2021'                             ,9,6,2021,749.99
EXEC csp_NewProduct  'Trek Ticket S Frame - 2021'                       ,9,6,2021,1469.99
EXEC csp_NewProduct  'Trek X-Caliber 8 - 2021'                          ,9,6,2021,999.99
EXEC csp_NewProduct  'Trek Kids'' Neko - 2021'                          ,9,6,2021,469.99
EXEC csp_NewProduct  'Trek Fuel EX 7 29 - 2021'                         ,9,6,2021,2499.99
EXEC csp_NewProduct  'Surly Big Fat Dummy Frameset - 2021'	            ,8,6,2021,469.99
EXEC csp_NewProduct  'Surly Pack Rat Frameset - 2021'	                ,8,6,2021,469.99
EXEC csp_NewProduct  'Surly ECR 27.5 - 2021'	                        ,8,6,2021,1899.00
EXEC csp_NewProduct  'Trek X-Caliber 7 - 2021'	                        ,9,6,2021,919.99
EXEC csp_NewProduct  'Trek Stache Carbon Frameset - 2021'	            ,9,6,2021,919.99
EXEC csp_NewProduct  'Heller Bloodhound Trail - 2021'	                ,3,6,2021,2599.00
EXEC csp_NewProduct  'Trek Procal AL Frameset - 2021'	                ,9,6,2021,1499.99
EXEC csp_NewProduct  'Trek Procaliber Frameset - 2021'	                ,9,6,2021,1499.99
EXEC csp_NewProduct  'Trek Remedy 27.5 C Frameset - 2021'	            ,9,6,2021,1499.99
EXEC csp_NewProduct  'Trek X-Caliber Frameset - 2021'	                ,9,6,2021,1499.99
EXEC csp_NewProduct  'Trek Procaliber 6 - 2021'	                        ,9,6,2021,1799.99
EXEC csp_NewProduct  'Heller Shagamaw GX1 - 2021'	                    ,3,6,2021,2599.00
EXEC csp_NewProduct  'Trek Fuel EX 5 Plus - 2021'	                    ,9,6,2021,2249.99
EXEC csp_NewProduct  'Trek Remedy 7 27.5 - 2021'	                    ,9,6,2021,2999.99
EXEC csp_NewProduct  'Trek Remedy 9.8 27.5 - 2021'	                    ,9,6,2021,4999.99
EXEC csp_NewProduct  'Trek Stache 5 - 2021'	                            ,9,6,2021,1599.99
EXEC csp_NewProduct  'Trek Fuel EX 8 29 XT - 2021'	                    ,9,6,2021,3199.99
EXEC csp_NewProduct  'Trek Powerfly 5 - 2021'	                        ,9,5,2021,3499.99
EXEC csp_NewProduct  'Trek Powerfly 5 FS - 2021'	                    ,9,5,2021,4499.99
EXEC csp_NewProduct  'Trek Powerfly 5 Women - 2021'	                    ,9,5,2021,3499.99
EXEC csp_NewProduct  'Trek Powerfly 7 FS - 2021'	                    ,9,5,2021,4999.99
EXEC csp_NewProduct  'Trek Super Commuter+ 7 - 2021'	                ,9,5,2021,3599.99
EXEC csp_NewProduct  'Trek Super Commuter+ 8S - 2021'	                ,9,5,2021,4999.99
-- 2022 Products
EXEC csp_NewProduct  'Trek 820 - 2022'                                  ,9,6,2022,379.99
EXEC csp_NewProduct  'Ritchey Timberwolf Frameset - 2022'               ,5,6,2022,749.99
EXEC csp_NewProduct  'Surly Wednesday Frameset - 2022'                  ,8,6,2022,999.99
EXEC csp_NewProduct  'Trek Fuel EX 8 29 - 2022'                         ,9,6,2022,2899.99
EXEC csp_NewProduct  'Heller Shagamaw Frame - 2022'                     ,3,6,2022,1320.99
EXEC csp_NewProduct  'Surly Ice Cream Truck Frameset - 2022'            ,8,6,2022,469.99
EXEC csp_NewProduct  'Trek Slash 8 27.5 - 2022'                         ,9,6,2022,3999.99
EXEC csp_NewProduct  'Trek Remedy 29 Carbon Frameset - 2022'            ,9,6,2022,1799.99
EXEC csp_NewProduct  'Trek Conduit+ - 2022'                             ,9,5,2022,2999.99
EXEC csp_NewProduct  'Surly Straggler - 2022'                           ,8,4,2022,1549.50
EXEC csp_NewProduct  'Surly Straggler 650b - 2022'                      ,8,4,2022,1680.99
EXEC csp_NewProduct  'Electra Townie Original 21D - 2022'               ,1,3,2022,549.99
EXEC csp_NewProduct  'Electra Cruiser 1 (24-Inch) - 2022'               ,1,3,2022,269.99
EXEC csp_NewProduct  'Electra Girl''s Hawaii 1 (16-inch) - 2015/2022'   ,1,3,2022,269.99
EXEC csp_NewProduct  'Electra Moto 1 - 2022'                            ,1,3,2022,529.99
EXEC csp_NewProduct  'Electra Townie Original 7D EQ - 2022'             ,1,3,2022,599.99
EXEC csp_NewProduct  'Pure Cycles Vine 8-Speed - 2022'                  ,4,3,2022,429.50
EXEC csp_NewProduct  'Pure Cycles Western 3-Speed - Women''s - 2015/2022',4,3,2022,449.50
EXEC csp_NewProduct  'Pure Cycles William 3-Speed - 2022'               ,4,3,2022,449.50
EXEC csp_NewProduct  'Electra Townie Original 7D EQ - Women''s - 2022'  ,1,3,2022,599.99
EXEC csp_NewProduct  'Electra Cruiser 1 (24-Inch) - 2022'               ,1,1,2022,269.99
EXEC csp_NewProduct  'Electra Girl''s Hawaii 1 (16-inch) - 2015/2022'   ,1,1,2022,269.99
EXEC csp_NewProduct  'Electra Girl''s Hawaii 1 (20-inch) - 2015/2022'   ,1,1,2022,299.99
EXEC csp_NewProduct  'Electra Townie Original 21D - 2022'               ,1,2,2022,549.99
EXEC csp_NewProduct  'Electra Townie Original 7D - 2015/2022'           ,1,2,2022,499.99
EXEC csp_NewProduct  'Electra Townie Original 7D EQ - 2022'             ,1,2,2022,599.99
EXEC csp_NewProduct  'Surly Big Dummy Frameset - 2022'                  ,8,6,2022,999.99
EXEC csp_NewProduct  'Surly Karate Monkey 27.5+ Frameset - 2022'        ,8,6,2022,2499.99
EXEC csp_NewProduct  'Trek X-Caliber 8 - 2022'                          ,9,6,2022,999.99
EXEC csp_NewProduct  'Surly Ice Cream Truck Frameset - 2022'            ,8,6,2022,999.99
EXEC csp_NewProduct  'Surly Wednesday - 2022'                           ,8,6,2022,1632.99
EXEC csp_NewProduct  'Trek Farley Alloy Frameset - 2022'                ,9,6,2022,469.99
EXEC csp_NewProduct  'Surly Wednesday Frameset - 2022'                  ,8,6,2022,469.99
EXEC csp_NewProduct  'Trek Session DH 27.5 Carbon Frameset - 2022'      ,9,6,2022,469.99
EXEC csp_NewProduct  'Sun Bicycles Spider 3i - 2022'                    ,7,6,2022,832.99
EXEC csp_NewProduct  'Surly Troll Frameset - 2022'                      ,8,6,2022,832.99
EXEC csp_NewProduct  'Haro Flightline One ST - 2022'                    ,2,6,2022,379.99
EXEC csp_NewProduct  'Haro Flightline Two 26 Plus - 2022'               ,2,6,2022,549.99
EXEC csp_NewProduct  'Trek Stache 5 - 2022'                             ,9,6,2022,1499.99
EXEC csp_NewProduct  'Trek Fuel EX 9.8 29 - 2022'                       ,9,6,2022,4999.99
EXEC csp_NewProduct  'Haro Shift R3 - 2022'                             ,2,6,2022,1469.99
EXEC csp_NewProduct  'Trek Fuel EX 5 27.5 Plus - 2022'                  ,9,6,2022,2299.99
EXEC csp_NewProduct  'Trek Fuel EX 9.8 27.5 Plus - 2022'                ,9,6,2022,5299.99
EXEC csp_NewProduct  'Haro SR 1.1 - 2022'                               ,2,6,2022,539.99
EXEC csp_NewProduct  'Haro SR 1.2 - 2022'                               ,2,6,2022,869.99
EXEC csp_NewProduct  'Haro SR 1.3 - 2022'                               ,2,6,2022,1409.99
EXEC csp_NewProduct  'Trek Remedy 9.8 - 2022'                           ,9,6,2022,5299.99
EXEC csp_NewProduct  'Trek Emonda S 4 - 2022'                           ,9,7,2022,1499.99
EXEC csp_NewProduct  'Trek Domane SL 6 - 2022'                          ,9,7,2022,3499.99
EXEC csp_NewProduct  'Trek Silque SLR 7 Women''s - 2022'                ,9,7,2022,5999.99
EXEC csp_NewProduct  'Trek Silque SLR 8 Women''s - 2022'                ,9,7,2022,6499.99
EXEC csp_NewProduct  'Surly Steamroller - 2022'                         ,8,7,2022,875.99
EXEC csp_NewProduct  'Surly Ogre Frameset - 2022'                       ,8,7,2022,749.99
EXEC csp_NewProduct  'Trek Domane SL Disc Frameset - 2022'              ,9,7,2022,3199.99
EXEC csp_NewProduct  'Trek Domane S 6 - 2022'                           ,9,7,2022,2699.99
EXEC csp_NewProduct  'Trek Domane SLR 6 Disc - 2022'                    ,9,7,2022,5499.99
EXEC csp_NewProduct  'Trek Emonda S 5 - 2022'                           ,9,7,2022,1999.99
EXEC csp_NewProduct  'Trek Madone 9.2 - 2022'                           ,9,7,2022,4999.99
EXEC csp_NewProduct  'Trek Domane S 5 Disc - 2022'                      ,9,7,2022,2599.99
EXEC csp_NewProduct  'Sun Bicycles ElectroLite - 2022'                  ,7,5,2022,1559.99
EXEC csp_NewProduct  'Trek Powerfly 8 FS Plus - 2022'                   ,9,5,2022,4999.99
EXEC csp_NewProduct  'Trek Boone 7 - 2022'                              ,9,4,2022,3499.99
EXEC csp_NewProduct  'Trek Boone Race Shop Limited - 2022'              ,9,4,2022,3499.99
EXEC csp_NewProduct  'Electra Townie Original 7D - 2022'                ,1,3,2022,489.99
EXEC csp_NewProduct  'Sun Bicycles Lil Bolt Type-R - 2022'              ,7,3,2022,346.99
EXEC csp_NewProduct  'Sun Bicycles Revolutions 24 - 2022'               ,7,3,2022,250.99
EXEC csp_NewProduct  'Sun Bicycles Revolutions 24 - Girl''s - 2022'     ,7,3,2022,250.99
EXEC csp_NewProduct  'Sun Bicycles Cruz 3 - 2022'                       ,7,3,2022,449.99
EXEC csp_NewProduct  'Sun Bicycles Cruz 7 - 2022'                       ,7,3,2022,416.99
EXEC csp_NewProduct  'Electra Amsterdam Original 3i - 2015/2022'        ,1,3,2022,659.99
EXEC csp_NewProduct  'Sun Bicycles Atlas X-Type - 2022'                 ,7,3,2022,416.99
EXEC csp_NewProduct  'Sun Bicycles Biscayne Tandem 7 - 2022'            ,7,3,2022,619.99
EXEC csp_NewProduct  'Sun Bicycles Brickell Tandem 7 - 2022'            ,7,3,2022,749.99
EXEC csp_NewProduct  'Electra Cruiser Lux 1 - 2022'                     ,1,3,2022,439.99
EXEC csp_NewProduct  'Electra Cruiser Lux Fat Tire 1 Ladies - 2022'     ,1,3,2022,599.99
EXEC csp_NewProduct  'Electra Girl''s Hawaii 1 16" - 2022'              ,1,3,2022,299.99
EXEC csp_NewProduct  'Electra Glam Punk 3i Ladies'' - 2022'             ,1,3,2022,799.99
EXEC csp_NewProduct  'Sun Bicycles Biscayne Tandem CB - 2022'           ,7,3,2022,647.99
EXEC csp_NewProduct  'Sun Bicycles Boardwalk (24-inch Wheels) - 2022'   ,7,3,2022,402.99
EXEC csp_NewProduct  'Sun Bicycles Brickell Tandem CB - 2022'           ,7,3,2022,761.99
EXEC csp_NewProduct  'Electra Amsterdam Fashion 7i Ladies'' - 2022'     ,1,3,2022,1099.99
EXEC csp_NewProduct  'Electra Amsterdam Original 3i Ladies'' - 2022'    ,1,3,2022,659.99
EXEC csp_NewProduct  'Trek Boy''s Kickster - 2015/2022'                 ,9,1,2022,149.99
EXEC csp_NewProduct  'Sun Bicycles Lil Kitt''n - 2022'                  ,7,1,2022,109.99
EXEC csp_NewProduct  'Haro Downtown 16 - 2022'                          ,2,1,2022,329.99
EXEC csp_NewProduct  'Trek Girl''s Kickster - 2022'                     ,9,1,2022,149.99
EXEC csp_NewProduct  'Trek Precaliber 12 Boys - 2022'                   ,9,1,2022,189.99
EXEC csp_NewProduct  'Trek Precaliber 12 Girls - 2022'                  ,9,1,2022,189.99
EXEC csp_NewProduct  'Trek Precaliber 16 Boys - 2022'                   ,9,1,2022,209.99
EXEC csp_NewProduct  'Trek Precaliber 16 Girls - 2022'                  ,9,1,2022,209.99
EXEC csp_NewProduct  'Trek Precaliber 24 (21-Speed) - Girls - 2022'     ,9,1,2022,349.99
EXEC csp_NewProduct  'Haro Shredder 20 - 2022'                          ,2,1,2022,209.99
EXEC csp_NewProduct  'Haro Shredder 20 Girls - 2022'                    ,2,1,2022,209.99
EXEC csp_NewProduct  'Haro Shredder Pro 20 - 2022'                      ,2,1,2022,249.99
EXEC csp_NewProduct  'Electra Girl''s Hawaii 1 16" - 2022'              ,1,1,2022,299.99
EXEC csp_NewProduct  'Electra Moto 3i (20-inch) - Boy''s - 2022'        ,1,1,2022,349.99
EXEC csp_NewProduct  'Electra Savannah 3i (20-inch) - Girl''s - 2022'   ,1,1,2022,349.99
EXEC csp_NewProduct  'Electra Straight 8 3i (20-inch) - Boy''s - 2022'  ,1,1,2022,489.99
EXEC csp_NewProduct  'Electra Sugar Skulls 1 (20-inch) - Girl''s - 2022',1,1,2022,299.99
EXEC csp_NewProduct  'Electra Townie 3i EQ (20-inch) - Boys'' - 2022'   ,1,1,2022,489.99
EXEC csp_NewProduct  'Electra Townie 7D (20-inch) - Boys'' - 2022'      ,1,1,2022,339.99
EXEC csp_NewProduct  'Electra Townie Original 7D - 2022'                ,1,2,2022,489.99
EXEC csp_NewProduct  'Sun Bicycles Streamway 3 - 2022'                  ,7,2,2022,551.99
EXEC csp_NewProduct  'Sun Bicycles Streamway - 2022'                    ,7,2,2022,481.99
EXEC csp_NewProduct  'Sun Bicycles Streamway 7 - 2022'                  ,7,2,2022,533.99
EXEC csp_NewProduct  'Sun Bicycles Cruz 3 - 2022'                       ,7,2,2022,449.99
EXEC csp_NewProduct  'Sun Bicycles Cruz 7 - 2022'                       ,7,2,2022,416.99
EXEC csp_NewProduct  'Sun Bicycles Cruz 3 - Women''s - 2022'            ,7,2,2022,449.99
EXEC csp_NewProduct  'Sun Bicycles Cruz 7 - Women''s - 2022'            ,7,2,2022,416.99
EXEC csp_NewProduct  'Sun Bicycles Drifter 7 - 2022'                    ,7,2,2022,470.99
EXEC csp_NewProduct  'Sun Bicycles Drifter 7 - Women''s - 2022'         ,7,2,2022,470.99
EXEC csp_NewProduct  'Trek 820 - 2022'                                  ,9,6,2022,379.99
EXEC csp_NewProduct  'Trek Marlin 5 - 2022'                             ,9,6,2022,489.99
EXEC csp_NewProduct  'Trek Marlin 6 - 2022'                             ,9,6,2022,579.99
EXEC csp_NewProduct  'Trek Fuel EX 8 29 - 2022'                         ,9,6,2022,3199.99
EXEC csp_NewProduct  'Trek Marlin 7 - 2022'                             ,9,6,2022,749.99
EXEC csp_NewProduct  'Trek Ticket S Frame - 2022'                       ,9,6,2022,1469.99
EXEC csp_NewProduct  'Trek X-Caliber 8 - 2022'                          ,9,6,2022,999.99
EXEC csp_NewProduct  'Trek Kids'' Neko - 2022'                          ,9,6,2022,469.99
EXEC csp_NewProduct  'Trek Fuel EX 7 29 - 2022'                         ,9,6,2022,2499.99
EXEC csp_NewProduct  'Surly Big Fat Dummy Frameset - 2022'	            ,8,6,2022,469.99
EXEC csp_NewProduct  'Surly Pack Rat Frameset - 2022'	                ,8,6,2022,469.99
EXEC csp_NewProduct  'Surly ECR 27.5 - 2022'	                        ,8,6,2022,1899.00
EXEC csp_NewProduct  'Trek X-Caliber 7 - 2022'	                        ,9,6,2022,919.99
EXEC csp_NewProduct  'Trek Stache Carbon Frameset - 2022'	            ,9,6,2022,919.99
EXEC csp_NewProduct  'Heller Bloodhound Trail - 2022'	                ,3,6,2022,2599.00
EXEC csp_NewProduct  'Trek Procal AL Frameset - 2022'	                ,9,6,2022,1499.99
EXEC csp_NewProduct  'Trek Procaliber Frameset - 2022'	                ,9,6,2022,1499.99
EXEC csp_NewProduct  'Trek Remedy 27.5 C Frameset - 2022'	            ,9,6,2022,1499.99
EXEC csp_NewProduct  'Trek X-Caliber Frameset - 2022'	                ,9,6,2022,1499.99
EXEC csp_NewProduct  'Trek Procaliber 6 - 2022'	                        ,9,6,2022,1799.99
EXEC csp_NewProduct  'Heller Shagamaw GX1 - 2022'	                    ,3,6,2022,2599.00
EXEC csp_NewProduct  'Trek Fuel EX 5 Plus - 2022'	                    ,9,6,2022,2249.99
EXEC csp_NewProduct  'Trek Remedy 7 27.5 - 2022'	                    ,9,6,2022,2999.99
EXEC csp_NewProduct  'Trek Remedy 9.8 27.5 - 2022'	                    ,9,6,2022,4999.99
EXEC csp_NewProduct  'Trek Stache 5 - 2022'	                            ,9,6,2022,1599.99
EXEC csp_NewProduct  'Trek Fuel EX 8 29 XT - 2022'	                    ,9,6,2022,3199.99
EXEC csp_NewProduct  'Trek Powerfly 5 - 2022'	                        ,9,5,2022,3499.99
EXEC csp_NewProduct  'Trek Powerfly 5 FS - 2022'	                    ,9,5,2022,4499.99
EXEC csp_NewProduct  'Trek Powerfly 5 Women - 2022'	                    ,9,5,2022,3499.99
EXEC csp_NewProduct  'Trek Powerfly 7 FS - 2022'	                    ,9,5,2022,4999.99
EXEC csp_NewProduct  'Trek Super Commuter+ 7 - 2022'	                ,9,5,2022,3599.99
EXEC csp_NewProduct  'Trek Super Commuter+ 8S - 2022'	                ,9,5,2022,4999.99
-- 2023 Products



- Customer Data

- Store to Oslo
- Only stock in Oslo/Webshop
-- production.stocks 
EXEC CSP_AddStock 7,1,27
EXEC CSP_AddStock 7,2,5 
EXEC CSP_AddStock 7,3,6 
EXEC CSP_AddStock 7,4,23 
EXEC CSP_AddStock 7,5,22 
EXEC CSP_AddStock 7,6,0 
EXEC CSP_AddStock 7,7,8 
EXEC CSP_AddStock 7,8,0 
EXEC CSP_AddStock 7,9,11 
EXEC CSP_AddStock 7,10,15 
EXEC CSP_AddStock 7,11,8 
EXEC CSP_AddStock 7,12,16 
EXEC CSP_AddStock 7,13,13 
EXEC CSP_AddStock 7,14,8 
EXEC CSP_AddStock 7,15,3 
EXEC CSP_AddStock 7,16,4 
EXEC CSP_AddStock 7,17,2 
EXEC CSP_AddStock 7,18,16 
EXEC CSP_AddStock 7,19,4 
EXEC CSP_AddStock 7,20,26 
EXEC CSP_AddStock 7,21,24 
EXEC CSP_AddStock 7,22,29 
EXEC CSP_AddStock 7,23,9 
EXEC CSP_AddStock 7,24,10 
EXEC CSP_AddStock 7,25,10 
EXEC CSP_AddStock 7,26,16 
EXEC CSP_AddStock 7,27,21 
EXEC CSP_AddStock 7,28,20 
EXEC CSP_AddStock 7,29,13 
EXEC CSP_AddStock 7,30,30 
EXEC CSP_AddStock 7,31,2 
EXEC CSP_AddStock 7,32,0 
EXEC CSP_AddStock 7,33,10 
EXEC CSP_AddStock 7,34,2 
EXEC CSP_AddStock 7,35,18 
EXEC CSP_AddStock 7,36,26 
EXEC CSP_AddStock 7,37,12 
EXEC CSP_AddStock 7,38,13 
EXEC CSP_AddStock 7,39,2 
EXEC CSP_AddStock 7,40,24 
EXEC CSP_AddStock 7,41,10 
EXEC CSP_AddStock 7,42,0 
EXEC CSP_AddStock 7,43,2 
EXEC CSP_AddStock 7,44,1 
EXEC CSP_AddStock 7,45,15 
EXEC CSP_AddStock 7,46,19 
EXEC CSP_AddStock 7,47,21 
EXEC CSP_AddStock 7,48,5 
EXEC CSP_AddStock 7,49,8 
EXEC CSP_AddStock 7,50,29 
EXEC CSP_AddStock 7,51,2 
EXEC CSP_AddStock 7,52,18 
EXEC CSP_AddStock 7,53,17 
EXEC CSP_AddStock 7,54,11 
EXEC CSP_AddStock 7,55,11 
EXEC CSP_AddStock 7,56,15 
EXEC CSP_AddStock 7,57,1 
EXEC CSP_AddStock 7,58,1 
EXEC CSP_AddStock 7,59,22 
EXEC CSP_AddStock 7,60,19 
EXEC CSP_AddStock 7,61,30 
EXEC CSP_AddStock 7,62,21 
EXEC CSP_AddStock 7,63,4 
EXEC CSP_AddStock 7,64,30 
EXEC CSP_AddStock 7,65,10 
EXEC CSP_AddStock 7,66,12 
EXEC CSP_AddStock 7,67,19 
EXEC CSP_AddStock 7,68,30 
EXEC CSP_AddStock 7,69,4 
EXEC CSP_AddStock 7,70,3 
EXEC CSP_AddStock 7,71,25 
EXEC CSP_AddStock 7,72,9 
EXEC CSP_AddStock 7,73,7 
EXEC CSP_AddStock 7,74,9 
EXEC CSP_AddStock 7,75,23 
EXEC CSP_AddStock 7,76,15 
EXEC CSP_AddStock 7,77,16 
EXEC CSP_AddStock 7,78,13 
EXEC CSP_AddStock 7,79,13 
EXEC CSP_AddStock 7,80,11 
EXEC CSP_AddStock 7,81,25 
EXEC CSP_AddStock 7,82,1 
EXEC CSP_AddStock 7,83,13 
EXEC CSP_AddStock 7,84,11 
EXEC CSP_AddStock 7,85,23 
EXEC CSP_AddStock 7,86,19 
EXEC CSP_AddStock 7,87,27 
EXEC CSP_AddStock 7,88,7 
EXEC CSP_AddStock 7,89,9 
EXEC CSP_AddStock 7,90,4 
EXEC CSP_AddStock 7,91,8 
EXEC CSP_AddStock 7,92,0 
EXEC CSP_AddStock 7,93,22 
EXEC CSP_AddStock 7,94,6 
EXEC CSP_AddStock 7,95,25 
EXEC CSP_AddStock 7,96,20 
EXEC CSP_AddStock 7,97,20 
EXEC CSP_AddStock 7,98,28 
EXEC CSP_AddStock 7,99,28 
EXEC CSP_AddStock 7,100,15 
EXEC CSP_AddStock 7,101,17 
EXEC CSP_AddStock 7,102,9 
EXEC CSP_AddStock 7,103,13 
EXEC CSP_AddStock 7,104,25 
EXEC CSP_AddStock 7,105,7 
EXEC CSP_AddStock 7,106,30 
EXEC CSP_AddStock 7,107,20 
EXEC CSP_AddStock 7,108,15 
EXEC CSP_AddStock 7,109,30 
EXEC CSP_AddStock 7,110,1 
EXEC CSP_AddStock 7,111,11 
EXEC CSP_AddStock 7,112,17 
EXEC CSP_AddStock 7,113,24 
EXEC CSP_AddStock 7,114,3 
EXEC CSP_AddStock 7,115,10 
EXEC CSP_AddStock 7,116,24 
EXEC CSP_AddStock 7,117,15 
EXEC CSP_AddStock 7,118,12 
EXEC CSP_AddStock 7,119,17 
EXEC CSP_AddStock 7,120,23 
EXEC CSP_AddStock 7,121,19 
EXEC CSP_AddStock 7,122,22 
EXEC CSP_AddStock 7,123,8 
EXEC CSP_AddStock 7,124,23 
EXEC CSP_AddStock 7,125,22 
EXEC CSP_AddStock 7,126,28 
EXEC CSP_AddStock 7,127,12 
EXEC CSP_AddStock 7,128,11 
EXEC CSP_AddStock 7,129,21 
EXEC CSP_AddStock 7,130,22 
EXEC CSP_AddStock 7,131,20 
EXEC CSP_AddStock 7,132,1 
EXEC CSP_AddStock 7,133,9 
EXEC CSP_AddStock 7,134,26 
EXEC CSP_AddStock 7,135,15 
EXEC CSP_AddStock 7,136,12 
EXEC CSP_AddStock 7,137,12 
EXEC CSP_AddStock 7,138,6 
EXEC CSP_AddStock 7,139,17 
EXEC CSP_AddStock 7,140,3 
EXEC CSP_AddStock 7,141,21 
EXEC CSP_AddStock 7,142,22 
EXEC CSP_AddStock 7,143,19 
EXEC CSP_AddStock 7,144,7 
EXEC CSP_AddStock 7,145,5 
EXEC CSP_AddStock 7,146,6 
EXEC CSP_AddStock 7,147,8 
EXEC CSP_AddStock 7,148,6 
EXEC CSP_AddStock 7,149,1 
EXEC CSP_AddStock 7,150,22 
EXEC CSP_AddStock 7,151,24 
EXEC CSP_AddStock 7,152,12 
EXEC CSP_AddStock 7,153,25 
EXEC CSP_AddStock 7,154,13 
EXEC CSP_AddStock 7,155,8 
EXEC CSP_AddStock 7,156,13 
EXEC CSP_AddStock 7,157,25 
EXEC CSP_AddStock 7,158,11 
EXEC CSP_AddStock 7,159,18 
EXEC CSP_AddStock 7,160,0 
EXEC CSP_AddStock 7,161,17 
EXEC CSP_AddStock 7,162,14 
EXEC CSP_AddStock 7,163,0 
EXEC CSP_AddStock 7,164,15 
EXEC CSP_AddStock 7,165,16 
EXEC CSP_AddStock 7,166,23 
EXEC CSP_AddStock 7,167,28 
EXEC CSP_AddStock 7,168,0 
EXEC CSP_AddStock 7,169,25 
EXEC CSP_AddStock 7,170,14 
EXEC CSP_AddStock 7,171,3 
EXEC CSP_AddStock 7,172,3 
EXEC CSP_AddStock 7,173,2 
EXEC CSP_AddStock 7,174,26 
EXEC CSP_AddStock 7,175,2 
EXEC CSP_AddStock 7,176,11 
EXEC CSP_AddStock 7,177,19 
EXEC CSP_AddStock 7,178,23 
EXEC CSP_AddStock 7,179,16 
EXEC CSP_AddStock 7,180,5 
EXEC CSP_AddStock 7,181,19 
EXEC CSP_AddStock 7,182,28 
EXEC CSP_AddStock 7,183,11 
EXEC CSP_AddStock 7,184,4 
EXEC CSP_AddStock 7,185,3 
EXEC CSP_AddStock 7,186,1 
EXEC CSP_AddStock 7,187,16 
EXEC CSP_AddStock 7,188,30 
EXEC CSP_AddStock 7,189,6 
EXEC CSP_AddStock 7,190,21 
EXEC CSP_AddStock 7,191,21 
EXEC CSP_AddStock 7,192,20 
EXEC CSP_AddStock 7,193,30 
EXEC CSP_AddStock 7,194,24 
EXEC CSP_AddStock 7,195,1 
EXEC CSP_AddStock 7,196,26 
EXEC CSP_AddStock 7,197,22 
EXEC CSP_AddStock 7,198,1 
EXEC CSP_AddStock 7,199,2 
EXEC CSP_AddStock 7,200,27 
EXEC CSP_AddStock 7,201,16 
EXEC CSP_AddStock 7,202,5 
EXEC CSP_AddStock 7,203,4 
EXEC CSP_AddStock 7,204,23 
EXEC CSP_AddStock 7,205,9 
EXEC CSP_AddStock 7,206,10 
EXEC CSP_AddStock 7,207,27 
EXEC CSP_AddStock 7,208,13 
EXEC CSP_AddStock 7,209,22 
EXEC CSP_AddStock 7,210,25 
EXEC CSP_AddStock 7,211,13 
EXEC CSP_AddStock 7,212,17 
EXEC CSP_AddStock 7,213,14 
EXEC CSP_AddStock 7,214,4 
EXEC CSP_AddStock 7,215,1 
EXEC CSP_AddStock 7,216,11 
EXEC CSP_AddStock 7,217,11 
EXEC CSP_AddStock 7,218,27 
EXEC CSP_AddStock 7,219,30 
EXEC CSP_AddStock 7,220,4 
EXEC CSP_AddStock 7,221,7 
EXEC CSP_AddStock 7,222,12 
EXEC CSP_AddStock 7,223,3 
EXEC CSP_AddStock 7,224,16 
EXEC CSP_AddStock 7,225,24 
EXEC CSP_AddStock 7,226,18 
EXEC CSP_AddStock 7,227,19 
EXEC CSP_AddStock 7,228,22 
EXEC CSP_AddStock 7,229,27 
EXEC CSP_AddStock 7,230,7 
EXEC CSP_AddStock 7,231,25 
EXEC CSP_AddStock 7,232,5 
EXEC CSP_AddStock 7,233,5 
EXEC CSP_AddStock 7,234,13 
EXEC CSP_AddStock 7,235,7 
EXEC CSP_AddStock 7,236,18 
EXEC CSP_AddStock 7,237,26 
EXEC CSP_AddStock 7,238,20 
EXEC CSP_AddStock 7,239,28 
EXEC CSP_AddStock 7,240,17 
EXEC CSP_AddStock 7,241,17 
EXEC CSP_AddStock 7,242,10 
EXEC CSP_AddStock 7,243,11 
EXEC CSP_AddStock 7,244,10 
EXEC CSP_AddStock 7,245,3 
EXEC CSP_AddStock 7,246,0 
EXEC CSP_AddStock 7,247,15 
EXEC CSP_AddStock 7,248,14 
EXEC CSP_AddStock 7,249,27 
EXEC CSP_AddStock 7,250,3 
EXEC CSP_AddStock 7,251,2 
EXEC CSP_AddStock 7,252,28 
EXEC CSP_AddStock 7,253,16 
EXEC CSP_AddStock 7,254,24 
EXEC CSP_AddStock 7,255,13 
EXEC CSP_AddStock 7,256,20 
EXEC CSP_AddStock 7,257,17 
EXEC CSP_AddStock 7,258,25 
EXEC CSP_AddStock 7,259,10 
EXEC CSP_AddStock 7,260,20 
EXEC CSP_AddStock 7,261,3 
EXEC CSP_AddStock 7,262,6 
EXEC CSP_AddStock 7,263,21 
EXEC CSP_AddStock 7,264,16 
EXEC CSP_AddStock 7,265,28 
EXEC CSP_AddStock 7,266,1 
EXEC CSP_AddStock 7,267,27 
EXEC CSP_AddStock 7,268,23 
EXEC CSP_AddStock 7,269,22 
EXEC CSP_AddStock 7,270,16 
EXEC CSP_AddStock 7,271,6 
EXEC CSP_AddStock 7,272,14 
EXEC CSP_AddStock 7,273,20 
EXEC CSP_AddStock 7,274,19 
EXEC CSP_AddStock 7,275,28 
EXEC CSP_AddStock 7,276,7 
EXEC CSP_AddStock 7,277,13 
EXEC CSP_AddStock 7,278,17 
EXEC CSP_AddStock 7,279,17 
EXEC CSP_AddStock 7,280,23 
EXEC CSP_AddStock 7,281,11 
EXEC CSP_AddStock 7,282,6 
EXEC CSP_AddStock 7,283,10 
EXEC CSP_AddStock 7,284,27 
EXEC CSP_AddStock 7,285,20 
EXEC CSP_AddStock 7,286,28 
EXEC CSP_AddStock 7,287,2 
EXEC CSP_AddStock 7,288,9 
EXEC CSP_AddStock 7,289,2 
EXEC CSP_AddStock 7,290,8 
EXEC CSP_AddStock 7,291,9 
EXEC CSP_AddStock 7,292,30 
EXEC CSP_AddStock 7,293,18 
EXEC CSP_AddStock 7,294,3 
EXEC CSP_AddStock 7,295,24 
EXEC CSP_AddStock 7,296,9 
EXEC CSP_AddStock 7,297,22 
EXEC CSP_AddStock 7,298,26 
EXEC CSP_AddStock 7,299,18 
EXEC CSP_AddStock 7,300,7 
EXEC CSP_AddStock 7,301,10 
EXEC CSP_AddStock 7,302,0 
EXEC CSP_AddStock 7,303,12 
EXEC CSP_AddStock 7,304,15 
EXEC CSP_AddStock 7,305,23 
EXEC CSP_AddStock 7,306,21 
EXEC CSP_AddStock 7,307,17 
EXEC CSP_AddStock 7,308,23 
EXEC CSP_AddStock 7,309,7 
EXEC CSP_AddStock 7,310,18 
EXEC CSP_AddStock 7,311,20 
EXEC CSP_AddStock 7,312,23 
EXEC CSP_AddStock 7,313,14 
EXEC CSP_AddStock 9,1,14 
EXEC CSP_AddStock 9,2,16 
EXEC CSP_AddStock 9,3,28 
EXEC CSP_AddStock 9,4,2 
EXEC CSP_AddStock 9,5,1 
EXEC CSP_AddStock 9,6,11 
EXEC CSP_AddStock 9,7,8 
EXEC CSP_AddStock 9,8,1 
EXEC CSP_AddStock 9,9,17 
EXEC CSP_AddStock 9,10,13 
EXEC CSP_AddStock 9,11,21 
EXEC CSP_AddStock 9,12,2 
EXEC CSP_AddStock 9,13,1 
EXEC CSP_AddStock 9,14,18 
EXEC CSP_AddStock 9,15,6 
EXEC CSP_AddStock 9,16,20 
EXEC CSP_AddStock 9,17,3 
EXEC CSP_AddStock 9,18,13 
EXEC CSP_AddStock 9,19,15 
EXEC CSP_AddStock 9,20,20 
EXEC CSP_AddStock 9,21,16 
EXEC CSP_AddStock 9,22,0 
EXEC CSP_AddStock 9,23,12 
EXEC CSP_AddStock 9,24,16 
EXEC CSP_AddStock 9,25,18 
EXEC CSP_AddStock 9,26,2 
EXEC CSP_AddStock 9,27,10 
EXEC CSP_AddStock 9,28,25 
EXEC CSP_AddStock 9,29,29 
EXEC CSP_AddStock 9,30,17 
EXEC CSP_AddStock 9,31,10 
EXEC CSP_AddStock 9,32,13 
EXEC CSP_AddStock 9,33,8 
EXEC CSP_AddStock 9,34,24 
EXEC CSP_AddStock 9,35,25 
EXEC CSP_AddStock 9,36,15 
EXEC CSP_AddStock 9,37,5 
EXEC CSP_AddStock 9,38,18 
EXEC CSP_AddStock 9,39,28 
EXEC CSP_AddStock 9,40,15 
EXEC CSP_AddStock 9,41,6 
EXEC CSP_AddStock 9,42,16 
EXEC CSP_AddStock 9,43,2 
EXEC CSP_AddStock 9,44,24 
EXEC CSP_AddStock 9,45,13 
EXEC CSP_AddStock 9,46,18 
EXEC CSP_AddStock 9,47,0 
EXEC CSP_AddStock 9,48,20 
EXEC CSP_AddStock 9,49,4 
EXEC CSP_AddStock 9,50,7 
EXEC CSP_AddStock 9,51,8 
EXEC CSP_AddStock 9,52,23 
EXEC CSP_AddStock 9,53,19 
EXEC CSP_AddStock 9,54,6 
EXEC CSP_AddStock 9,55,5 
EXEC CSP_AddStock 9,56,20 
EXEC CSP_AddStock 9,57,27 
EXEC CSP_AddStock 9,58,15 
EXEC CSP_AddStock 9,59,17 
EXEC CSP_AddStock 9,60,1 
EXEC CSP_AddStock 9,61,20 
EXEC CSP_AddStock 9,62,4 
EXEC CSP_AddStock 9,63,5 
EXEC CSP_AddStock 9,64,30 
EXEC CSP_AddStock 9,65,16 
EXEC CSP_AddStock 9,66,22 
EXEC CSP_AddStock 9,67,8 
EXEC CSP_AddStock 9,68,23 
EXEC CSP_AddStock 9,69,22 
EXEC CSP_AddStock 9,70,6 
EXEC CSP_AddStock 9,71,30 
EXEC CSP_AddStock 9,72,1 
EXEC CSP_AddStock 9,73,20 
EXEC CSP_AddStock 9,74,23 
EXEC CSP_AddStock 9,75,11 
EXEC CSP_AddStock 9,76,20 
EXEC CSP_AddStock 9,77,25 
EXEC CSP_AddStock 9,78,4 
EXEC CSP_AddStock 9,79,29 
EXEC CSP_AddStock 9,80,27 
EXEC CSP_AddStock 9,81,19 
EXEC CSP_AddStock 9,82,4 
EXEC CSP_AddStock 9,83,21 
EXEC CSP_AddStock 9,84,22 
EXEC CSP_AddStock 9,85,6 
EXEC CSP_AddStock 9,86,24 
EXEC CSP_AddStock 9,87,14 
EXEC CSP_AddStock 9,88,8 
EXEC CSP_AddStock 9,89,8 
EXEC CSP_AddStock 9,90,26 
EXEC CSP_AddStock 9,91,0 
EXEC CSP_AddStock 9,92,22 
EXEC CSP_AddStock 9,93,22 
EXEC CSP_AddStock 9,94,2 
EXEC CSP_AddStock 9,95,10 
EXEC CSP_AddStock 9,96,22 
EXEC CSP_AddStock 9,97,15 
EXEC CSP_AddStock 9,98,14 
EXEC CSP_AddStock 9,99,24 
EXEC CSP_AddStock 9,100,12 
EXEC CSP_AddStock 9,101,4 
EXEC CSP_AddStock 9,102,12 
EXEC CSP_AddStock 9,103,1 
EXEC CSP_AddStock 9,104,26 
EXEC CSP_AddStock 9,105,3 
EXEC CSP_AddStock 9,106,7 
EXEC CSP_AddStock 9,107,29 
EXEC CSP_AddStock 9,108,29 
EXEC CSP_AddStock 9,109,25 
EXEC CSP_AddStock 9,110,7 
EXEC CSP_AddStock 9,111,6 
EXEC CSP_AddStock 9,112,1 
EXEC CSP_AddStock 9,113,7 
EXEC CSP_AddStock 9,114,12 
EXEC CSP_AddStock 9,115,19 
EXEC CSP_AddStock 9,116,17 
EXEC CSP_AddStock 9,117,18 
EXEC CSP_AddStock 9,118,25 
EXEC CSP_AddStock 9,119,23 
EXEC CSP_AddStock 9,120,16 
EXEC CSP_AddStock 9,121,3 
EXEC CSP_AddStock 9,122,11 
EXEC CSP_AddStock 9,123,18 
EXEC CSP_AddStock 9,124,4 
EXEC CSP_AddStock 9,125,10 
EXEC CSP_AddStock 9,126,13 
EXEC CSP_AddStock 9,127,12 
EXEC CSP_AddStock 9,128,28 
EXEC CSP_AddStock 9,129,21 
EXEC CSP_AddStock 9,130,17 
EXEC CSP_AddStock 9,131,9 
EXEC CSP_AddStock 9,132,6 
EXEC CSP_AddStock 9,133,28 
EXEC CSP_AddStock 9,134,13 
EXEC CSP_AddStock 9,135,30 
EXEC CSP_AddStock 9,136,8 
EXEC CSP_AddStock 9,137,1 
EXEC CSP_AddStock 9,138,16 
EXEC CSP_AddStock 9,139,24 
EXEC CSP_AddStock 9,140,13 
EXEC CSP_AddStock 9,141,28 
EXEC CSP_AddStock 9,142,24 
EXEC CSP_AddStock 9,143,12 
EXEC CSP_AddStock 9,144,4 
EXEC CSP_AddStock 9,145,23 
EXEC CSP_AddStock 9,146,3 
EXEC CSP_AddStock 9,147,13 
EXEC CSP_AddStock 9,148,27 
EXEC CSP_AddStock 9,149,22 
EXEC CSP_AddStock 9,150,7 
EXEC CSP_AddStock 9,151,2 
EXEC CSP_AddStock 9,152,21 
EXEC CSP_AddStock 9,153,21 
EXEC CSP_AddStock 9,154,9 
EXEC CSP_AddStock 9,155,21 
EXEC CSP_AddStock 9,156,8 
EXEC CSP_AddStock 9,157,28 
EXEC CSP_AddStock 9,158,0 
EXEC CSP_AddStock 9,159,30 
EXEC CSP_AddStock 9,160,4 
EXEC CSP_AddStock 9,161,9 
EXEC CSP_AddStock 9,162,18 
EXEC CSP_AddStock 9,163,30 
EXEC CSP_AddStock 9,164,9 
EXEC CSP_AddStock 9,165,6 
EXEC CSP_AddStock 9,166,27 
EXEC CSP_AddStock 9,167,1 
EXEC CSP_AddStock 9,168,29 
EXEC CSP_AddStock 9,169,1 
EXEC CSP_AddStock 9,170,2 
EXEC CSP_AddStock 9,171,28 
EXEC CSP_AddStock 9,172,16 
EXEC CSP_AddStock 9,173,17 
EXEC CSP_AddStock 9,174,8 
EXEC CSP_AddStock 9,175,0 
EXEC CSP_AddStock 9,176,26 
EXEC CSP_AddStock 9,177,9 
EXEC CSP_AddStock 9,178,1 
EXEC CSP_AddStock 9,179,16 
EXEC CSP_AddStock 9,180,3 
EXEC CSP_AddStock 9,181,29 
EXEC CSP_AddStock 9,182,21 
EXEC CSP_AddStock 9,183,26 
EXEC CSP_AddStock 9,184,0 
EXEC CSP_AddStock 9,185,4 
EXEC CSP_AddStock 9,186,16 
EXEC CSP_AddStock 9,187,10 
EXEC CSP_AddStock 9,188,27 
EXEC CSP_AddStock 9,189,13 
EXEC CSP_AddStock 9,190,18 
EXEC CSP_AddStock 9,191,15 
EXEC CSP_AddStock 9,192,0 
EXEC CSP_AddStock 9,193,21 
EXEC CSP_AddStock 9,194,15 
EXEC CSP_AddStock 9,195,19 
EXEC CSP_AddStock 9,196,28 
EXEC CSP_AddStock 9,197,10 
EXEC CSP_AddStock 9,198,0 
EXEC CSP_AddStock 9,199,13 
EXEC CSP_AddStock 9,200,11 
EXEC CSP_AddStock 9,201,24 
EXEC CSP_AddStock 9,202,1 
EXEC CSP_AddStock 9,203,7 
EXEC CSP_AddStock 9,204,25 
EXEC CSP_AddStock 9,205,13 
EXEC CSP_AddStock 9,206,9 
EXEC CSP_AddStock 9,207,8 
EXEC CSP_AddStock 9,208,12 
EXEC CSP_AddStock 9,209,11 
EXEC CSP_AddStock 9,210,10 
EXEC CSP_AddStock 9,211,4 
EXEC CSP_AddStock 9,212,22 
EXEC CSP_AddStock 9,213,10 
EXEC CSP_AddStock 9,214,7 
EXEC CSP_AddStock 9,215,11 
EXEC CSP_AddStock 9,216,19 
EXEC CSP_AddStock 9,217,22 
EXEC CSP_AddStock 9,218,26 
EXEC CSP_AddStock 9,219,16 
EXEC CSP_AddStock 9,220,6 
EXEC CSP_AddStock 9,221,12 
EXEC CSP_AddStock 9,222,30 
EXEC CSP_AddStock 9,223,7 
EXEC CSP_AddStock 9,224,4 
EXEC CSP_AddStock 9,225,11 
EXEC CSP_AddStock 9,226,5 
EXEC CSP_AddStock 9,227,12 
EXEC CSP_AddStock 9,228,7 
EXEC CSP_AddStock 9,229,29 
EXEC CSP_AddStock 9,230,25 
EXEC CSP_AddStock 9,231,8 
EXEC CSP_AddStock 9,232,11 
EXEC CSP_AddStock 9,233,25 
EXEC CSP_AddStock 9,234,12 
EXEC CSP_AddStock 9,235,4 
EXEC CSP_AddStock 9,236,7 
EXEC CSP_AddStock 9,237,30 
EXEC CSP_AddStock 9,238,6 
EXEC CSP_AddStock 9,239,17 
EXEC CSP_AddStock 9,240,19 
EXEC CSP_AddStock 9,241,24 
EXEC CSP_AddStock 9,242,2 
EXEC CSP_AddStock 9,243,18 
EXEC CSP_AddStock 9,244,1 
EXEC CSP_AddStock 9,245,18 
EXEC CSP_AddStock 9,246,10 
EXEC CSP_AddStock 9,247,16 
EXEC CSP_AddStock 9,248,26 
EXEC CSP_AddStock 9,249,10 
EXEC CSP_AddStock 9,250,23 
EXEC CSP_AddStock 9,251,0 
EXEC CSP_AddStock 9,252,20 
EXEC CSP_AddStock 9,253,29 
EXEC CSP_AddStock 9,254,7 
EXEC CSP_AddStock 9,255,12 
EXEC CSP_AddStock 9,256,8 
EXEC CSP_AddStock 9,257,5 
EXEC CSP_AddStock 9,258,10 
EXEC CSP_AddStock 9,259,16 
EXEC CSP_AddStock 9,260,20 
EXEC CSP_AddStock 9,261,4 
EXEC CSP_AddStock 9,262,8 
EXEC CSP_AddStock 9,263,4 
EXEC CSP_AddStock 9,264,13 
EXEC CSP_AddStock 9,265,4 
EXEC CSP_AddStock 9,266,18 
EXEC CSP_AddStock 9,267,21 
EXEC CSP_AddStock 9,268,3 
EXEC CSP_AddStock 9,269,4 
EXEC CSP_AddStock 9,270,15 
EXEC CSP_AddStock 9,271,26 
EXEC CSP_AddStock 9,272,1 
EXEC CSP_AddStock 9,273,28 
EXEC CSP_AddStock 9,274,15 
EXEC CSP_AddStock 9,275,3 
EXEC CSP_AddStock 9,276,9 
EXEC CSP_AddStock 9,277,4 
EXEC CSP_AddStock 9,278,8 
EXEC CSP_AddStock 9,279,18 
EXEC CSP_AddStock 9,280,11 
EXEC CSP_AddStock 9,281,3 
EXEC CSP_AddStock 9,282,8 
EXEC CSP_AddStock 9,283,28 
EXEC CSP_AddStock 9,284,6 
EXEC CSP_AddStock 9,285,22 
EXEC CSP_AddStock 9,286,3 
EXEC CSP_AddStock 9,287,15 
EXEC CSP_AddStock 9,288,13 
EXEC CSP_AddStock 9,289,5 
EXEC CSP_AddStock 9,290,29 
EXEC CSP_AddStock 9,291,22 
EXEC CSP_AddStock 9,292,22 
EXEC CSP_AddStock 9,293,12 
EXEC CSP_AddStock 9,294,7 
EXEC CSP_AddStock 9,295,15 
EXEC CSP_AddStock 9,296,8 
EXEC CSP_AddStock 9,297,7 
EXEC CSP_AddStock 9,298,27 
EXEC CSP_AddStock 9,299,0 
EXEC CSP_AddStock 9,300,13 
EXEC CSP_AddStock 9,301,26 
EXEC CSP_AddStock 9,302,6 
EXEC CSP_AddStock 9,303,23 
EXEC CSP_AddStock 9,304,6 
EXEC CSP_AddStock 9,305,21 
EXEC CSP_AddStock 9,306,17 
EXEC CSP_AddStock 9,307,18 
EXEC CSP_AddStock 9,308,15 
EXEC CSP_AddStock 9,309,9 
EXEC CSP_AddStock 9,310,5 
EXEC CSP_AddStock 9,311,27 
EXEC CSP_AddStock 9,312,2 
EXEC CSP_AddStock 9,313,24 
EXEC CSP_AddStock 9,1,14 
EXEC CSP_AddStock 9,2,24 
EXEC CSP_AddStock 9,3,0 
EXEC CSP_AddStock 9,4,11 
EXEC CSP_AddStock 9,5,3 
EXEC CSP_AddStock 9,6,27 
EXEC CSP_AddStock 9,7,12 
EXEC CSP_AddStock 9,8,12 
EXEC CSP_AddStock 9,9,23 
EXEC CSP_AddStock 9,10,21 
EXEC CSP_AddStock 9,11,30 
EXEC CSP_AddStock 9,12,30 
EXEC CSP_AddStock 9,13,19 
EXEC CSP_AddStock 9,14,4 
EXEC CSP_AddStock 9,15,22 
EXEC CSP_AddStock 9,16,19 
EXEC CSP_AddStock 9,17,22 
EXEC CSP_AddStock 9,18,5 
EXEC CSP_AddStock 9,19,24 
EXEC CSP_AddStock 9,20,19 
EXEC CSP_AddStock 9,21,8 
EXEC CSP_AddStock 9,22,20 
EXEC CSP_AddStock 9,23,8 
EXEC CSP_AddStock 9,24,18 
EXEC CSP_AddStock 9,25,15 
EXEC CSP_AddStock 9,26,27 
EXEC CSP_AddStock 9,27,21 
EXEC CSP_AddStock 9,28,20 
EXEC CSP_AddStock 9,29,11 
EXEC CSP_AddStock 9,30,23 
EXEC CSP_AddStock 9,31,10 
EXEC CSP_AddStock 9,32,14 
EXEC CSP_AddStock 9,33,14 
EXEC CSP_AddStock 9,34,6 
EXEC CSP_AddStock 9,35,3 
EXEC CSP_AddStock 9,36,28 
EXEC CSP_AddStock 9,37,30 
EXEC CSP_AddStock 9,38,23 
EXEC CSP_AddStock 9,39,22 
EXEC CSP_AddStock 9,40,2 
EXEC CSP_AddStock 9,41,25 
EXEC CSP_AddStock 9,42,9 
EXEC CSP_AddStock 9,43,26 
EXEC CSP_AddStock 9,44,26 
EXEC CSP_AddStock 9,45,1 
EXEC CSP_AddStock 9,46,16 
EXEC CSP_AddStock 9,47,14 
EXEC CSP_AddStock 9,48,2 
EXEC CSP_AddStock 9,49,4 
EXEC CSP_AddStock 9,50,25 
EXEC CSP_AddStock 9,51,2 
EXEC CSP_AddStock 9,52,8 
EXEC CSP_AddStock 9,53,6 
EXEC CSP_AddStock 9,54,13 
EXEC CSP_AddStock 9,55,5 
EXEC CSP_AddStock 9,56,19 
EXEC CSP_AddStock 9,57,9 
EXEC CSP_AddStock 9,58,27 
EXEC CSP_AddStock 9,59,0 
EXEC CSP_AddStock 9,60,7 
EXEC CSP_AddStock 9,61,28 
EXEC CSP_AddStock 9,62,4 
EXEC CSP_AddStock 9,63,8 
EXEC CSP_AddStock 9,64,22 
EXEC CSP_AddStock 9,65,1 
EXEC CSP_AddStock 9,66,3 
EXEC CSP_AddStock 9,67,6 
EXEC CSP_AddStock 9,68,18 
EXEC CSP_AddStock 9,69,29 
EXEC CSP_AddStock 9,70,2 
EXEC CSP_AddStock 9,71,13 
EXEC CSP_AddStock 9,72,6 
EXEC CSP_AddStock 9,73,3 
EXEC CSP_AddStock 9,74,17 
EXEC CSP_AddStock 9,75,29 
EXEC CSP_AddStock 9,76,23 
EXEC CSP_AddStock 9,77,23 
EXEC CSP_AddStock 9,78,19 
EXEC CSP_AddStock 9,79,29 
EXEC CSP_AddStock 9,80,22 
EXEC CSP_AddStock 9,81,18 
EXEC CSP_AddStock 9,82,7 
EXEC CSP_AddStock 9,83,23 
EXEC CSP_AddStock 9,84,15 
EXEC CSP_AddStock 9,85,15 
EXEC CSP_AddStock 9,86,27 
EXEC CSP_AddStock 9,87,16 
EXEC CSP_AddStock 9,88,28 
EXEC CSP_AddStock 9,89,22 
EXEC CSP_AddStock 9,90,9 
EXEC CSP_AddStock 9,91,8 
EXEC CSP_AddStock 9,92,28 
EXEC CSP_AddStock 9,93,18 
EXEC CSP_AddStock 9,94,15 
EXEC CSP_AddStock 9,95,14 
EXEC CSP_AddStock 9,96,1 
EXEC CSP_AddStock 9,97,28 
EXEC CSP_AddStock 9,98,5 
EXEC CSP_AddStock 9,99,19 
EXEC CSP_AddStock 9,100,28 
EXEC CSP_AddStock 9,101,17 
EXEC CSP_AddStock 9,102,22 
EXEC CSP_AddStock 9,103,10 
EXEC CSP_AddStock 9,104,22 
EXEC CSP_AddStock 9,105,1 
EXEC CSP_AddStock 9,106,1 
EXEC CSP_AddStock 9,107,11 
EXEC CSP_AddStock 9,108,23 
EXEC CSP_AddStock 9,109,24 
EXEC CSP_AddStock 9,110,11 
EXEC CSP_AddStock 9,111,29 
EXEC CSP_AddStock 9,112,24 
EXEC CSP_AddStock 9,113,23 
EXEC CSP_AddStock 9,114,12 
EXEC CSP_AddStock 9,115,25 
EXEC CSP_AddStock 9,116,30 
EXEC CSP_AddStock 9,117,23 
EXEC CSP_AddStock 9,118,9 
EXEC CSP_AddStock 9,119,29 
EXEC CSP_AddStock 9,120,25 
EXEC CSP_AddStock 9,121,4 
EXEC CSP_AddStock 9,122,8 
EXEC CSP_AddStock 9,123,15 
EXEC CSP_AddStock 9,124,11 
EXEC CSP_AddStock 9,125,2 
EXEC CSP_AddStock 9,126,5 
EXEC CSP_AddStock 9,127,4 
EXEC CSP_AddStock 9,128,20 
EXEC CSP_AddStock 9,129,10 
EXEC CSP_AddStock 9,130,20 
EXEC CSP_AddStock 9,131,23 
EXEC CSP_AddStock 9,132,16 
EXEC CSP_AddStock 9,133,16 
EXEC CSP_AddStock 9,134,17 
EXEC CSP_AddStock 9,135,15 
EXEC CSP_AddStock 9,136,4 
EXEC CSP_AddStock 9,137,17 
EXEC CSP_AddStock 9,138,17 
EXEC CSP_AddStock 9,139,21 
EXEC CSP_AddStock 9,140,3 
EXEC CSP_AddStock 9,141,4 
EXEC CSP_AddStock 9,142,29 
EXEC CSP_AddStock 9,143,9 
EXEC CSP_AddStock 9,144,9 
EXEC CSP_AddStock 9,145,11 
EXEC CSP_AddStock 9,146,9 
EXEC CSP_AddStock 9,147,3 
EXEC CSP_AddStock 9,148,6 
EXEC CSP_AddStock 9,149,1 
EXEC CSP_AddStock 9,150,21 
EXEC CSP_AddStock 9,151,1 
EXEC CSP_AddStock 9,152,1 
EXEC CSP_AddStock 9,153,7 
EXEC CSP_AddStock 9,154,22 
EXEC CSP_AddStock 9,155,25 
EXEC CSP_AddStock 9,156,14 
EXEC CSP_AddStock 9,157,12 
EXEC CSP_AddStock 9,158,17 
EXEC CSP_AddStock 9,159,6 
EXEC CSP_AddStock 9,160,27 
EXEC CSP_AddStock 9,161,11 
EXEC CSP_AddStock 9,162,11 
EXEC CSP_AddStock 9,163,11 
EXEC CSP_AddStock 9,164,18 
EXEC CSP_AddStock 9,165,19 
EXEC CSP_AddStock 9,166,27 
EXEC CSP_AddStock 9,167,8 
EXEC CSP_AddStock 9,168,23 
EXEC CSP_AddStock 9,169,3 
EXEC CSP_AddStock 9,170,13 
EXEC CSP_AddStock 9,171,11 
EXEC CSP_AddStock 9,172,22 
EXEC CSP_AddStock 9,173,15 
EXEC CSP_AddStock 9,174,1 
EXEC CSP_AddStock 9,175,3 
EXEC CSP_AddStock 9,176,6 
EXEC CSP_AddStock 9,177,2 
EXEC CSP_AddStock 9,178,12 
EXEC CSP_AddStock 9,179,20 
EXEC CSP_AddStock 9,180,6 
EXEC CSP_AddStock 9,181,8 
EXEC CSP_AddStock 9,182,28 
EXEC CSP_AddStock 9,183,26 
EXEC CSP_AddStock 9,184,21 
EXEC CSP_AddStock 9,185,15 
EXEC CSP_AddStock 9,186,30 
EXEC CSP_AddStock 9,187,2 
EXEC CSP_AddStock 9,188,29 
EXEC CSP_AddStock 9,189,20 
EXEC CSP_AddStock 9,190,20 
EXEC CSP_AddStock 9,191,23 
EXEC CSP_AddStock 9,192,10 
EXEC CSP_AddStock 9,193,5 
EXEC CSP_AddStock 9,194,20 
EXEC CSP_AddStock 9,195,20 
EXEC CSP_AddStock 9,196,25 
EXEC CSP_AddStock 9,197,8 
EXEC CSP_AddStock 9,198,27 
EXEC CSP_AddStock 9,199,5 
EXEC CSP_AddStock 9,200,29 
EXEC CSP_AddStock 9,201,30 
EXEC CSP_AddStock 9,202,11 
EXEC CSP_AddStock 9,203,6 
EXEC CSP_AddStock 9,204,16 
EXEC CSP_AddStock 9,205,3 
EXEC CSP_AddStock 9,206,29 
EXEC CSP_AddStock 9,207,29 
EXEC CSP_AddStock 9,208,12 
EXEC CSP_AddStock 9,209,1 
EXEC CSP_AddStock 9,210,22 
EXEC CSP_AddStock 9,211,3 
EXEC CSP_AddStock 9,212,23 
EXEC CSP_AddStock 9,213,10 
EXEC CSP_AddStock 9,214,30 
EXEC CSP_AddStock 9,215,12 
EXEC CSP_AddStock 9,216,5 
EXEC CSP_AddStock 9,217,4 
EXEC CSP_AddStock 9,218,21 
EXEC CSP_AddStock 9,219,29 
EXEC CSP_AddStock 9,220,0 
EXEC CSP_AddStock 9,221,25 
EXEC CSP_AddStock 9,222,12 
EXEC CSP_AddStock 9,223,29 
EXEC CSP_AddStock 9,224,23 
EXEC CSP_AddStock 9,225,12 
EXEC CSP_AddStock 9,226,14 
EXEC CSP_AddStock 9,227,22 
EXEC CSP_AddStock 9,228,29 
EXEC CSP_AddStock 9,229,7 
EXEC CSP_AddStock 9,230,29 
EXEC CSP_AddStock 9,231,6 
EXEC CSP_AddStock 9,232,16 
EXEC CSP_AddStock 9,233,9 
EXEC CSP_AddStock 9,234,24 
EXEC CSP_AddStock 9,235,1 
EXEC CSP_AddStock 9,236,3 
EXEC CSP_AddStock 9,237,16 
EXEC CSP_AddStock 9,238,12 
EXEC CSP_AddStock 9,239,29 
EXEC CSP_AddStock 9,240,26 
EXEC CSP_AddStock 9,241,8 
EXEC CSP_AddStock 9,242,5 
EXEC CSP_AddStock 9,243,7 
EXEC CSP_AddStock 9,244,5 
EXEC CSP_AddStock 9,245,10 
EXEC CSP_AddStock 9,246,7 
EXEC CSP_AddStock 9,247,3 
EXEC CSP_AddStock 9,248,11 
EXEC CSP_AddStock 9,249,6 
EXEC CSP_AddStock 9,250,16 
EXEC CSP_AddStock 9,251,10 
EXEC CSP_AddStock 9,252,27 
EXEC CSP_AddStock 9,253,15 
EXEC CSP_AddStock 9,254,4 
EXEC CSP_AddStock 9,255,17 
EXEC CSP_AddStock 9,256,1 
EXEC CSP_AddStock 9,257,25 
EXEC CSP_AddStock 9,258,10 
EXEC CSP_AddStock 9,259,0 
EXEC CSP_AddStock 9,260,5 
EXEC CSP_AddStock 9,261,24 
EXEC CSP_AddStock 9,262,29 
EXEC CSP_AddStock 9,263,21 
EXEC CSP_AddStock 9,264,7 
EXEC CSP_AddStock 9,265,22 
EXEC CSP_AddStock 9,266,18 
EXEC CSP_AddStock 9,267,12 
EXEC CSP_AddStock 9,268,17 
EXEC CSP_AddStock 9,269,26 
EXEC CSP_AddStock 9,270,6 
EXEC CSP_AddStock 9,271,23 
EXEC CSP_AddStock 9,272,12 
EXEC CSP_AddStock 9,273,19 
EXEC CSP_AddStock 9,274,7 
EXEC CSP_AddStock 9,275,23 
EXEC CSP_AddStock 9,276,14 
EXEC CSP_AddStock 9,277,26 
EXEC CSP_AddStock 9,278,15 
EXEC CSP_AddStock 9,279,15 
EXEC CSP_AddStock 9,280,1 
EXEC CSP_AddStock 9,281,2 
EXEC CSP_AddStock 9,282,18 
EXEC CSP_AddStock 9,283,1 
EXEC CSP_AddStock 9,284,26 
EXEC CSP_AddStock 9,285,2 
EXEC CSP_AddStock 9,286,7 
EXEC CSP_AddStock 9,287,26 
EXEC CSP_AddStock 9,288,2 
EXEC CSP_AddStock 9,289,2 
EXEC CSP_AddStock 9,290,6 
EXEC CSP_AddStock 9,291,10 
EXEC CSP_AddStock 9,292,16 
EXEC CSP_AddStock 9,293,14 
EXEC CSP_AddStock 9,294,13 
EXEC CSP_AddStock 9,295,9 
EXEC CSP_AddStock 9,296,12 
EXEC CSP_AddStock 9,297,22 
EXEC CSP_AddStock 9,298,14 
EXEC CSP_AddStock 9,299,29 
EXEC CSP_AddStock 9,300,3 
EXEC CSP_AddStock 9,301,29 
EXEC CSP_AddStock 9,302,6 
EXEC CSP_AddStock 9,303,13 
EXEC CSP_AddStock 9,304,23 
EXEC CSP_AddStock 9,305,11 
EXEC CSP_AddStock 9,306,7 
EXEC CSP_AddStock 9,307,17 
EXEC CSP_AddStock 9,308,9 
EXEC CSP_AddStock 9,309,30 
EXEC CSP_AddStock 9,310,8 
EXEC CSP_AddStock 9,311,23 
EXEC CSP_AddStock 9,312,18 
EXEC CSP_AddStock 9,313,0 