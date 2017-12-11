package localservice.services;

import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import localservice.models.AdditionalCharge;
import localservice.repositories.AdditionalChargeRepository;

@Service
@Transactional
public class AdditionalChargeService extends BaseService<AdditionalCharge>{

	private AdditionalChargeRepository additionalChargeRepository;

	public AdditionalChargeService(AdditionalChargeRepository additionalChargeRepository) {
		super(additionalChargeRepository);
		this.additionalChargeRepository = additionalChargeRepository;
	}
	
	
}
