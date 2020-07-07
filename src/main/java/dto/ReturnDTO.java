package dto;

import domain.DomainObject;
import domain.Status;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

public class ReturnDTO extends DomainObject {
    private String operation;
    private Integer itemId;
    private Status status;
    private String returnReason;
}
