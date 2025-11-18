/*-- бшбеярх мюхлемнбюмхе рнбюпю, мюхлемнбюмхе апемдю х жемс, дкъ
-- рнбюпнб, бшосыеммшу б 2018 цндс
-- сонпъднвхрэ он сашбюмхч жемш  */
SELECT t1.product_name, t2.brand_name, t1.list_price 
FROM production.products t1 
JOIN production.brands t2 ON t1.brand_id = t2.brand_id 
WHERE t1.model_year = 2018 
ORDER BY t1.list_price DESC 

/*-- бшбеярх хлъ, тюлхкхч йкхемрю, ецн рекетнм х дюрс гюйюгю дкъ    
-- бяеу йкхемрнб. 
-- сонпъднвхрэ он тюлхкхх йкхемрю  
 
-- еярэ кх йкхемрш, ме ядекюбьхе мх ндмнцн гюйюгю?  */
SELECT t1.first_name, t1.last_name, t1.phone, t2.order_date 
FROM sales.customers t1  
LEFT JOIN sales.orders t2 ON t1.customer_id = t2.customer_id 
ORDER BY last_name

SELECT COUNT(*) AS Clients_Without_Orders
FROM sales.customers t1 
LEFT JOIN sales.orders t2 ON t1.customer_id = t2.customer_id
WHERE t2.order_id IS NULL 

/*-- бшбеярх мюхлемнбюмхе рнбюпю, мюгбюмхе яйкюдю х йнкхвеярбн рнбюпю мю дюммнл яйкюде 
-- нярюбхрэ бяе рнбюпш, мн дкъ рнбюпнб, йнрнпшу мхйнцдю ме ашкн мх мю ндмнл яйкюде днкфмш сйюгшбюрэяъ гмювемхъ NULL 
-- йюй дкъ мюгбюмхъ яйкюдю, рюй х дкъ йнкхвеярбю.
-- еякх рнбюп мю яйкюде ашк, мн нярюрнй мскебни, рн днкфмш бшбндхрэяъ мюгбюмхе яйкюдю х мнкэ
-- сонпъднвхрэ он дбсл ярнкажюл 1) мюгбюмхе яйкюдю х 2) мюхлемнбюмхе рнбюпю*/
SELECT product_name, store_name, quantity 
FROM production.products t1 
LEFT JOIN production.stocks t2 ON t1.product_id = t2.product_id 
LEFT JOIN sales.stores t3 ON t2.store_id = t3.store_id 
ORDER BY store_name, product_name 

/*-- бшбеярх мюхлемнбюмхе рнбюпю, мюгбюмхе яйкюдю х йнкхвеярбн рнбюпю мю дюммнл яйкюде 
-- бшбеярх бяе рнбюпш х яйкюдш, дкъ йнрнпшу нярюрнй мскебни
-- сонпъднвхрэ он дбсл ярнкажюл 1) мюгбюмхе яйкюдю х 2) мюхлемнбюмхе рнбюпю*/
SELECT product_name, store_name, quantity 
FROM production.products t1 
LEFT JOIN production.stocks t2 ON t1.product_id = t2.product_id 
LEFT JOIN sales.stores t3 ON t2.store_id = t3.store_id 
WHERE quantity = 0 
ORDER BY store_name, product_name 

/*-- бшбеярх мюхлемнбюмхе рнбюпю, жемс рнбюпю, мнлеп гюйюгю 
-- дкъ гюйюгю 55
-- сонпъднвхрэ он сашбюмхч жемш рнбюпю*/
SELECT product_name, t1.list_price, order_id 
FROM production.products t1 
JOIN sales.order_items t2 ON t1.product_id = t2.product_id 
WHERE order_id = 55 
ORDER BY list_price DESC 

/*-- бшбеярх б тнплюре "хлъ тюлхкхъ" дкъ йюфднцн янрпсдмхйю ецн мювюкэмхйю (ярнкаеж MANAGER_ID) х ецн мнлеп рекетнмю (мювюкэмхйю)
-- сонпъднвхрэ он "хлъ тюлхкхъ" мювюкэмхйю
-- дкъ яюлнцн цкюбмнцн мювюкэмхйю (мюд йнрнпшл мер мювюкэмхйнб) б яннрберярбсчыху ярнкажюу бшбеярх NULL*/
SELECT s1.first_name + ' ' + s1.last_name яНРПСДМХЙ, s2.first_name + ' ' + s2.last_name AS мЮВЮКЭМХЙ, s2.phone рЕКЕТНМ_МЮВЮКЭМХЙЮ 
FROM sales.staffs s1 
LEFT JOIN sales.staffs s2 ON s1.manager_id = s2.staff_id 
ORDER BY мЮВЮКЭМХЙ;