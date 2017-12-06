package localservice.services;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Service;

@Service
@Transactional
public class BaseService<T> {
	
	private CrudRepository<T, Integer> repository;

	public BaseService(CrudRepository<T, Integer> repository) {
		this.repository = repository;
	}
	
	public T saveOrUpdate(T model) {
		return this.repository.save(model);
	}
	
	public List<T> findAll(){
		return (List<T>) this.repository.findAll();
	}
}
