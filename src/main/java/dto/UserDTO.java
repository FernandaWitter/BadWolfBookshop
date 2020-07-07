package dto;

import domain.DomainObject;
import domain.Voucher;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter

public class UserDTO extends DomainObject {
    String name;
    List<AddressDTO> addresses;
    List<CardDTO> cards;
    List<Voucher> vouchers;

    public UserDTO() {
        this.addresses = new ArrayList<>();
        this.cards = new ArrayList<>();
        this.vouchers = new ArrayList<>();
    }

    public UserDTO(int id) {
        this.addresses = new ArrayList<>();
        this.cards = new ArrayList<>();
        this.vouchers = new ArrayList<>();
        this.setId(id);
    }
}
