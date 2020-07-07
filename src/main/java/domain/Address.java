package domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Address extends DomainObject {
    private String place;
    private String number;
    private String complement;
    private String zipCode;
    private String neighborhood;
    private String city;
    private State state;
    private Country country;
    private Boolean isDelivery;
    private Boolean isBilling;
    private Boolean isMain;
    private String nickname;
    private Integer user;
    private Boolean saveAddress;
}
