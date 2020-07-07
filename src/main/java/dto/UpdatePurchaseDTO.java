package dto;

import domain.DomainObject;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter

public class UpdatePurchaseDTO extends DomainObject {
    private Integer orderId;
    private List<Integer> updateItems;
    private List<Integer> rejectItems;

    public UpdatePurchaseDTO() {
        this.updateItems = new ArrayList<>();
        this.rejectItems = new ArrayList<>();
    }
}
