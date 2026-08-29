/**
 * ApexGuru Antipattern Catalog: Consolidated Examples
 * 
 * This class demonstrates one sample of each ApexGuru antipattern identified in this project.
 * Each method represents a different antipattern with a brief explanation and example.
 * 
 * ANTIPATTERN CATALOG (17 Total):
 * ================================
 * 1. Busy Loop Delay - Using busy loops for delays instead of Salesforce alternatives
 * 2. Copying List Elements - Using for loops to copy collections instead of addAll()
 * 3. DML in Loop - Executing DML operations inside loops
 * 4. Schema.getGlobalDescribe() - Using global describe for single SObject metadata
 * 5. SObject Map in Loop - Building Map<Id, SObject> in for loops
 * 6. SOQL in Loop - Executing SOQL queries inside loops
 * 7. SOQL in Loop (One Hop) - SOQL queries across class boundaries in loops
 * 8. SOQL with Apex Filter - Filtering in Apex instead of SOQL WHERE clauses
 * 9. SOQL with Negative Expressions - Using NOT IN or != expressions
 * 10. SOQL with SObject List - Using SObject lists for IN binds to ID fields
 * 11. SOQL with Unused Fields - Retrieving fields not used in logic
 * 12. SOQL with Wildcard Filter - Using LIKE '%term' patterns
 * 13. SOQL without WHERE or LIMIT - Queries without filtering or limiting
 * 14. Sorting in Apex - Sorting records in Apex instead of ORDER BY
 * 15. testMethod Keyword - Using legacy testMethod instead of @isTest
 * 16. Filler Statements - Writing meaningless code for test coverage
 * 17. [Future] Additional antipatterns as they are discovered
 * 
 * USAGE:
 * This class serves as a quick reference and detection guide for all known
 * ApexGuru antipatterns. Each method demonstrates the problematic pattern
 * that should be avoided in production code.
 */
