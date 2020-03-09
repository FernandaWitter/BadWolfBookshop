package domain;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
public class CreditCard extends DomainObject {
    private String cardNumber;
    private String cvv;
    private String holderName;
    private LocalDate expiration;
    private String cardCompany;
}
