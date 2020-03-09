package domain;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.util.List;

@Getter
@Setter

public class User extends DomainObject {
    private AccessCredential accessCredential;
    private String name;
    private String nickname;
    private String email;
    private String federalId;
    private LocalDate birthday;
    private String areaCode;
    private String phone;
    private List<Address> addresses;
    private List<CreditCard> creditCards;
}
