## 2.Muestra los nombres de todas las películas con una clasificación por 
edades de ‘Rʼ

select "title" , "rating"
from film f 
where "rating" = 'R' ; 

## 3.Encuentra los nombres de los actores que tengan un “actor_idˮ entre 30 
y 40.

select *
from actor a
where a.actor_id BETWEEN '30' AND '40';

## 4.Obtén las películas cuyo idioma coincide con el idioma original.

select f.title , f.original_language_id , f.language_id 
from film f 
where f.language_id=f.original_language_id ;

## 5.Ordena las películas por duración de forma ascendente.
 
select f.title , f.length 
from film f 
order by f.length asc ;

## 6.Encuentra el nombre y apellido de los actores que tengan ‘Allenʼ en su 
apellido.

select a.first_name , a.last_name  
from actor a 
where a.last_name = 'ALLEN';

## 7.Encuentra la cantidad total de películas en cada clasificación de la tabla 
“filmˮ y muestra la clasificación junto con el recuento.

select rating as Clasificación , count(film_id) as Recuento 
from film
group by film.rating ;

## 8.Encuentra el título de todas las películas que son ‘PG13ʼ o tienen una 
duración mayor a 3 horas en la tabla film.

select f.title as Título , f.rating as CLasificación , f.length as Duración  
from film f 
where f.rating = 'PG-13' OR f.length > 180 ;

## 9.Encuentra la variabilidad de lo que costaría reemplazar las películas.

select stddev(f.replacement_cost ) as Variabilidad_reemplazo
from film f ;

## 10.Encuentra la mayor y menor duración de una película de nuestra BBDD.

select  Max(f.length ) as Máxima , Min(f.length ) as Mínima
from film f ;

## 11.Encuentra lo que costó el antepenúltimo alquiler ordenado por día.

select r.rental_date , p.amount 
from rental r 
join payment p on r.rental_id = p.rental_id
order by r.rental_date desc
limit 1 offset 2;

## 12.Encuentra el título de las películas en la tabla “filmˮ que no sean ni ‘NC
 17ʼ ni ‘Gʼ en cuanto a su clasificación.

select f.title , f.rating 
from film f 
where f.rating not in ('NC-17','G');

## 13.Encuentra el promedio de duración de las películas para cada 
clasificación de la tabla film y muestra la clasificación junto con el 
promedio de duración.

select f.rating , AVG(f.length )
from film f 
group by f.rating ;

## 14. Encuentra el título de todas las películas que tengan una duración mayor 
a 180 minutos.

select f.title , f.length 
from film f 
where f.length > '180';

## 15.¿Cuánto dinero ha generado en total la empresa?

select SUM(p.amount ) 
from payment p ;

## 16.Muestra los 10 clientes con mayor valor de id.

select c.customer_id 
from customer c 
order by c.customer_id desc 
limit 10;

## 17.Encuentra el nombre y apellido de los actores que aparecen en la 
película con título ‘Egg Igbyʼ.

select a.first_name as Nombre , a.last_name as Apellido, f.title 
from actor a 
join film_actor fa on a.actor_id = fa.actor_id 
join film f on fa.film_id = f.film_id
where f.title = 'EGG IGBY';

## 18. Selecciona todos los nombres de las películas únicos.

select distinct f.title 
from film f ;

## 19.Encuentra el título de las películas que son comedias y tienen una 
duración mayor a 180 minutos en la tabla “filmˮ.

select f.title , c.name , f.length 
from film f 
join film_category fc on f.film_id = fc.film_id
join category c on FC.category_id =C.category_id 
where fc.category_id = '5' and f.length >'180';

## 20. Encuentra las categorías de películas que tienen un promedio de 
duración superior a 110 minutos y muestra el nombre de la categoría 
junto con el promedio de duración.

select c.name , AVG(f.length) as duracion_media
from film f
join film_category fc on fc.film_id=f.film_id
join category c on fc.category_id=c.category_id 
group by c.name
having AVG(f.length) > 110 
order by duracion_media  desc;

## 21. ¿Cuál es la media de duración del alquiler de las películas?

