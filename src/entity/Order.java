package entity;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Order {
	private int oid;
	private int uid;
	private int pid;
	private int pnum;
	private String createTime;
	private String destoryTime;
	private int status;
	
	@Override
	public String toString() {
		return "Order [oid=" + oid + ", uid=" + uid + ", pid=" + pid + ", pnum=" + pnum + ", createTime=" + createTime
				+ ", destoryTime=" + destoryTime + ", status=" + status + "]";
	}
	
	public int getOid() {
		return oid;
	}
	public void setOid(int oid) {
		this.oid = oid;
	}
	public int getUid() {
		return uid;
	}
	public void setUid(int uid) {
		this.uid = uid;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public int getPnum() {
		return pnum;
	}
	public void setPnum(int pnum) {
		this.pnum = pnum;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getDestoryTime() {
		return destoryTime;
	}
	public void setDestoryTime() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		this.destoryTime = sdf.format(new Date());//获取当前系统时间
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
}
