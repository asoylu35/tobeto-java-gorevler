select* from customers;
--26. Stokta bulunmayan ürünlerin ürün listesiyle birlikte tedarikçilerin ismi ve iletişim numarasını (`ProductID`, `ProductName`, `CompanyName`, `Phone`) almak için bir sorgu yazın.
SELECT p.product_id,p.product_name,s.company_name,s.phone
FROM products AS p
INNER JOIN suppliers AS s 
ON p.supplier_id=s.supplier_id
WHERE units_in_stock=0;

--27. 1998 yılı mart ayındaki siparişlerimin adresi, siparişi alan çalışanın adı, çalışanın soyadı
SELECT o.order_date,e.first_name,e.last_name
FROM orders AS o
INNER JOIN employees AS e
ON o.employee_id=e.employee_id
WHERE to_char(o.order_date,'YYYY-MM')='1998-03' ;

--28. 1997 yılı şubat ayında kaç siparişim var?
SELECT COUNT(order_date) AS "TOPLAM SİPARİŞ"
FROM orders
WHERE to_char(order_date,'YYYY-MM')='1997-02';

--29. London şehrinden 1998 yılında kaç siparişim var?
SELECT ship_city,COUNT(order_date) AS "TOPLAM SİPARİŞ"
FROM orders
WHERE ship_city='London' AND to_char(order_date,'YYYY')='1998'
GROUP BY ship_city;

--30. 1997 yılında sipariş veren müşterilerimin contactname ve telefon numarası
SELECT o.customer_id,c.contact_name,c.phone,o.order_date
FROM orders AS o
INNER JOIN customers AS c
ON o.customer_id=c.customer_id
WHERE to_char(order_date,'YYYY')='1997';

--31. Taşıma ücreti 40 üzeri olan siparişlerim
SELECT order_id,freight
FROM orders
WHERE freight>40
ORDER BY freight ASC;

--32. Taşıma ücreti 40 ve üzeri olan siparişlerimin şehri, müşterisinin adı
SELECT o.order_id,c.company_name,c.city,o.freight
FROM orders AS o
INNER JOIN customers AS c
ON o.customer_id=c.customer_id
WHERE freight>40
ORDER BY freight ASC;

--33. 1997 yılında verilen siparişlerin tarihi, şehri, çalışan adı -soyadı ( ad soyad birleşik olacak ve büyük harf)
 SELECT o.order_date,o.ship_city, UPPER(e.first_name || ' ' || e.last_name) AS employee_name 
 FROM orders AS o
 INNER JOIN employees AS e
 ON o.employee_id=e.employee_id
 WHERE to_char(order_date,'YYYY')='1997';
 
--34. 1997 yılında sipariş veren müşterilerin contactname i, ve telefon numaraları ( telefon formatı 2223322 gibi olmalı )
SELECT DISTINCT order_date, c.contact_name,REGEXP_REPLACE(c.phone,'\D','','g') AS formatted_phone
FROM orders AS o
INNER JOIN customers AS c
ON o.customer_id=c.customer_id
WHERE to_char(order_date,'YYYY')='1997';

--35. Sipariş tarihi, müşteri contact name, çalışan ad, çalışan soyad
SELECT o.order_date,c.contact_name,e.first_name,e.last_name
FROM orders AS o
INNER JOIN customers AS c
ON o.customer_id=c.customer_id
INNER JOIN employees AS e
ON o.employee_id=e.employee_id;

--36. Geciken siparişlerim?
SELECT *
FROM orders
WHERE shipped_date>required_date;

--37. Geciken siparişlerimin tarihi, müşterisinin adı
SELECT shipped_date,c.company_name
FROM orders AS o
INNER JOIN customers AS c
ON o.customer_id=c.customer_id
WHERE shipped_date>required_date;

--38. 10248 nolu siparişte satılan ürünlerin adı, kategorisinin adı, adedi
SELECT od.order_id,p.product_name,c.category_name,od.quantity
FROM products AS p
INNER JOIN categories AS c
ON p.category_id=c.category_id
INNER JOIN order_details AS od
ON p.product_id=od.product_id
WHERE order_id=10248;

--39. 10248 nolu siparişin ürünlerinin adı , tedarikçi adı
SELECT od.order_id,p.product_name,s.company_name
FROM products AS p
INNER JOIN suppliers AS s
ON p.supplier_id=s.supplier_id
INNER JOIN order_details AS od
ON p.product_id=od.product_id
WHERE order_id=10248;

--40. 3 numaralı ID ye sahip çalışanın 1997 yılında sattığı ürünlerin adı ve adeti 
--emin değilim
SELECT p.product_name,count(od.order_id)
FROM orders AS o
INNER JOIN employees AS e
ON e.employee_id=o.employee_id
INNER JOIN order_details AS od
ON o.order_id=od.order_id
INNER JOIN products AS p
ON p.product_id=od.product_id
WHERE e.employee_id=3 AND to_char(order_date,'YYYY')='1997'
GROUP BY p.product_name;

