package domain;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;

@NoArgsConstructor

@Getter
@Setter
public class CreditCard extends DomainObject {
    private String cardNumber;
    private String cvv;
    private String holderName;
    private String expiration;
    private CardCompany cardCompany;
    private Integer user;
    private boolean isMain;

}
