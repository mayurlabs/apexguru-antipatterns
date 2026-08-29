/**
 * ApexGuru Antipattern Example: DML in a Loop
 * 
 * This class demonstrates the anti-pattern of executing DML operations (insert, update, delete)
 * inside loops. This causes excessive resource consumption and can hit governor limits.
 * 
 * Instead, batch DML operations by storing records in a list and performing the DML
 * operation one time outside of the loop.
 */
public class DMLInLoopAntipattern {
    
    /**
     * ANTI-PATTERN: Insert DML in a loop
     * This is the exact example from the anti-pattern description
     */
    public void insertInLoopAntiPattern() {
        List<Account> accounts = new List<Account>();
        
        // Create some test accounts
        for (Integer i = 0; i < 10; i++) {
            Account acc = new Account(Name = 'Test Account ' + i);
            accounts.add(acc);
        }
        
        // ANTI-PATTERN: Insert DML inside the loop
        // This causes excessive resource consumption and can hit governor limits
        for (Account acc : accounts) {
            insert acc; // DML inside loop - BAD!
        }
    }
    
    /**
     * ANTI-PATTERN: Update DML in a loop
     */
    public void updateInLoopAntiPattern() {
        List<Account> accounts = [SELECT Id, Name, Industry FROM Account LIMIT 100];
        
        // ANTI-PATTERN: Update DML inside the loop
        for (Account acc : accounts) {
            acc.Industry = 'Technology';
            update acc; // DML inside loop - BAD!
        }
    }
    
    /**
     * ANTI-PATTERN: Delete DML in a loop
     */
    public void deleteInLoopAntiPattern() {
        List<Account> accountsToDelete = [SELECT Id FROM Account WHERE Name LIKE 'Test%' LIMIT 50];
        
        // ANTI-PATTERN: Delete DML inside the loop
        for (Account acc : accountsToDelete) {
            delete acc; // DML inside loop - BAD!
        }
    }
} 