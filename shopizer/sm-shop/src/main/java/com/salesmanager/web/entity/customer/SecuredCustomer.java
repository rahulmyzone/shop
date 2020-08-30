package com.salesmanager.web.entity.customer;

import java.io.Serializable;

import javax.persistence.Transient;
import javax.validation.constraints.Size;

import com.salesmanager.web.utils.FieldMatch;


@FieldMatch.List({
    @FieldMatch(first="password",second="checkPassword",message="password.notequal")
    
})
public class SecuredCustomer extends PersistableCustomer implements Serializable {

	/**
	 *
	 */
	private static final long serialVersionUID = 1L;
	


	@Size(min=6, message="{registration.password.not.empty}")
	private String password;
	
	@Size(min=6, message="{registration.password.not.empty}")
	private String checkPassword;
	

	@Transient
	private String login;

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

    public String getCheckPassword()
    {
        return checkPassword;
    }

    public void setCheckPassword( String checkPassword )
    {
        this.checkPassword = checkPassword;
    }

	public String getLogin() {
		return login;
	}

	public void setLogin(String login) {
		this.login = login;
	}
	
	

}
