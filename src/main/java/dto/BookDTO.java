package dto;

import domain.DomainObject;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

public class BookDTO extends DomainObject {
    private String title;
    private Double price;
    private String imagePath;
}