select avg(f.rental_duration )
from film f  ;

## 22.Crea una columna con el nombre y apellidos de todos los actores y 
actrices.

select concat(a.first_name , ' ' , a.last_name) as Nombre_y_Apellido
from actor a; 

## 23.Números de alquiler por día, ordenados por cantidad de alquiler de 
forma descendente.

select cast(r.rental_date as date) as Día , count(r.rental_id) as Números_Alquiler
from rental r
group by Día
order by Números_Alquiler desc;

## 24.Encuentra las películas con una duración superior al promedio.

select  "title" , "length"  
from "film"   
where "length" > (
	select avg("length")
	from "film"
);	

## 25.Averigua el número de alquileres registrados por mes.

select extract(year from "rental_date") as Año , extract(month from "rental_date") as Mes , count("rental_id") as ALquileres_Mes 
from "rental"
group by Mes, Año
order by Mes, Año;

## 26.Encuentra el promedio, la desviación estándar y varianza del total 
pagado.

select avg(p.amount) as promedio, stddev_samp(p.amount) AS desviacion_estandar, var_samp(p.amount) AS varianza
from payment p ;


## 27.¿Qué películas se alquilan por encima del precio medio?

select "title", "rental_rate" 
from film  
where "rental_rate" >
	(select avg("rental_rate")
	from film
);

## 28. Muestra el id de los actores que hayan participado en más de 40 
películas.

select "actor_id"
from "film_actor"
group by "actor_id"
having count("film_id")  > 40;
	
## 29.Obtener todas las películas y, si están disponibles en el inventario, 
mostrar la cantidad disponible.

select  f.title as titulo, count(i.inventory_id) as cantidad_disponible
from film f
left join 
  inventory i on f.film_id = i.film_id
group by
  f.film_id, f.title
order by
  f.title;

## 30. Obtener los actores y el número de películas en las que ha actuado.

select concat(a.first_name, ' ', a.last_name) as nombre_apellido , count(fa.film_id ) as Numero_peliculas
from film_actor fa 
join actor a on fa.actor_id = a.actor_id
group by nombre_apellido 
order by Numero_peliculas;

## 31.Obtener todas las películas y mostrar los actores que han actuado en 
ellas, incluso si algunas películas no tienen actores asociados.

select f.title , concat(a.first_name , ' ' , a.last_name )
from film f 
left join  film_actor fa on f.film_id = fa.film_id
left join actor a on fa.actor_id = a.actor_id
order by f.title ;

## 32.Obtener todos los actores y mostrar las películas en las que han 
actuado, incluso si algunos actores no han actuado en ninguna película.

select concat(a.first_name , ' ' , a.last_name ) as Nombre , f.title as titulo
from actor a 
left join film_actor fa on a.actor_id = fa.actor_id
left join film f on fa.film_id = f.film_id
order by Nombre, titulo;


##33.Obtener todas las películas que tenemos y todos los registros de
alquiler.

select f.film_id , f.title , r.rental_id  
from film f
left join inventory i on f.film_id=i.film_id
left join rental r on i.inventory_id=r.inventory_id 
order by f.film_id desc;

## 34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.

select c.customer_id , sum(p.amount) as Gastado
from customer c 
left join payment p on c.customer_id=p.customer_id
group by c.customer_id 
order by Gastado desc
limit 5;

## 35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.

select a.first_name, a.last_name 
from actor a 
where a.first_name='JOHNNY';



## 36. Renombra la columna “first_name” como Nombre y “last_name” como
Apellido.

select a.first_name as Nombre , a.last_name as Apellido 
from actor a; 

## 37. Encuentra el ID del actor más bajo y más alto en la tabla actor.

select max(a.actor_id) as Mas_Alto , min(a.actor_id) as Mas_bajo 
from actor a ;


## 38. Cuenta cuántos actores hay en la tabla “actor”.

select count(a.actor_id)
from actor a; 


## 39. Selecciona todos los actores y ordénalos por apellido en orden
ascendente.

select *
from actor a 
order by a.last_name asc ;

