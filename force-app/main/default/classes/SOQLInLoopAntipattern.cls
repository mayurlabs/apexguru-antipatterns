/**
 * ApexGuru Antipattern Example: SOQL in Loop
 * 
 * Executing SOQL queries inside loops can quickly exhaust the governor limits 
 * and decrease system performance. Salesforce enforces a limit on the number 
 * of queries per transaction. Instead, batch SOQL queries outside of loops.
 */
public class SOQLInLoopAntipattern {
    
    /**
     * ANTIPATTERN: SOQL Query Inside Loop
     * Problem: Executing SOQL queries inside loops exhausts governor limits
     */
    public void soqlInLoopAntipattern() {
        String someValue = 'Test Account';
        
        // ANTIPATTERN: SOQL query inside the loop
        for (Integer i = 0; i < 10; i++) {
            List<Account> accounts = [SELECT Id FROM Account WHERE Name = :someValue];
        }
    }
}