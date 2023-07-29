/* Additional Data for 2024:
  - PPBikes is introduced
  - 5 models:                       Category        Productname
    -   Race Bike                   (7)           : Thunder
    -   Electric City bike (Unisex) (5)           : Pigeon
    -   Hard tail mountainbike      (new)         : Rock Master
    -   Full Suspension             (new)         : Rock Cruncher
    -   Electric Race bike          (new)         : Lightning
  - Categories will be Updated... 
  - Production Facility building is created as a store
  - Webshop is created as a Store (shipping starts here)
  - All stock in Oslo (all bikes) or Production facility (PPBikes)
*/

-- First add the new brand
DECLARE @PPBIKEID AS INT;   EXECUTE @PPBIKEID=  CSP_AddBikeBrand 'PPBike';

-- Update the categories
DECLARE @HTMTB AS INT;      EXECUTE @HTMTB =    CSP_AddBikeCategory 'Hard Tail Mountainbike2';
DECLARE @FSMTB AS INT;      EXECUTE @FSMTB =    CSP_AddBikeCategory 'Full Suspension Mountainbike';
DECLARE @ELRACE AS INT;     EXECUTE @ELRACE =   CSP_AddBikeCategory 'Electric Race';

Select 

-- New Store Oslo
-- Production Facility Rotterdam
-- New Web Store Rotterdam

INSERT INTO sales.stores(store_name, phone, email, street, city, Country, zip_code)
VALUES('PPBikes Shop Oslo',             '022 5960001','oslo@ppbikes.shop',      'Chr. Krohgs gate 32',  'Oslo',		'Norway',	'0186'),
      ('PPBikes Production Facility',   '010 3308888','Production@ppbikes.shop','Haven 220-137',        'Rotterdam','Nederland','3031AP'),
      ('PPBikes Web orders',            '010 3305555','Web@ppbikes.shop',       'Haven 220-135',        'Rotterdam','Nederland','3031AP');

INSERT INTO production.products(product_id, product_name, brand_id, category_id, model_year, list_price) VALUES(1,'Trek 820 - 2016',9,6,2016,379.99)




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