--41. 1997 yılında bir defasinda en çok satış yapan çalışanımın ID,Ad soyad
SELECT DISTINCT e.employee_id,e.first_name,e.last_name,od.quantity AS total 
FROM employees AS e
INNER JOIN orders AS o ON o.employee_id = e.employee_id
INNER JOIN order_details AS od ON o.order_id = od.order_id
WHERE to_char(o.order_date,'YYYY')='1997'
ORDER BY total DESC LIMIT 1;


--42. 1997 yılında en çok satış yapan çalışanımın ID,Ad soyad ****
--?
--43. En pahalı ürünümün adı,fiyatı ve kategorisin adı nedir?
SELECT p.product_name,c.category_name,p.unit_price
FROM products AS p
INNER JOIN categories AS c
ON p.category_id=c.category_id
ORDER BY unit_price DESC LIMIT 1;

--44. Siparişi alan personelin adı,soyadı, sipariş tarihi, sipariş ID. Sıralama sipariş tarihine göre
SELECT o.order_id,e.first_name,e.last_name,o.order_date
FROM employees AS e
INNER JOIN orders AS o
ON e.employee_id=o.employee_id
ORDER BY o.order_date ASC;

--45. SON 5 siparişimin ortalama fiyatı ve orderid nedir?
SELECT o.order_id ,AVG(od.unit_price) AS average
FROM order_details AS od
INNER JOIN orders AS o
ON o.order_id=od.order_id
GROUP BY o.order_id
ORDER BY o.order_date DESC LIMIT 5;

--46. Ocak ayında satılan ürünlerimin adı ve kategorisinin adı ve toplam satış miktarı nedir?
SELECT p.product_name,c.category_name,SUM(od.quantity) AS "toplam satış miktarı"
FROM products AS p
INNER JOIN categories AS c
ON p.category_id=c.category_id
INNER JOIN order_details AS od
ON p.product_id=od.product_id
INNER JOIN orders AS o
ON o.order_id=od.order_id
WHERE to_char(o.order_date,'MM')='01'
GROUP BY p.product_name,c.category_name;

--47. Ortalama satış miktarımın üzerindeki satışlarım nelerdir?
SELECT *
FROM order_details
where quantity>(SELECT AVG(quantity) FROM order_details)
ORDER BY quantity DESC;

--48. En çok satılan ürünümün(adet bazında) adı, kategorisinin adı ve tedarikçisinin adı
SELECT p.product_name,c.category_name,s.company_name,od.quantity
FROM order_details AS od
INNER JOIN products AS p
ON od.product_id=p.product_id
INNER JOIN categories AS c
ON p.category_id=c.category_id
INNER JOIN  suppliers AS s
ON s.supplier_id=p.supplier_id
ORDER BY quantity DESC LIMIT 1;

--49. Kaç ülkeden müşterim var
SELECT DISTINCT country
FROM customers

--50. Hangi ülkeden kaç müşterimiz var
SELECT country,COUNT(customer_id) AS "müşteri sayısı" 
FROM customers 
GROUP BY country 
ORDER BY "müşteri sayısı" DESC;

--51. 3 numaralı ID ye sahip çalışan (employee) son Ocak ayından BUGÜNE toplamda ne kadarlık ürün sattı?
--?
--52. 10 numaralı ID ye sahip ürünümden son 3 ayda ne kadarlık ciro sağladım?
--?
SELECT SUM((od.unit_price*od.quantity)-(od.unit_price*od.quantity*od.discount))
FROM order_details AS od
INNER JOIN products AS p
ON od.product_id=p.product_id
INNER JOIN orders AS o
ON o.order_id=od.order_id
WHERE p.product_id=10 AND o.order_date>= DATEADD(MONTH, -3, GETDATE());  

--53. Hangi çalışan şimdiye kadar toplam kaç sipariş almış..?
SELECT e.first_name,e.last_name, COUNT(o.order_id)  
FROM orders AS o
INNER JOIN employees AS e
ON o.employee_id=e.employee_id
GROUP BY e.first_name,e.last_name;

--54. 91 müşterim var. Sadece 89’u sipariş vermiş. Sipariş vermeyen 2 kişiyi bulun
SELECT company_name,address,city
FROM customers
WHERE customer_id NOT IN (SELECT DISTINCT customer_id FROM orders);

--55. Brazil’de bulunan müşterilerin Şirket Adı, TemsilciAdi, Adres, Şehir, Ülke bilgileri
SELECT company_name,contact_name,address,city,country 
FROM customers
WHERE country='Brazil';

--56. Brezilya’da olmayan müşteriler
SELECT company_name,contact_name,address,city,country 
FROM customers
WHERE country!='Brazil';

--57. Ülkesi (Country) YA Spain, Ya France, Ya da Germany olan müşteriler
SELECT  company_name, country
FROM customers
WHERE country='Spain' OR country='France' OR country='Germany';

--58. Faks numarasını bilmediğim müşteriler
SELECT  company_name,fax 
FROM customers 
WHERE fax IS NULL;

