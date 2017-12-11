package localservice.models;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

@Entity
public class Reservation implements Serializable {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int id;
	private String referenceId;
	private String type;
	@Temporal(TemporalType.TIMESTAMP)
	private Date checkIn;
	@Temporal(TemporalType.TIMESTAMP)
	private Date checkOut;
	private int countAdult;
	private int countChildren;
	private String status;	
	private String remarks;
	@Transient
	private List<Room> rooms;
	@Transient
	private List<AdditionalCharge> additionalCharges;
	@Transient
	private Guest mainGuest;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getReferenceId() {
		return referenceId;
	}
	public void setReferenceId(String referenceId) {
		this.referenceId = referenceId;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public Date getCheckIn() {
		return checkIn;
	}
	public void setCheckIn(Date checkIn) {
		this.checkIn = checkIn;
	}
	public Date getCheckOut() {
		return checkOut;
	}
	public void setCheckOut(Date checkOut) {
		this.checkOut = checkOut;
	}
	public int getCountAdult() {
		return countAdult;
	}
	public void setCountAdult(int countAdult) {
		this.countAdult = countAdult;
	}
	public int getCountChildren() {
		return countChildren;
	}
	public void setCountChildren(int countChildren) {
		this.countChildren = countChildren;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public List<Room> getRooms() {
		return rooms;
	}
	public void setRooms(List<Room> rooms) {
		this.rooms = rooms;
	}
	public List<AdditionalCharge> getAdditionalCharges() {
		return additionalCharges;
	}
	public void setAdditionalCharges(List<AdditionalCharge> additionalCharges) {
		this.additionalCharges = additionalCharges;
	}
	
	public Guest getMainGuest() {
		return mainGuest;
	}
	public void setMainGuest(Guest mainGuest) {
		this.mainGuest = mainGuest;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		result = prime * result + ((referenceId == null) ? 0 : referenceId.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Reservation other = (Reservation) obj;
		if (id != other.id)
			return false;
		if (referenceId == null) {
			if (other.referenceId != null)
				return false;
		} else if (!referenceId.equals(other.referenceId))
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "Reservation [id=" + id + ", referenceNumber=" + referenceId + ", type=" + type + ", checkIn="
				+ checkIn + ", checkOut=" + checkOut + ", countAdult=" + countAdult + ", countChildren=" + countChildren
				+ ", status=" + status + "]";
	}	
}
