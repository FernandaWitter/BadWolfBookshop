package domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;

@AllArgsConstructor
@NoArgsConstructor

@Getter
@Setter
public class Voucher extends DomainObject {
    private LocalDate creationDate;
    private LocalDate expirationDate;
    private String code;
    private Double amount;
    private boolean isActive;
    private Integer user;

    public Voucher(int id) {
        this.setId(id);
    }
}