## 40. Selecciona las primeras 5 películas de la tabla “film”.

select f.title 
from film f 
limit 5;

## 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el
mismo nombre. ¿Cuál es el nombre más repetido?

select a.first_name, count(a.first_name) as cuenta 
from actor a 
group by a.first_name 
order by cuenta desc 
limit 1; 

## 42. Encuentra todos los alquileres y los nombres de los clientes que los
realizaron.

select r.rental_id , Concat(c.first_name, ' ', c.last_name) as Nombre_Apellido
from rental r
join customer c on r.customer_id=c.customer_id 
order by Nombre_Apellido desc;

## 43. Muestra todos los clientes y sus alquileres si existen, incluyendo
aquellos que no tienen alquileres.

select Concat(c.first_name, ' ', c.last_name) as Nombre_Apellido, r.rental_id
from customer c
left join rental r on r.customer_id=c.customer_id
order by Nombre_Apellido desc;

## 44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor
esta consulta? ¿Por qué? Deja después de la consulta la contestación.

select *
from film f
cross join film_category fc;

## Esta consulta no aporta valor ya que nos genera una tabla con todas las combinaciones posibles que son innecesarias, lo lógico sería usar un inner join.  

## 45. Encuentra los actores que han participado en películas de la categoría
'Action'.

select fa.actor_id, fc.category_id
from film_actor fa 
join film f on f.film_id=fa.film_id
join film_category fc on fc.film_id=f.film_id
join category c on c.category_id=fc.category_id 
where c.name = 'Action'; 

## 46. Encuentra todos los actores que no han participado en películas.

select Concat(a.first_name, ' ' , a.last_name) as Nombre_Apellido
from actor a 
left join film_actor fa on a.actor_id=fa.actor_id 
where fa.actor_id is null;

## 47. Selecciona el nombre de los actores y la cantidad de películas en las
que han participado.

select Concat(a.first_name, ' ' , a.last_name) as Nombre_Apellido , count(fa.film_id) as Numero_peliculas
from actor a
join film_actor fa on fa.actor_id=a.actor_id
group by  Nombre_Apellido
order by Nombre_Apellido desc; 

## 48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres
de los actores y el número de películas en las que han participado.

create view actor_num_peliculas as 
select Concat(a.first_name, ' ' , a.last_name) as Nombre_Apellido , count(fa.film_id) as Numero_peliculas
from actor a
join film_actor fa on fa.actor_id=a.actor_id
group by  Nombre_Apellido; 

## 49. Calcula el número total de alquileres realizados por cada cliente.

select c.customer_id , count(r.rental_id)
from rental r 
join customer c on c.customer_id=r.customer_id 
group by c.customer_id;

## 50. Calcula la duración total de las películas en la categoría 'Action'.

select sum(f.length) 
from film f 
join film_category fc on f.film_id=fc.film_id
join category c on fc.category_id=c.category_id
where c.name = 'Action';

## 51. Crea una tabla temporal llamada “cliente_rentas_temporal” para
almacenar el total de alquileres por cliente.

create temporary table cliente_rentas_temporal as
	select c.customer_id , count(r.rental_id)
	from rental r 
	join customer c on c.customer_id=r.customer_id 
	group by c.customer_id;

## 52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las
películas que han sido alquiladas al menos 10 veces.

create temporary table peliculas_alquiladas as
	select f.title, count(r.rental_id) 
	from film f 
 	join inventory i on i.film_id=f.film_id
	join rental r on i.inventory_id=r.inventory_id
	group by f.title
	having count(r.rental_id) >= 10;

## 53. Encuentra el título de las películas que han sido alquiladas por el cliente
con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena
los resultados alfabéticamente por título de película.

select f.title , concat(c.first_name, ' ',c.last_name)
from film f
join inventory i on i.film_id=f.film_id
join rental r on r.inventory_id=i.inventory_id
join customer c on c.customer_id=r.customer_id
where concat(c.first_name, ' ',c.last_name) = 'TAMMY SANDERS' and return_date is not null
order by f.title desc;

