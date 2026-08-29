/**
 * ApexGuru Antipattern Example: SOQL in a Loop (One Hop)
 * 
 * The SOQL query is placed in a method in one class and the loop that invokes 
 * this method is in a different class. This structure leads to excessive SOQL 
 * queries, potentially hitting governor limits. Repeated query execution across 
 * class boundaries causes performance bottlenecks.
 */
public class SOQLInLoopOneHopAntipattern {
    
    /**
     * ANTIPATTERN: Method with SOQL query that gets called from loop in another class
     */
    public static List<Contact> getContactsForAccount(Id accId) {
        // ANTIPATTERN: This SOQL will be executed once per loop iteration
        return [SELECT Id, Name FROM Contact WHERE AccountId = :accId LIMIT 5];
    }
    
    /**
     * ANTIPATTERN: Loop that calls method with SOQL query
     */
    public static void processAccounts() {
        // Check CRUD permissions
        if (!Schema.sObjectType.Account.isAccessible() || !Schema.sObjectType.Contact.isAccessible()) {
            return;
        }
        
        List<Account> accounts = [SELECT Id, Name FROM Account LIMIT 10];
        
        // ANTIPATTERN: Each iteration calls a method that executes SOQL
        for (Account acc : accounts) {
            List<Contact> contacts = getContactsForAccount(acc.Id);
            // Process contacts - this causes N+1 query problem across class boundaries
            System.debug('Account ' + acc.Name + ' has ' + contacts.size() + ' contacts');
        }
    }
}
