package domain;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter

@NoArgsConstructor
public class Author extends DomainObject{
    private String name;

    public Author(String name){
        this.name = name;
    }
}
