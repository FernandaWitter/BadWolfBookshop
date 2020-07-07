package domain;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter

public class User extends DomainObject {
    private AccessCredential accessCredential;
    private String name;
    private String nickname;
    private String federalId;
    private LocalDate birthday;
    private String areaCode;
    private String phone;
    private List<Address> addresses;
    private List<CreditCard> creditCards;
    private List<Voucher> vouchers;

    public User() {
        this.addresses = new ArrayList<>();
        this.creditCards = new ArrayList<>();
        this.vouchers = new ArrayList<>();
    }

    public User(int id) {
        this();
        this.setId(id);
    }

    public void addCard(CreditCard card) {
        this.creditCards.add(card);
    }

    public void addAddress(Address address) {
        this.addresses.add(address);
    }

    public Address getAddressByIndex(int index) {
        return this.addresses.get(index);
    }

    public CreditCard getCardByIndex(int index) {
        return this.creditCards.get(index);
    }
}