## 54. Encuentra los nombres de los actores que han actuado en al menos una
película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados
alfabéticamente por apellido.

select distinct a.first_name, a.last_name , c.name 
from actor a 
join film_actor fa on a.actor_id = fa.actor_id
join film f on fa.film_id = f.film_id
join film_category fc on f.film_id = fc.film_id
join category c on fc.category_id = c.category_id
where c.name = 'Sci-Fi'
order by a.last_name ;

## 55. Encuentra el nombre y apellido de los actores que han actuado en
películas que se alquilaron después de que la película ‘Spartacus
Cheaper’ se alquilara por primera vez. Ordena los resultados
alfabéticamente por apellido.

select distinct a.first_name , a.last_name 
from actor a
join film_actor fa on a.actor_id = fa.actor_id
join inventory i on fa.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
where r.rental_date > (
        select min(r2.rental_date)
        from film f2
        join inventory i2 on f2.film_id = i2.film_id
        join rental r2 on i2.inventory_id = r2.inventory_id
        where f2.title = 'SPARTACUS CHEAPER'
    )
order by a.last_name;

## 56. Encuentra el nombre y apellido de los actores que no han actuado en
ninguna película de la categoría ‘Music’.

select a.first_name , a.last_name 
from actor a 
where a.actor_id not in (
	select fa.actor_id 
    from film_actor fa
	join film_category fc on fa.film_id=fc.film_id
	join category c on fc.category_id=c.category_id 
	where c.name = 'Music' 
);

## 57. Encuentra el título de todas las películas que fueron alquiladas por más
de 8 días.

select distinct f.title
from film f 
join inventory i on f.film_id=i.film_id
join rental r on i.inventory_id=r.inventory_id
where extract(day from (r.return_date-r.rental_date)) > 8;

## 58. Encuentra el título de todas las películas que son de la misma categoría
que ‘Animation’.


select f.title , c.name
from film f 
join film_category fc on fc.film_id=f.film_id
join category c on c.category_id=fc.category_id 
where c.name = 'Animation';


## 59. Encuentra los nombres de las películas que tienen la misma duración
que la película con el título ‘Dancing Fever’. Ordena los resultados
alfabéticamente por título de película.
XXXXXX

select f.title 
from film f 
where f.length = (
 	select f1.length
	from film f1
	where f1.title ='Dancing Fever'
)
order by f.title desc;
  

## 60. Encuentra los nombres de los clientes que han alquilado al menos 7
películas distintas. Ordena los resultados alfabéticamente por apellido.

select c.first_name, c.last_name , count(distinct i.film_id)  
from customer c
join rental  r on r.customer_id=c.customer_id
join inventory i on i.inventory_id=r.inventory_id
group by c.customer_id, c.first_name, c.last_name
having count(distinct i.film_id) >=7
order by c.last_name desc;


## 61. Encuentra la cantidad total de películas alquiladas por categoría y
muestra el nombre de la categoría junto con el recuento de alquileres.

select c.name ,count(r.rental_id)
from rental r
join inventory i on i.inventory_id=r.inventory_id 
join film f on f.film_id=i.film_id
join film_category fc on fc.film_id=f.film_id
join category c on c.category_id=fc.category_id 
group by c.name 
order by count(r.rental_id) desc;

## 62. Encuentra el número de películas por categoría estrenadas en 2006.

select  c.name, count(f.film_id)
from film f
join film_category fc on fc.film_id=f.film_id 
join category c on c.category_id=fc.category_id
where f.release_year = 2016
group by c.name
order by count(f.film_id);

## 63. Obtén todas las combinaciones posibles de trabajadores con las tiendas
que tenemos.

select *
from staff s
cross join store ;

## 64. Encuentra la cantidad total de películas alquiladas por cada cliente y
muestra el ID del cliente, su nombre y apellido junto con la cantidad de
películas alquiladas

select c.customer_id, c.first_name, c.last_name , count(r.rental_id)
from rental r 
join customer c on c.customer_id=r.customer_id
group by c.customer_id, c.first_name, c.last_name ; 




























