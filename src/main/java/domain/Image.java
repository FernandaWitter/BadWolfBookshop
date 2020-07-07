package domain;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter

@NoArgsConstructor
public class Image extends DomainObject {
    private String path;
    private int book;

    public Image(String path) {
        this.path = path;
    }
}
