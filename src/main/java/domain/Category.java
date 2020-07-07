package domain;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter

@NoArgsConstructor
public class Category extends DomainObject {
    private String name;

    public Category(String name) {
        this.name = name;
    }
}
