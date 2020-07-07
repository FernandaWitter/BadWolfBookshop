package dto;

import domain.DomainObject;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;

@Getter
@Setter
public class BookChartDTO extends DomainObject {
    private LocalDate startDate;
    private LocalDate endDate;
    private LinkedHashMap<String, HashMap<String, Integer>> results;
    private ArrayList<String> foundCategories;

    public BookChartDTO() {
        this.results = new LinkedHashMap<>();
        this.foundCategories = new ArrayList<>();
    }

    public void addResult(String date, HashMap<String, Integer> map) {
        this.results.put(date, map);
    }

    public void addCategory(String cat) {
        if (!foundCategories.contains(cat))
            foundCategories.add(cat);
    }
}
