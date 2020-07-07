package dto;

import domain.DomainObject;
import lombok.Getter;
import lombok.Setter;

import java.util.HashMap;

@Getter
@Setter
public class ReturnChartDTO extends DomainObject {
    HashMap<String, Integer> booksByStatus;

    public ReturnChartDTO() {
        this.booksByStatus = new HashMap<>();
    }

    public void addStatus(String status, Integer amount) {
        booksByStatus.put(status, amount);
    }
}
