package com.xnx3.j2ee.bean;

import com.xnx3.j2ee.entity.Permission;

/**
 * 资源标示
 * @author 管雷鸣
 *
 */
public class PermissionMark{
	private boolean selected;	//是否选中
	private Permission permission;
	
	public PermissionMark() {
		this.selected=false;
	}
	
	public boolean isSelected() {
		return selected;
	}
	public void setSelected(boolean isSelected) {
		this.selected = isSelected;
	}
	public Permission getPermission() {
		return permission;
	}
	public void setPermission(Permission permission) {
		this.permission = permission;
	}	
	
	
}