--59. Londra’da ya da Paris’de bulunan müşterilerim
SELECT  company_name,city
FROM customers 
WHERE city='Londra' OR city='Paris';

--60. Hem Mexico D.F’da ikamet eden HEM DE ContactTitle bilgisi ‘owner’ olan müşteriler
SELECT  company_name,city,contact_title
FROM customers 
WHERE city='México D.F.' AND contact_title='Owner';

--61. C ile başlayan ürünlerimin isimleri ve fiyatları
SELECT product_name,unit_price
FROM products
WHERE product_name LIKE 'C%';

--62. Adı (FirstName) ‘A’ harfiyle başlayan çalışanların (Employees); Ad, Soyad ve Doğum Tarihleri
SELECT first_name,last_name,birth_date
FROM employees
WHERE first_name LIKE 'A%';

--63. İsminde ‘RESTAURANT’ geçen müşterilerimin şirket adları
SELECT company_name,contact_name
FROM customers
WHERE company_name LIKE '%Restaurant%';

--64. 50$ ile 100$ arasında bulunan tüm ürünlerin adları ve fiyatları
SELECT product_name,unit_price
FROM products
WHERE unit_price BETWEEN 50 AND 100;

--65. 1 temmuz 1996 ile 31 Aralık 1996 tarihleri arasındaki siparişlerin (Orders), SiparişID (OrderID) ve SiparişTarihi (OrderDate) bilgileri
SELECT order_id,order_date
FROM orders
WHERE order_date BETWEEN '1996-07-01' AND '1996-12-31';

--66. Faks numarasını bilmediğim müşteriler
SELECT  company_name,fax 
FROM customers 
WHERE fax IS NULL;

--67. Müşterilerimi ülkeye göre sıralıyorum:
SELECT country
FROM customers
GROUP BY country;

--68. Ürünlerimi en pahalıdan en ucuza doğru sıralama, sonuç olarak ürün adı ve fiyatını istiyoruz
SELECT product_name,unit_price
FROM products
ORDER BY unit_price DESC;

--69. Ürünlerimi en pahalıdan en ucuza doğru sıralasın, ama stoklarını küçükten-büyüğe doğru göstersin sonuç olarak ürün adı ve fiyatını istiyoruz
SELECT product_name,unit_price,units_in_stock
FROM products
ORDER BY unit_price DESC ,units_in_stock ASC;

--70. 1 Numaralı kategoride kaç ürün vardır..?
SELECT COUNT(*) AS "toplam ürün"
FROM products
WHERE category_id=1;

--71. Kaç farklı ülkeye ihracat yapıyorum..?
SELECT COUNT(DISTINCT country) AS "farklı ülke"
FROM customers;

--72. a.Bu ülkeler hangileri..?
SELECT DISTINCT country 
FROM customers;

--73. En Pahalı 5 ürün
SELECT product_name,unit_price 
FROM products
ORDER BY unit_price DESC LIMIT 5;

--74. ALFKI CustomerID’sine sahip müşterimin sipariş sayısı..?
SELECT COUNT(*) 
FROM orders
WHERE customer_id='ALFKI';

--75. Ürünlerimin toplam maliyeti
SELECT SUM(unit_price) AS "toplam maliyet" 
FROM products;

--76. Şirketim, şimdiye kadar ne kadar ciro yapmış..?
SELECT SUM(unit_price*quantity*(1-discount)) AS "toplam ciro" 
FROM order_details;

--77. Ortalama Ürün Fiyatım
SELECT AVG(unit_price) AS "average" 
FROM products;

--78. En Pahalı Ürünün Adı
SELECT product_name 
FROM products
WHERE unit_price=(SELECT MAX(unit_price) FROM products);

--79. En az kazandıran sipariş
SELECT MIN(unit_price * quantity) 
FROM order_details;

--80. Müşterilerimin içinde en uzun isimli müşteri
SELECT company_name,MAX(LENGTH(company_name)) 
FROM customers
GROUP BY company_name
ORDER BY MAX(LENGTH(company_name))  DESC LIMIT 1;

--81. Çalışanlarımın Ad, Soyad ve Yaşları
SELECT first_name,last_name, AGE(birth_date) AS "Yaş" 
FROM employees;

--82. Hangi üründen toplam kaç adet alınmış..?
SELECT product_name,SUM(quantity ) 
FROM order_details AS od
INNER JOIN products AS p
ON p.product_id=od.product_id
GROUP BY product_name;

--83. Hangi siparişte toplam ne kadar kazanmışım..?
SELECT order_id, SUM(quantity * unit_price) 
FROM order_details 
GROUP BY order_id;

--84. Hangi kategoride toplam kaç adet ürün bulunuyor..?
SELECT category_id,COUNT(product_id) 
FROM products
GROUP BY category_id;

--85. 1000 Adetten fazla satılan ürünler?
SELECT product_id,SUM(quantity) As "satış adeti" 
FROM order_details 
GROUP BY product_id
HAVING SUM(quantity)>1000;

