/**
 * ApexGuru Antipattern: Sorting in Apex
 * 
 * This class demonstrates the antipattern of sorting records in Apex code instead of
 * using database-level sorting with ORDER BY clause.
 * 
 * PROBLEM:
 * - Sorting records in Apex consumes more CPU time and can exceed governor limits
 * - Can lead to heap-size overflows with large datasets
 * - Degrades query performance by transferring unsorted data from database
 * - Inefficient memory usage as all records must be loaded before sorting
 * 
 * IMPACT:
 * - CPU Time Limit exceptions (10 seconds sync, 60 seconds async)
 * - Heap Size Limit exceptions (6MB sync, 12MB async)
 * - Poor performance and user experience
 * - Increased SOQL query execution time
 * 
 * RECOMMENDATION:
 * Use ORDER BY clause in SOQL to delegate sorting to the database layer
 */
public with sharing class SortingInApexAntipattern {
    
    // ==============================================
    // ANTIPATTERN EXAMPLES (What NOT to do)
    // ==============================================
    
    /**
     * ANTIPATTERN: Sorting Contacts in Apex after querying
     * This approach loads all records into memory then sorts them in Apex
     */
    public static List<Contact> getSortedContactsAntipattern() {
        // Check CRUD permissions
        if (!Schema.sObjectType.Contact.isAccessible()) {
            throw new System.NoAccessException();
        }
        
        // Bad: Query without ORDER BY, then sort in Apex
        List<Contact> contacts = [SELECT Id, FirstName, LastName, Email, BillingState 
                                 FROM Contact];
        contacts.sort();
        
        return contacts;
    }
}