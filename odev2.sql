--1. Product isimlerini (`ProductName`) ve birim başına miktar (`QuantityPerUnit`) değerlerini almak için sorgu yazın.
 SELECT product_name, quantity_per_unit 
 FROM products;

--2. Ürün Numaralarını (`ProductID`) ve Product isimlerini (`ProductName`) değerlerini almak için sorgu yazın. Artık satılmayan ürünleri (`Discontinued`) filtreleyiniz.
 SELECT product_id, product_name  
 FROM products 
 WHERE discontinued=0;

--3. Durdurulmayan (`Discontinued`) Ürün Listesini, Ürün kimliği ve ismi (`ProductID`, `ProductName`) değerleriyle almak için bir sorgu yazın.
 SELECT product_id , product_name 
 FROM products 
 WHERE discontinued = 0;

--4. Ürünlerin maliyeti 20'dan az olan Ürün listesini (`ProductID`, `ProductName`, `UnitPrice`) almak için bir sorgu yazın.
 SELECT product_id, product_name, unit_price 
 FROM products 
 WHERE unit_price<20;

--5. Ürünlerin maliyetinin 15 ile 25 arasında olduğu Ürün listesini (`ProductID`, `ProductName`, `UnitPrice`) almak için bir sorgu yazın.
 SELECT product_id, product_name, unit_price 
 FROM products 
 WHERE unit_price  BETWEEN 15 AND 20;

--6. Ürün listesinin (`ProductName`, `UnitsOnOrder`, `UnitsInStock`) stoğun siparişteki miktardan az olduğunu almak için bir sorgu yazın.
 SELECT product_name,units_in_stock,units_on_order 
 FROM products 
 WHERE units_in_stock<units_on_order;
--7. İsmi `a` ile başlayan ürünleri listeleyeniz.
 SELECT * FROM products 
 WHERE product_name LIKE 'a%';

--8. İsmi `i` ile biten ürünleri listeleyeniz.
 SELECT * FROM products 
 WHERE product_name LIKE '%i';

--9. Ürün birim fiyatlarına %18’lik KDV ekleyerek listesini almak (ProductName, UnitPrice, UnitPriceKDV) için bir sorgu yazın.
 SELECT  product_name, unit_price,(unit_price+(unit_price*18/100)) AS unit_price_kdv 
 FROM products;
--10. Fiyatı 30 dan büyük kaç ürün var?
 SELECT COUNT(*) AS product_quantity 
 FROM products 
 WHERE unit_price>30;

--11. Ürünlerin adını tamamen küçültüp fiyat sırasına göre tersten listele
 SELECT lower (product_name),unit_price 
 FROM products 
 ORDER BY unit_price DESC;

--12. Çalışanların ad ve soyadlarını yanyana gelecek şekilde yazdır
 SELECT first_name || ' ' || last_name AS employee_name
 FROM employees;

--13. Region alanı NULL olan kaç tedarikçim var?
 SELECT COUNT(*) AS suppliers_null
 FROM suppliers
 WHERE region IS NULL;

--14. a.Null olmayanlar?
 SELECT COUNT(*) AS suppliers_not_null
 FROM suppliers
 WHERE region IS NOT NULL;

--15. Ürün adlarının hepsinin soluna TR koy ve büyültüp olarak ekrana yazdır.
 SELECT CONCAT('TR ',UPPER("product_name")) AS new_product_name
 FROM products;

--16. a.Fiyatı 20den küçük ürünlerin adının başına TR ekle
 SELECT 
    CASE 
        WHEN unit_price < 20 THEN CONCAT('TR ', product_name)
        ELSE product_name
    END AS new_product_name
FROM products;

--17. En pahalı ürün listesini (`ProductName` , `UnitPrice`) almak için bir sorgu yazın.
 SELECT product_name, unit_price
 FROM products
 WHERE unit_price=(SELECT MAX(unit_price) FROM products);	

--18. En pahalı on ürünün Ürün listesini (`ProductName` , `UnitPrice`) almak için bir sorgu yazın.
 SELECT product_name , unit_price
 FROM products
 ORDER BY unit_price DESC
 LIMIT 10;

--19. Ürünlerin ortalama fiyatının üzerindeki Ürün listesini (`ProductName` , `UnitPrice`) almak için bir sorgu yazın.
 SELECT product_name,unit_price 
 FROM products
 WHERE unit_price>(Select AVG(unit_price) from products);

--20. Stokta olan ürünler satıldığında elde edilen miktar ne kadardır.
 SELECT SUM(unit_price*units_in_stock) AS TOTAL 
 FROM products;

--21. Mevcut ve Durdurulan ürünlerin sayılarını almak için bir sorgu yazın.
 SELECT discontinued,
 COUNT(*) AS product_count
 FROM products
 GROUP BY discontinued;

--22. Ürünleri kategori isimleriyle birlikte almak için bir sorgu yazın.
 SELECT p.product_name,c.category_name
 FROM products p
 INNER JOIN categories c ON p.category_id = c.category_id;

--23. Ürünlerin kategorilerine göre fiyat ortalamasını almak için bir sorgu yazın.
 SELECT c.category_name,AVG(p.unit_price) AS average
 FROM products p
 INNER JOIN categories c ON p.category_id= c.category_id
 GROUP BY c.category_name;

--24. En pahalı ürünümün adı, fiyatı ve kategorisin adı nedir?
 SELECT p.product_name,c.category_name,p.unit_price
 FROM products p
 INNER JOIN categories c ON p.category_id = c.category_id
 ORDER BY p.unit_price DESC
 LIMIT 1;

--25. En çok satılan ürününün adı, kategorisinin adı ve tedarikçisinin adı
 SELECT p.product_id,p.product_name,c.category_name,
 s.company_name, SUM(quantity) AS sale_amount 
 FROM order_details AS od 
 INNER JOIN products AS p ON p.product_id=od.product_id
 INNER JOIN categories AS c ON c.category_id=p.category_id
 INNER JOIN suppliers AS s ON
 s.supplier_id=p.supplier_id
 GROUP BY p.product_id,c.category_name, s.company_name
 ORDER BY sale_amount DESC LIMIT 1;