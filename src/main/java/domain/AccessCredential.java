package domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AccessCredential extends DomainObject {
    private String username;
    private String password;
    private String confirmPassword;
    private String pwHash;
    private String salt;
}
