package domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor

@Getter
@Setter

public class CardCompany extends DomainObject {
    private String name;
    private Integer code;

    public CardCompany(int code) {
        this.code = code;
    }
}
