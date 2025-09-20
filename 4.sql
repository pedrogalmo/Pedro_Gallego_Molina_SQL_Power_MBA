##   Obtén las películas cuyo idioma coincide con el idioma original.


select f.title , f.original_language_id , f.language_id 
from film f 
where f.language_id=f.original_language_id ;