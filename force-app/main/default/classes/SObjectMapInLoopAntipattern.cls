/**
 * ApexGuru Antipattern Example: SObject Map in a For Loop
 * 
 * This class demonstrates the anti-pattern of building Map<Id, sObject> in a For loop.
 * Building Map<Id, sObject> in a For loop inserts one record at a time, which adds
 * unnecessary CPU overhead. This query fetches all records without filtering, which
 * causes extra CPU usage. Filtering later in Apex boosts memory use, risks overflow,
 * and slows performance.
 * 
 * Instead, use Apex's map constructor or putAll() method for efficient map creation.
 */
public class SObjectMapInLoopAntipattern {
    
    /**
     * ANTI-PATTERN: Building Map<Id, Account> in a For loop
     * This is the exact example from the anti-pattern description
     */
    public void buildAccountMapAntiPattern() {
        // ANTI-PATTERN: Manually looping through each sObject and inserting it into the map
        // This adds unnecessary CPU overhead
        Map<Id, Account> accMap = new Map<Id, Account>();
        for (Account acc : [SELECT Id, Name FROM Account]) {
            accMap.put(acc.Id, acc);
        }
        
        System.debug('Account map size: ' + accMap.size());
    }
    
    /**
     * ANTI-PATTERN: Building Map<Id, Contact> in a For loop
     */
    public void buildContactMapAntiPattern() {
        // ANTI-PATTERN: Manual loop for Contact map creation
        Map<Id, Contact> contactMap = new Map<Id, Contact>();
        for (Contact con : [SELECT Id, FirstName, LastName, Email FROM Contact]) {
            contactMap.put(con.Id, con);
        }
        
        System.debug('Contact map size: ' + contactMap.size());
    }
} 