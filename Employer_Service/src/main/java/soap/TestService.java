package soap;

import jakarta.xml.ws.Endpoint;
import soap.ContactSoap;

public class TestService {

    public static void main(String[] args) {
        // Creer et publier un servce SOAP
        String addresse = "http://localhost:8089/Service_Contact";
        Endpoint.publish(addresse,   new ContactSoap());

        System.out.println("Le service SOAP est lanceé à l'adresse : " + addresse);
    }
}
