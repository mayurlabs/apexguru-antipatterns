/**
 * ApexGuru Antipattern Example: Schema.getGlobalDescribe() Not Efficient
 * 
 * This class demonstrates the anti-patterns of using Schema.getGlobalDescribe() inefficiently.
 * These methods cause unnecessary overhead, decrease performance, and increase latency.
 * 
 * Instead, use lightweight alternatives like getSObjectType() or direct field access.
 */
public class SchemaGetGlobalDescribeAntipattern {
    
    /**
     * ANTI-PATTERN 1: Schema.getGlobalDescribe() inside a loop
     * This is extremely inefficient as it calls getGlobalDescribe() multiple times
     */
    public void schemaGetGlobalDescribeInLoop() {
        List<String> objectNames = new List<String>{'Account', 'Contact', 'Opportunity', 'Lead', 'Case'};
        
        // ANTI-PATTERN: Calling Schema.getGlobalDescribe() inside a loop
        // This causes the expensive getGlobalDescribe() operation to be called multiple times
        for (String objectName : objectNames) {
            // ANTI-PATTERN: This is called 5 times in this loop!
            Schema.DescribeSObjectResult dsr = Schema.getGlobalDescribe().get(objectName).getDescribe();
            System.debug('Object ' + objectName + ' label: ' + dsr.getLabel());
        }
    }
    
    /**
     * ANTI-PATTERN 2: Schema.getGlobalDescribe() multiple calls within a class
     * This demonstrates inefficient usage where getGlobalDescribe() is called multiple times
     */
    public void schemaGetGlobalDescribeMultipleCalls() {
        // ANTI-PATTERN: Multiple calls to Schema.getGlobalDescribe() within the same class
        // Each call is expensive and unnecessary
        
        // First call to getGlobalDescribe()
        Schema.DescribeSObjectResult accountDescribe = Schema.getGlobalDescribe().get('Account').getDescribe();
        System.debug('Account describe: ' + accountDescribe);
        
        // Second call to getGlobalDescribe() - inefficient!
        Schema.DescribeSObjectResult contactDescribe = Schema.getGlobalDescribe().get('Contact').getDescribe();
        System.debug('Contact describe: ' + contactDescribe);
        
        // Third call to getGlobalDescribe() - inefficient!
        Schema.DescribeSObjectResult oppDescribe = Schema.getGlobalDescribe().get('Opportunity').getDescribe();
        System.debug('Opportunity describe: ' + oppDescribe);
    }
    
    /**
     * ANTI-PATTERN 3: Schema.getGlobalDescribe() inefficient usage for known SObjects
     * This shows cases where lightweight alternatives should be used instead
     */
    public void schemaGetGlobalDescribeInefficientUsage() {
        // ANTI-PATTERN: Using Schema.getGlobalDescribe() for known SObject types
        // This is inefficient when we know the SObject type at compile time
        
        // ANTI-PATTERN: Should use Account.sObjectType.getDescribe() instead
        Schema.DescribeSObjectResult accountDescribe = Schema.getGlobalDescribe().get('Account').getDescribe();
        
        // ANTI-PATTERN: Should use Contact.sObjectType.getDescribe() instead  
        Schema.DescribeSObjectResult contactDescribe = Schema.getGlobalDescribe().get('Contact').getDescribe();
        
        // ANTI-PATTERN: Should use Case.sObjectType.getDescribe() instead
        Schema.DescribeSObjectResult caseDescribe = Schema.getGlobalDescribe().get('Case').getDescribe();
        
        System.debug('All describes obtained inefficiently');
    }
    
    /**
     * CORRECT APPROACH: Efficient alternatives to Schema.getGlobalDescribe()
     * Demonstrates the lightweight alternatives that should be used instead
     */
    public void schemaGetGlobalDescribeEfficientAlternatives() {
        // CORRECT: Use lightweight getSObjectType() for known SObject types
        Schema.DescribeSObjectResult accountDescribe = Account.sObjectType.getDescribe();
        Schema.DescribeSObjectResult contactDescribe = Contact.sObjectType.getDescribe();
        Schema.DescribeSObjectResult caseDescribe = Case.sObjectType.getDescribe();
        
        // CORRECT: For dynamic object names, cache getGlobalDescribe() result
        Map<String, Schema.SObjectType> globalDescribe = Schema.getGlobalDescribe();
        Schema.DescribeSObjectResult dynamicAccountDescribe = globalDescribe.get('Account').getDescribe();
        Schema.DescribeSObjectResult dynamicContactDescribe = globalDescribe.get('Contact').getDescribe();
        
        // CORRECT: For field describes, use direct field access
        Schema.DescribeFieldResult accountNameField = Account.Name.getDescribe();
        Schema.DescribeFieldResult contactEmailField = Contact.Email.getDescribe();
        
        System.debug('All describes obtained efficiently');
    }
} 