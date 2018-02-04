package localservice.repositories;

import org.springframework.data.repository.CrudRepository;

import localservice.models.ApplicationProperties;

public interface ApplicationPropertiesRepository extends CrudRepository<ApplicationProperties, Integer>{
	
}
