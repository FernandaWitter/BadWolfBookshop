package domain;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter

@NoArgsConstructor
public class Publisher extends DomainObject {
    private String name;

    public Publisher(int id) {
        super(id);
    }

    public Publisher(String name) {
        this.name = name;
    }
}
