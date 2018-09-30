package localservice.models;

import java.io.Serializable;

public class ChangePassword implements Serializable {

	private static final long serialVersionUID = -3568977212226238504L;

	private String oldPassword;
	private String newPassword;
	private String repeatNewPassword;
	
	public String getOldPassword() {
		return oldPassword;
	}
	public void setOldPassword(String oldPassword) {
		this.oldPassword = oldPassword;
	}
	public String getNewPassword() {
		return newPassword;
	}
	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}
	public String getRepeatNewPassword() {
		return repeatNewPassword;
	}
	public void setRepeatNewPassword(String repeatNewPassword) {
		this.repeatNewPassword = repeatNewPassword;
	}
	
}
