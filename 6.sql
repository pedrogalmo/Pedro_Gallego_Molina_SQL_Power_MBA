##  Encuentra el nombre y apellido de los actores que tengan ‘Allenʼ en su 
apellido.

select a.first_name , a.last_name  
from actor a 
where a.last_name = 'ALLEN';