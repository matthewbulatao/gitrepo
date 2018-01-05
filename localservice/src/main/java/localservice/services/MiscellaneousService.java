package localservice.services;

import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import localservice.models.Miscellaneous;
import localservice.repositories.MiscellaneousRepository;

@Service
@Transactional
public class MiscellaneousService extends BaseService<Miscellaneous>{

	private MiscellaneousRepository miscellaneousRepository;

	public MiscellaneousService(MiscellaneousRepository miscellaneousRepository) {
		super(miscellaneousRepository);
		this.miscellaneousRepository = miscellaneousRepository;
	}
	
	
}