public with sharing class ApexGuruAntipatternCatalog {
    
    // ==============================================
    // PERFORMANCE ANTIPATTERNS
    // ==============================================
    
    /**
     * ANTIPATTERN #1: Busy Loop Delay
     * Problem: Using busy loops wastes CPU resources and can cause governor limit issues
     * Solution: Use System.schedule(), System.enqueueJob() with delay, or Queueable jobs
     */
    public void busyLoopDelayAntipattern() {
        Integer delayTime = 10; // Delay in seconds
        DateTime startTime = System.now();
        
        // ANTIPATTERN: Busy loop to create a delay
        // Note: Empty while loop is intentional antipattern example
        while (System.now() < startTime.addSeconds(delayTime)) {
            // Do nothing (busy wait) - wastes CPU resources
            // This empty loop is intentionally showing the antipattern
        }
        
        // Enqueue job after delay
        System.enqueueJob(new SampleQueueableJob());
    }
    
    /**
     * ANTIPATTERN #2: Copying List Elements
     * Problem: Using for loops to copy collections takes more CPU time
     * Solution: Use addAll() method for efficient collection copying
     */
    public void copyingListElementsAntipattern() {
        // Note: Using hardcoded IDs for demonstration purposes only
        Set<Id> sourceIds = new Set<Id>{'001000000000001', '001000000000002', '001000000000003'};
        Set<Id> targetIds = new Set<Id>();
        
        // ANTIPATTERN: Manually iterating to copy each Id
        for (Id sourceId : sourceIds) {
            targetIds.add(sourceId);
        }
        
        System.debug('Copied IDs: ' + targetIds);
    }
    
    /**
     * ANTIPATTERN #3: DML in Loop
     * Problem: DML operations in loops can hit governor limits (150 DML statements)
     * Solution: Batch DML operations outside of loops using lists
     */
    public void dmlInLoopAntipattern() {
        // Check CRUD permissions
        if (!Schema.sObjectType.Account.isCreateable()) {
            return;
        }
        
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 10; i++) {
            accounts.add(new Account(Name = 'Test Account ' + i));
        }
        
        // ANTIPATTERN: DML inside the loop (intentional antipattern example)
        for (Account acc : accounts) {
            insert acc; // Each insert counts toward DML limit - THIS IS THE ANTIPATTERN
        }
    }
    
    /**
     * ANTIPATTERN #4: Schema.getGlobalDescribe() Not Efficient
     * Problem: Global describe causes unnecessary overhead for single SObject metadata
     * Solution: Use getSObjectType() method for efficient metadata retrieval
     */
    public void schemaGetGlobalDescribeAntipattern() {
        // ANTIPATTERN: Using Schema.getGlobalDescribe() for single known SObject
        Schema.DescribeSObjectResult caseDescribe = Schema.getGlobalDescribe().get('Case').getDescribe();
        
        System.debug('Case object describe: ' + caseDescribe);
    }
    
    /**
     * ANTIPATTERN #5: SObject Map in Loop
     * Problem: Building Map<Id, SObject> in loops adds unnecessary CPU overhead
     * Solution: Use Map constructor or putAll() method for efficient map creation
     */
    public void sObjectMapInLoopAntipattern() {
        // Check CRUD permissions
        if (!Schema.sObjectType.Account.isAccessible()) {
            return;
        }
        
        // ANTIPATTERN: Manually looping to build map
        Map<Id, Account> accountMap = new Map<Id, Account>();
        for (Account acc : [SELECT Id, Name FROM Account LIMIT 100]) {
            accountMap.put(acc.Id, acc);
        }
        
        System.debug('Account map size: ' + accountMap.size());
    }
    
    // ==============================================
    // SOQL ANTIPATTERNS
    // ==============================================
    
    /**
     * ANTIPATTERN #6: SOQL in Loop
     * Problem: SOQL queries in loops can hit governor limits (100 SOQL queries)
     * Solution: Batch SOQL queries outside of loops
     */
    public void soqlInLoopAntipattern() {
        // Check CRUD permissions
        if (!Schema.sObjectType.Account.isAccessible()) {
            return;
        }
        
        String someValue = 'Test Account';
        
        // ANTIPATTERN: SOQL query inside the loop (intentional antipattern example)
        for (Integer i = 0; i < 10; i++) {
            List<Account> accounts = [SELECT Id FROM Account WHERE Name = :someValue LIMIT 1];
            // This SOQL in loop is intentionally demonstrating the antipattern
        }
    }
    
    /**
     * ANTIPATTERN #7: SOQL in Loop (One Hop)
     * Problem: SOQL queries across class boundaries in loops still hit limits
     * Solution: Refactor to batch queries even across multiple classes
     */
    public void soqlInLoopOneHopAntipattern() {
        // Check CRUD permissions
        if (!Schema.sObjectType.Account.isAccessible() || !Schema.sObjectType.Contact.isAccessible()) {
            return;
        }
        
        List<Account> accounts = [SELECT Id FROM Account LIMIT 10];
        
        // ANTIPATTERN: Loop calling method with SOQL
        for (Account acc : accounts) {
            List<Contact> contacts = getContactsForAccount(acc.Id); // SOQL in called method
        }
    }
    
    /**
     * ANTIPATTERN #8: SOQL with Apex Filter
     * Problem: Filtering in Apex retrieves unnecessary data and increases resource usage
     * Solution: Apply filters directly in SOQL using WHERE clauses
     */
    public void soqlWithApexFilterAntipattern() {
        // Check CRUD permissions
        if (!Schema.sObjectType.Account.isAccessible()) {
            return;
        }
        
        // ANTIPATTERN: Query all records then filter in Apex
        List<Account> allAccounts = [SELECT Id, Name, Industry FROM Account];
        
        List<Account> techAccounts = new List<Account>();
        for (Account acc : allAccounts) {
            if (acc.Industry == 'Technology') {
                techAccounts.add(acc);
            }
        }
    }
    
    /**
     * ANTIPATTERN #9: SOQL with Negative Expressions
     * Problem: Negative expressions (NOT IN, !=) don't index effectively, causing full-table scans
     * Solution: Use positive expressions wherever possible
     */
    public void soqlWithNegativeExpressionsAntipattern() {
        // Check CRUD permissions
        if (!Schema.sObjectType.Opportunity.isAccessible()) {
            return;
        }
        
        // ANTIPATTERN: Using NOT IN expression which doesn't index effectively
        List<Opportunity> openOpps = [
            SELECT Id FROM Opportunity 
            WHERE StageName NOT IN ('Closed Won', 'Closed Lost')
        ];
    }
    
    /**
     * ANTIPATTERN #10: SOQL with SObject List
     * Problem: Using SObject lists for IN binds increases CPU usage and can exceed query limits
     * Solution: Use lists of IDs instead of SObjects for IN binds
     */
    public void soqlWithSObjectListAntipattern() {
        // Check CRUD permissions
        if (!Schema.sObjectType.Account.isAccessible()) {
            return;
        }
        
        List<Account> accounts = [SELECT Id FROM Account LIMIT 100];
        
        // ANTIPATTERN: Using SObject list for IN bind to ID field
        List<Task> tasks = [SELECT Id FROM Task WHERE WhatId IN :accounts];
    }
    
    /**
     * ANTIPATTERN #11: SOQL with Unused Fields
     * Problem: Retrieving unused fields increases overhead and resource consumption
     * Solution: Only include fields directly required by your logic
     */
    public void soqlWithUnusedFieldsAntipattern() {
        // Check CRUD permissions
        if (!Schema.sObjectType.Account.isAccessible()) {
            return;
        }
        
        // ANTIPATTERN: Retrieving many unused fields
        List<Account> accounts = [
            SELECT Id, Name, Industry, Type, BillingCity, BillingState, 
                   ShippingCity, ShippingState, Phone, Fax, Website, 
                   Description, AnnualRevenue, NumberOfEmployees
            FROM Account 
            WHERE Industry = 'Technology'
        ];
        
        // Only using Name in the logic
        for (Account acc : accounts) {
            System.debug('Account: ' + acc.Name);
            // All other fields are unused
        }
    }
    
    /**
     * ANTIPATTERN #12: SOQL with Wildcard Filter
     * Problem: Wildcard filters prevent index usage and cause full-table scans
     * Solution: Use indexed fields and optimized search strategies
     */
    public void soqlWithWildcardFilterAntipattern() {
        // Check CRUD permissions
        if (!Schema.sObjectType.Contact.isAccessible()) {
            return;
        }
        
        // ANTIPATTERN: Using wildcard filter which prevents index usage
        List<Contact> contacts = [
            SELECT Id, LastName, FirstName 
            FROM Contact 
            WHERE LastName LIKE '%smith%'
        ];
    }
    
    /**
     * ANTIPATTERN #13: SOQL without WHERE or LIMIT
     * Problem: Queries without filtering can retrieve too many records and hit governor limits
     * Solution: Include WHERE clauses or LIMIT statements to restrict data
     */
    public void soqlWithoutWhereOrLimitAntipattern() {
        // Check CRUD permissions
        if (!Schema.sObjectType.Account.isAccessible()) {
            return;
        }
        
        // ANTIPATTERN: No WHERE clause or LIMIT statement (intentional antipattern example)
        List<Account> allAccounts = [SELECT Id, Name FROM Account];
    }
    
    /**
     * ANTIPATTERN #14: Sorting in Apex
     * Problem: Sorting records in Apex uses more CPU time and can exceed governor limits
     * Solution: Use ORDER BY clause in SOQL to delegate sorting to database
     */
    public void sortingInApexAntipattern() {
        // Check CRUD permissions
        if (!Schema.sObjectType.Contact.isAccessible()) {
            return;
        }
        
        // ANTIPATTERN: Query without ORDER BY, then sort in Apex
        List<Contact> contacts = [SELECT Id, FirstName, LastName FROM Contact LIMIT 100];
        
        // CPU-intensive sorting in Apex
        contacts.sort();
    }
    
    // ==============================================
    // TEST ANTIPATTERNS
    // ==============================================
    
    /**
     * ANTIPATTERN #15: testMethod Keyword
     * Problem: testMethod syntax is outdated and may not be properly recognized
     * Solution: Use @isTest annotation for modern test methods
     */
    static testMethod void testMethodKeywordAntipattern() {
        // ANTIPATTERN: Using legacy testMethod keyword
        String result = 'test';
        System.assertEquals('test', result, 'Basic test with legacy syntax');
    }
    
    /**
     * ANTIPATTERN #16: Filler Statements
     * Problem: Meaningless code to inflate test coverage undermines code quality
     * Solution: Write meaningful tests that validate actual business logic
     */
    public static void FillerStatementsAntipattern() {

        //Filler code
        String str1 = 'Placeholder ';
        String str2 = 'Code';
        String result = str1 + str2;
        assertEquals('Placeholder Code', result);

        Boolean success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;
        success = False;
        success = True;

        System.debug('Alternating repeating lines. Currently detected.');
    }
    
    // ==============================================
    // HELPER METHODS AND CLASSES
    // ==============================================
    
    /**
     * Helper method for SOQL in Loop One Hop antipattern
     */
    private static List<Contact> getContactsForAccount(Id accountId) {
        // Check CRUD permissions
        if (!Schema.sObjectType.Contact.isAccessible()) {
            return new List<Contact>();
        }
        
        return [SELECT Id, Name FROM Contact WHERE AccountId = :accountId LIMIT 5];
    }
    
    /**
     * Sample Queueable class for Busy Loop Delay antipattern
     */
    public class SampleQueueableJob implements Queueable {
        public void execute(QueueableContext context) {
            System.debug('Sample queueable job executed');
        }
    }
    
    // ==============================================
    // ANTIPATTERN DETECTION SUMMARY
    // ==============================================
    
    /**
     * Educational method showing all antipatterns at a glance
     * This method demonstrates what to look for when reviewing code
     */
    @isTest
    static void antipatternDetectionGuide() {
        System.debug('=== ApexGuru Antipattern Detection Guide ===');
        System.debug('');
        System.debug('PERFORMANCE ANTIPATTERNS:');
        System.debug('1. Busy Loop Delay: while (System.now() < endTime) loops');
        System.debug('2. Copying List Elements: for loops instead of addAll()');
        System.debug('3. DML in Loop: insert/update/delete inside loops');
        System.debug('4. Schema.getGlobalDescribe(): for single SObject metadata');
        System.debug('5. SObject Map in Loop: manual map.put() in loops');
        System.debug('');
        System.debug('SOQL ANTIPATTERNS:');
        System.debug('6. SOQL in Loop: SOQL queries inside loops');
        System.debug('7. SOQL in Loop (One Hop): SOQL across classes in loops');
        System.debug('8. SOQL with Apex Filter: filtering in Apex vs WHERE');
        System.debug('9. SOQL with Negative Expressions: NOT IN, != operators');
        System.debug('10. SOQL with SObject List: SObject lists in IN binds');
        System.debug('11. SOQL with Unused Fields: selecting unused fields');
        System.debug('12. SOQL with Wildcard Filter: LIKE patterns with %');
        System.debug('13. SOQL without WHERE/LIMIT: unfiltered queries');
        System.debug('14. Sorting in Apex: .sort() vs ORDER BY');
        System.debug('');
        System.debug('TEST ANTIPATTERNS:');
        System.debug('15. testMethod Keyword: legacy test syntax');
        System.debug('16. Filler Statements: meaningless test code');
        System.debug('');
        System.debug('DETECTION TIPS:');
        System.debug('- Look for loops containing SOQL, DML, or complex operations');
        System.debug('- Check for queries without WHERE clauses or LIMIT statements');
        System.debug('- Review test methods for meaningful business logic validation');
        System.debug('- Identify performance bottlenecks in data processing');
        System.debug('- Use static analysis tools and code reviews');
        
        System.assert(true, 'Detection guide provides educational value');
    }
    
    /**
     * Method to demonstrate proper patterns (what TO do)
     * This shows the recommended approaches for each antipattern
     */
    @isTest
    static void recommendedPatternsGuide() {
        System.debug('=== Recommended Patterns Guide ===');
        System.debug('');
        System.debug('PERFORMANCE BEST PRACTICES:');
        System.debug('1. Use System.enqueueJob() with delay for timing');
        System.debug('2. Use addAll() method for collection copying');
        System.debug('3. Batch DML operations outside of loops');
        System.debug('4. Use getSObjectType() for single SObject metadata');
        System.debug('5. Use Map constructor or putAll() for map creation');
        System.debug('');
        System.debug('SOQL BEST PRACTICES:');
        System.debug('6. Execute SOQL queries before loops, use maps for lookups');
        System.debug('7. Refactor to batch queries across class boundaries');
        System.debug('8. Use WHERE clauses for filtering in SOQL');
        System.debug('9. Use positive expressions (IN, =) instead of negative');
        System.debug('10. Extract ID lists from SObjects for IN binds');
        System.debug('11. Only select fields required by business logic');
        System.debug('12. Use exact matches or optimized search patterns');
        System.debug('13. Always include WHERE clauses or LIMIT statements');
        System.debug('14. Use ORDER BY clause for database-level sorting');
        System.debug('');
        System.debug('TEST BEST PRACTICES:');
        System.debug('15. Use @isTest annotation for all test methods');
        System.debug('16. Write meaningful tests that validate business logic');
        
        System.assert(true, 'Best practices guide provides educational value');
    }
}