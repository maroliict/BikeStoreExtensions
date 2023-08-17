-- Modify Columns...
ALTER Table sales.stores Alter COLUMN zip_code VARCHAR(10);
ALTER TABLE sales.stores ADD COLUMN [country] VARCHAR (50);

ALTER Table sales.customers Alter COLUMN zip_code VARCHAR(10);
ALTER TABLE sales.customers ADD COLUMN [country] VARCHAR(50);


-- Contstraints should make names unique
ALTER TABLE Production.brands       ADD CONSTRAINT UQ_brand_name        UNIQUE(brand_name);
ALTER TABLE Production.categories   ADD CONSTRAINT UQ_cat_name          UNIQUE(Category_name)
ALTER TABLE Production.products     ADD CONSTRAINT UQ_prodname_modyear  UNIQUE(product_name,model_year)