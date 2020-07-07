package domain;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor

@Getter
@Setter

public class Country extends DomainObject {
    private Integer code;
    private String name;

    public Country(int code) {
        this.code = code;
    }

    public Country(int code, String name) {
        this.name = name;
        this.code = code;
    }
}
