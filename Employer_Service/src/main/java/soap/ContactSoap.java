package soap;
 
import java.util.List;

import javax.inject.Inject;
import javax.ws.rs.BadRequestException; 
import com.yusufsezer.model.Contact;
import com.yusufsezer.service.ContactService;

import jakarta.jws.WebMethod;
import jakarta.jws.WebService; 
 
@WebService
public class ContactSoap {

	@Inject
	ContactService contactService;
	@WebMethod
	public List<Contact> getContacts() {
		return contactService.getContacts();
	}

	@WebMethod
	public Contact getContact(int id) {
		return findContact(id);
	}

	@WebMethod
	public void addContact(Contact contact) {

		Contact newContact = contactService.addContact(contact);

	}

	@WebMethod
	public Contact updateContact(int id, Contact contact) {
		findContact(id);
		return contactService.updateContact(contact);
	}

	@WebMethod
	public Contact deleteContact(int id) {
		findContact(id);
		return contactService.removeContact(id);
	}

	@WebMethod
	public Contact findContact(int id) {
		if (id < 1) {
			throw new BadRequestException();
		}
		Contact foundContact = contactService.getContact(id);
		if (foundContact == null) {

		}
		if (id != foundContact.getId()) {
		}
		return foundContact;
	}
}
