package com.hk.ansdtos;

import java.io.Serializable;
import java.util.Date;

public class AnsDto implements Serializable {

	private static final long serialVersionUID = 5637327884674948303L;
	
	private int seq;
	private String id;
	private String title;
	private String content;
	private Date regDate;
	private int refer;
	private int step;
	private int depth;
	private int readCount;
	private String delFlag;
	
	public AnsDto() {
		// TODO Auto-generated constructor stub
	}
	
	public AnsDto(int seq, String id, String title, String content, Date regDate, int refer, int step, int depth,
			int readCount, String delFlag) {
		super();
		this.seq = seq;
		this.id = id;
		this.title = title;
		this.content = content;
		this.regDate = regDate;
		this.refer = refer;
		this.step = step;
		this.depth = depth;
		this.readCount = readCount;
		this.delFlag = delFlag;
	}
	

	public AnsDto(String id, String title, String content) {
		super();
		this.id = id;
		this.title = title;
		this.content = content;
	}

	
	public AnsDto(int seq, String title, String content) {
		super();
		this.seq = seq;
		this.title = title;
		this.content = content;
	}
	

	public AnsDto(int seq, String id, String title, String content) {
		super();
		this.seq = seq;
		this.id = id;
		this.title = title;
		this.content = content;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public int getRefer() {
		return refer;
	}

	public void setRefer(int refer) {
		this.refer = refer;
	}

	public int getStep() {
		return step;
	}

	public void setStep(int step) {
		this.step = step;
	}

	public int getDepth() {
		return depth;
	}

	public void setDepth(int depth) {
		this.depth = depth;
	}

	public int getReadCount() {
		return readCount;
	}

	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}

	public String getDelFlag() {
		return delFlag;
	}

	public void setDelFlag(String delFlag) {
		this.delFlag = delFlag;
	}

	@Override
	public String toString() {
		return "AnsDto [seq=" + seq + ", id=" + id + ", title=" + title + ", content=" + content + ", regDatd="
				+ regDate + ", refer=" + refer + ", step=" + step + ", depth=" + depth + ", readCount=" + readCount
				+ ", delFlag=" + delFlag + "]";
	}
	
	
}