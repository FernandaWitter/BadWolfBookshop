package domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Address extends DomainObject{
    private String place;
    private String number;
    private String complement;
    private String zipCode;
    private String neighborhood;
    private String city;
    private String state;
    private String country;
    private Boolean isDelivery;
    private Boolean isBilling;
    private Boolean isMain;
}
