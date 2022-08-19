package vo;

public class Customer {
	private String customerId;
	private String customerPass;
	private String customerName;
	private String customerAddress;
	private String customerDetail;
	private String customerTelephone;
	private String updateDate;
	private String createDate;
	public String getCustomerId() {
		return customerId;
	}
	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}
	public String getCustomerPass() {
		return customerPass;
	}
	public void setCustomerPass(String customerPass) {
		this.customerPass = customerPass;
	}
	public String getCustomerName() {
		return customerName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	public String getCustomerAddress() {
		return customerAddress;
	}
	public void setCustomerAddress(String customerAddress) {
		this.customerAddress = customerAddress;
	}
	public String getCustomerDetail() {
		return customerDetail;
	}
	public void setCustomerDetail(String customerDetail) {
		this.customerDetail = customerDetail;
	}
	public String getCustomerTelephone() {
		return customerTelephone;
	}
	public void setCustomerTelephone(String customerTelephone) {
		this.customerTelephone = customerTelephone;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	@Override
	public String toString() {
		return "Customer [customerId=" + customerId + ", customerPass=" + customerPass + ", customerName="
				+ customerName + ", customerAddress=" + customerAddress + ", customerDetail=" + customerDetail
				+ ", customerTelephone=" + customerTelephone + ", updateDate=" + updateDate + ", createDate="
				+ createDate + "]";
	}
	
	
	
	
	
	
}
