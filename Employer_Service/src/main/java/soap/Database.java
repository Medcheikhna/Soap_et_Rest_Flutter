package soap;
 
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class Database {

    private static final Map<Integer, Contact> contacts = new ConcurrentHashMap<>();

    public static Map<Integer, Contact> getContacts() {
        return contacts;
    }

}
