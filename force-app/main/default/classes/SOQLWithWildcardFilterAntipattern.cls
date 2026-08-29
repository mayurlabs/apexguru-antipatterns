/**
 * ApexGuru Antipattern Example: SOQL with Wildcard Filter
 * 
 * This class demonstrates the anti-pattern of using wildcard filters in SOQL queries
 * such as LIKE '%term'. Using wildcards prevents the use of indexes and causes
 * full-table scans. Full-table scans increase query execution time and CPU usage.
 * 
 * Use indexed fields for filtering and optimized search strategies.
 */
public class SOQLWithWildcardFilterAntipattern {
    
    /**
     * ANTI-PATTERN: Using wildcard filter with LIKE '%term'
     * This is the exact example from the anti-pattern description
     */
    public void soqlWithWildcardFilterAntiPattern() {
        // ANTI-PATTERN: Using wildcard filter which prevents index usage
        List<Contact> contacts = [
            SELECT Id, LastName, FirstName 
            FROM Contact 
            WHERE LastName LIKE '%smi'
        ];
    }
    
    /**
     * ANTI-PATTERN: Using wildcard filter with LIKE '%term%'
     */
    public void soqlWithWildcardFilterContainsAntiPattern() {
        // ANTI-PATTERN: Using wildcard filter which prevents index usage
        List<Contact> contacts = [
            SELECT Id, LastName, FirstName, Email 
            FROM Contact 
            WHERE LastName LIKE '%smith%'
        ];
    }
} 