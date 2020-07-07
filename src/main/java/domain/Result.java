package domain;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class Result extends DomainObject {
    private HashMap<String, ArrayList<DomainObject>> map = new HashMap<>();
    private HashMap<String, String> msg = new HashMap<>();

    public Result() {
        this(0);
    }

    public Result(int id) {
        super(id);
    }

    public ArrayList<DomainObject> getObject(String nome) {
        if (map.containsKey(nome))
            return map.get(nome);
        return null;
    }

    public void putObject(String key, ArrayList<DomainObject> list) {
        if (null != list && !list.isEmpty()) {
            if (!map.containsKey(key))
                map.put(key, list);
            else
                map.replace(key, list);
        }
    }

    public void putObject(String key, DomainObject object) {
        if (map.containsKey(key)) {
            map.get(key).add(object);
        } else {
            ArrayList<DomainObject> list = new ArrayList<>();
            list.add(object);
            map.put(key, list);
        }
    }

    public void removeObject(String name) {
        if (map.containsKey(name))
            map.remove(name);
    }

    public String getMsg(String ref) {
        if (msg.containsKey(ref))
            return msg.get(ref);
        return null;
    }

    public void setMsg(String ref, String message) {
        if (msg.containsKey(ref))
            msg.replace(ref, msg.get(ref) + " <br/> " + message);
        else
            msg.put(ref, message);
    }

    public void removeMsg(String ref) {
        if (msg.containsKey(ref))
            msg.remove(ref);
    }

    public boolean hasMsg(String ref) {
        return msg.containsKey(ref) && msg.get(ref) != null;
    }

    public boolean hasObject(String name) {
        return map.containsKey(name);
    }

    public HashMap<String, ArrayList<DomainObject>> getObjects() {
        return map;
    }

    public HashMap<String, String> getMessages() {
        return msg;
    }

    public void merge(Result result) {
        result.getMessages().forEach((k, v) -> {
            this.setMsg(k, v);
        });
        result.getObjects().forEach((k, v) -> {
            this.putObject(k, v);
        });
    }
}