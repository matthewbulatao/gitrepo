package localservice.services;

import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import localservice.models.Reservation;
import localservice.repositories.ReservationRepository;

@Service
@Transactional
public class ReservationService extends BaseService<Reservation>{
	
	private ReservationRepository reservationRepository;

	public ReservationService(ReservationRepository reservationRepository) {
		super(reservationRepository);
		this.reservationRepository = reservationRepository;
	}
	
	
}
