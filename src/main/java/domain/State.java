package domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor

@Getter
@Setter

public class State extends DomainObject {
    private Integer code;
    private String name;

    public State(int code) {
        this.code = code;
    }

    public State(int code, String name) {
        this.name = name;
        this.code = code;
    }
}
