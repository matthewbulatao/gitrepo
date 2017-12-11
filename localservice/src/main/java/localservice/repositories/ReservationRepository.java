package localservice.repositories;

import org.springframework.data.repository.CrudRepository;

import localservice.models.Reservation;

public interface ReservationRepository extends CrudRepository<Reservation, Integer>{

}
