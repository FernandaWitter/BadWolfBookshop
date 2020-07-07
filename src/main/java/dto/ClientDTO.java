package dto;

import domain.DomainObject;
import domain.User;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor

@Getter
@Setter

public class ClientDTO extends DomainObject {
    private User user;
    private boolean signedUseTerms;
    private boolean isCreate;
    private boolean isUpdateBasicData;
}
