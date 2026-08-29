/**
 * ApexGuru Antipattern Example: SOQL Without a WHERE Clause or LIMIT Statement
 * 
 * This class demonstrates the anti-pattern of executing SOQL queries without a 
 * WHERE clause or LIMIT statement. This can retrieve too many records, leading 
 * to governor-limit breaches for the number of rows returned.
 * 
 * To restrict the amount of data returned, include a WHERE clause or LIMIT 
 * statement in SOQL queries.
 */
public class SOQLWithoutWhereOrLimitAntipattern {
    
    /**
     * ANTI-PATTERN: SOQL without WHERE clause or LIMIT
     * This is the exact example from the anti-pattern description
     */
    public void soqlWithoutWhereOrLimitAntiPattern() {
        // ANTI-PATTERN: No WHERE clause or LIMIT statement
        List<Account> accounts = [
            SELECT Id, Name 
            FROM Account
        ];
    }
    
    /**
     * ANTI-PATTERN: SOQL for Contact without WHERE clause or LIMIT
     */
    public void soqlContactWithoutWhereOrLimitAntiPattern() {
        // ANTI-PATTERN: No WHERE clause or LIMIT statement
        List<Contact> contacts = [
            SELECT Id, FirstName, LastName, Email 
            FROM Contact
        ];
    }
} 