package dto;

import domain.Address;
import domain.DomainObject;
import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor

@Getter

public class AddressDTO extends DomainObject {
    private String nickname;
    private Boolean isBilling;
    private Boolean isShipping;
    private Boolean isMain;

    public AddressDTO(int id) {
        this.setId(id);
    }

    public AddressDTO(int id, String type) {
        this.setId(id);
        if (type.toLowerCase().equals("billing"))
            this.isBilling = true;
        else if (type.toLowerCase().equals("shipping"))
            this.isShipping = true;
    }

    public static AddressDTO from(Address address) {
        AddressDTO dto = new AddressDTO();
        dto.setId(address.getId());
        dto.nickname = address.getNickname();
        dto.isBilling = address.getIsBilling();
        dto.isShipping = address.getIsDelivery();
        dto.isMain = address.getIsMain();
        return dto;
    }

    public static Address toAddress(AddressDTO dto) {
        Address address = new Address();
        if (dto.getId() != null)
            address.setId(dto.getId());
        return address;
    }

}
