/**
 * ApexGuru Antipattern Example: SOQL with Unused Fields
 * 
 * This class demonstrates the anti-pattern of retrieving unused fields in SOQL queries.
 * Retrieving unused fields increases overhead, resource consumption, and query execution
 * time. It also increases heap size and causes governor limits to be exceeded, especially
 * with large datasets or complex objects.
 * 
 * Only include fields directly required by your logic. Regularly review and improve
 * SOQL queries to remove unused fields.
 */
public class SOQLWithUnusedFieldsAntipattern {
    
    /**
     * ANTI-PATTERN: SOQL with unused fields
     * This is the exact example from the anti-pattern description
     */
    public void soqlWithUnusedFieldsAntiPattern() {
        Id recordId = '001000000000001';
        
        // ANTI-PATTERN: Retrieving unused fields in SOQL query
        // KnowledgeArticleId is not used in the logic
        List<Knowledge__kav> articles = [
            SELECT id, KnowledgeArticleId, PublishStatus, Article_Tag__c 
            FROM Knowledge__kav 
            WHERE id = :recordId
        ];
    }
    
    /**
     * ANTI-PATTERN: SOQL with unused Account fields
     */
    public void soqlWithUnusedAccountFieldsAntiPattern() {
        // ANTI-PATTERN: Retrieving unused fields in SOQL query
        List<Account> accounts = [
            SELECT Id, Name, Industry, Type, BillingCity, BillingState, 
                ShippingCity, ShippingState, Phone, Fax, Website, 
                Description, AnnualRevenue, NumberOfEmployees, 
                OwnerId, CreatedDate, LastModifiedDate
            FROM Account 
            WHERE Industry = 'Technology'
        ];
        
        // Only using Name and Industry in the logic
        for (Account acc : accounts) {
            System.debug('Account: ' + acc.Name);
            System.debug('Industry: ' + acc.Industry);
            // All other fields are never used
        }
    }
} 