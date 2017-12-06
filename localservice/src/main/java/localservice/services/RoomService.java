package localservice.services;

import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import localservice.models.Room;
import localservice.repositories.RoomRepository;

@Service
@Transactional
public class RoomService extends BaseService<Room> {

	private RoomRepository roomRepository;

	public RoomService(RoomRepository roomRepository) {
		super(roomRepository);
		this.roomRepository = roomRepository;
	}
	
	
}
