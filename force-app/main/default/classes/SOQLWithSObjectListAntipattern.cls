/**
 * ApexGuru Antipattern Example: SOQL with a List of SObjects for an In-Bind to ID
 * 
 * This class demonstrates the anti-pattern of using a list of SObjects for an IN bind
 * to an ID field. When you use a list of SObjects for an IN bind to an ID field, Apex
 * converts the list of SObjects into a string. When there are many fields in the SObject,
 * it increases CPU usage and causes performance degradation. If the resulting query exceeds
 * the 4,000-character limit imposed by Salesforce, the query fails and there are runtime exceptions.
 * 
 * Use a list of IDs instead of SObjects. Use only the list of IDs for the IN bind,
 * not the entire SObject list.
 */
public class SOQLWithSObjectListAntipattern {
    
    /**
     * ANTI-PATTERN: Using SObject list for IN bind to ID field
     * This is the exact example from the anti-pattern description
     */
    public void soqlWithSObjectListAntiPattern() {
        List<Account> accounts = [SELECT Id FROM Account];
        
        // ANTI-PATTERN: Using SObject list for IN bind to ID field
        // This causes performance degradation and can exceed 4,000-character limit
        List<Task> tasks = [SELECT Id FROM Task WHERE WhoId IN :accounts];
    }
    
    /**
     * ANTI-PATTERN: Using SObject list for IN bind with multiple fields
     */
    public void soqlWithSObjectListMultipleFieldsAntiPattern() {
        List<Account> accounts = [SELECT Id, Name, Industry, Type, BillingCity, BillingState FROM Account];
        
        // ANTI-PATTERN: Using SObject list with many fields for IN bind
        // This increases CPU usage and can cause performance degradation
        List<Task> tasks = [SELECT Id FROM Task WHERE WhoId IN :accounts];
    }
} 