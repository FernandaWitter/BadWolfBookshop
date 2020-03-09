package domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter

@AllArgsConstructor
@NoArgsConstructor
public class Book extends DomainObject{
    private String title;
    private List<Author> authors;
    private Publisher publisher;
    private Integer pubYear;
    private Integer pubEdition;
    private String language;
    private String isbn;
    private List<Category> categories;
    private String summary;
    private List<Image> images;
    private Double height;
    private Double width;
    private Double depth;
    private Double weight;
    private Double price;
    private Integer inStock;
    private Integer pages;
}
