package inventory;

import org.testng.annotations.Test;
import com.intuit.karate.junit5.Karate;

public class InventoryTestRunner {
	    @Test
		@Karate.Test
	    Karate testInventory() {
	        return Karate.run("inventory").relativeTo(getClass());
	    }
	}
