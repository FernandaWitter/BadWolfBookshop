package dto;

import domain.AccessCredential;
import domain.DomainObject;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

public class LoginDTO extends DomainObject {
    private int userId;
    private AccessCredential ac;
    private CartDTO cart;
}
