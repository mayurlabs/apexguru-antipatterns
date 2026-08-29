/**
 * ApexGuru Test Case Antipattern: Using the testMethod Keyword
 * 
 * This class demonstrates the antipattern of using the outdated testMethod keyword
 * instead of modern @isTest annotations for test classes and methods.
 * 
 * PROBLEM:
 * - testMethod syntax is legacy and outdated
 * - May not be properly recognized by some deployment tools
 * - Inconsistent with modern Salesforce development standards
 * - Can cause issues with test execution and code coverage reporting
 * - Deprecated syntax that may be removed in future API versions
 * 
 * IMPACT:
 * - Reduced confidence in test suite reliability
 * - Potential deployment quality issues
 * - Inconsistent test execution behavior
 * - Code maintainability problems
 * - Non-compliance with Salesforce best practices
 * 
 * RECOMMENDATION:
 * Always use @isTest annotation for test classes and methods
 * Follow modern Salesforce testing standards and conventions
 */
public with sharing class TestMethodKeywordAntipattern {
    
    // ==============================================
    // ANTIPATTERN EXAMPLES (What NOT to do)
    // ==============================================
    
    /**
     * ANTIPATTERN: Using testMethod keyword for simple test
     * This legacy syntax should be avoided
     */
    static testMethod void simpleTestAntipattern() {
        // Legacy test method syntax - ANTIPATTERN
        System.debug('This test uses deprecated testMethod keyword');
        
        // Simple test logic
        String result = 'test';
        System.assertEquals('test', result, 'Simple assertion failed');
    }
    
    /**
     * ANTIPATTERN: Using testMethod for DML operations test
     * Even with complex logic, testMethod should not be used
     */
    static testMethod void dmlTestAntipattern() {
        // Check CRUD permissions
        if (!Schema.sObjectType.Account.isCreateable()) {
            return;
        }
        
        // Create test data
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
        
        // Verify creation
        Account retrievedAccount = [SELECT Id, Name FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals('Test Account', retrievedAccount.Name, 'Account name mismatch');
    }
    
    /**
     * RECOMMENDED: Using @isTest annotation for simple test
     * Modern, standard approach for test methods
     */
    @isTest
    static void simpleTestRecommended() {
        // Modern test method syntax - RECOMMENDED
        System.debug('This test uses modern @isTest annotation');
        
        // Simple test logic
        String result = 'test';
        System.assertEquals('test', result, 'Simple assertion failed');
    }
    
    /**
     * RECOMMENDED: Using @isTest for DML operations test
     * Modern syntax with proper test data creation
     */
    @isTest
    static void dmlTestRecommended() {
        // Check CRUD permissions
        if (!Schema.sObjectType.Account.isCreateable()) {
            return;
        }
        
        // Create test data
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
        
        // Verify creation
        Account retrievedAccount = [SELECT Id, Name FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals('Test Account', retrievedAccount.Name, 'Account name mismatch');
    }
}