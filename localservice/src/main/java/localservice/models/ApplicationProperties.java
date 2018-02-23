package localservice.models;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
public class ApplicationProperties implements Serializable {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int id;
	private int maxAdultPerBooking;
	private int maxChildrenPerBooking;
	private double entranceFeeAdult;
	private double entranceFeeChild;
	private int downPaymentPercentage;
	private int vatPercentage;
	@Temporal(TemporalType.TIMESTAMP)
	private Date changeDate;
	private double onlineBookingDiscount;
	private int tempReserveMinutes;
	private int gracePeriodBankDepositHours;
	private String emailBankDeposit;
	private String bank;
	private String account;
	private String merchant;	
	
	public String getBank() {
		return bank;
	}
	public void setBank(String bank) {
		this.bank = bank;
	}	
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getMerchant() {
		return merchant;
	}
	public void setMerchant(String merchant) {
		this.merchant = merchant;
	}
	public String getEmailBankDeposit() {
		return emailBankDeposit;
	}
	public void setEmailBankDeposit(String emailBankDeposit) {
		this.emailBankDeposit = emailBankDeposit;
	}
	public int getGracePeriodBankDepositHours() {
		return gracePeriodBankDepositHours;
	}
	public void setGracePeriodBankDepositHours(int gracePeriodBankDepositHours) {
		this.gracePeriodBankDepositHours = gracePeriodBankDepositHours;
	}
	public int getTempReserveMinutes() {
		return tempReserveMinutes;
	}
	public void setTempReserveMinutes(int tempReserveMinutes) {
		this.tempReserveMinutes = tempReserveMinutes;
	}
	public int getMaxAdultPerBooking() {
		return maxAdultPerBooking;
	}
	public void setMaxAdultPerBooking(int maxAdultPerBooking) {
		this.maxAdultPerBooking = maxAdultPerBooking;
	}
	public int getMaxChildrenPerBooking() {
		return maxChildrenPerBooking;
	}
	public void setMaxChildrenPerBooking(int maxChildrenPerBooking) {
		this.maxChildrenPerBooking = maxChildrenPerBooking;
	}
	public double getEntranceFeeAdult() {
		return entranceFeeAdult;
	}
	public void setEntranceFeeAdult(double entranceFeeAdult) {
		this.entranceFeeAdult = entranceFeeAdult;
	}
	public double getEntranceFeeChild() {
		return entranceFeeChild;
	}
	public void setEntranceFeeChild(double entranceFeeChild) {
		this.entranceFeeChild = entranceFeeChild;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Date getChangeDate() {
		return changeDate;
	}
	public void setChangeDate(Date changeDate) {
		this.changeDate = changeDate;
	}
	public int getDownPaymentPercentage() {
		return downPaymentPercentage;
	}
	public void setDownPaymentPercentage(int downPaymentPercentage) {
		this.downPaymentPercentage = downPaymentPercentage;
	}	
	public int getVatPercentage() {
		return vatPercentage;
	}
	public void setVatPercentage(int vatPercentage) {
		this.vatPercentage = vatPercentage;
	}	
	public double getOnlineBookingDiscount() {
		return onlineBookingDiscount;
	}
	public void setOnlineBookingDiscount(double onlineBookingDiscount) {
		this.onlineBookingDiscount = onlineBookingDiscount;
	}
	@Override
	public String toString() {
		return "ApplicationProperties [id=" + id + ", maxAdultPerBooking=" + maxAdultPerBooking
				+ ", maxChildrenPerBooking=" + maxChildrenPerBooking + ", entranceFeeAdult=" + entranceFeeAdult
				+ ", entranceFeeChild=" + entranceFeeChild + ", downPaymentPercentage=" + downPaymentPercentage
				+ ", changeDate=" + changeDate + "]";
	}	
}
