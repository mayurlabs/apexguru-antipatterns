/**
 * ApexGuru Antipattern Example: SOQL with Apex Filter
 * 
 * This class demonstrates the anti-pattern of executing SOQL queries without a WHERE clause
 * or LIMIT statement and filtering them in Apex. This process retrieves unnecessary data,
 * increases memory and CPU usage, and can lead to overall system performance and governor
 * limit issues.
 * 
 * To minimize data volume and improve query efficiency, avoid postprocessing and filtering
 * in Apex. Apply filters directly in the SOQL query using WHERE clauses and restrict
 * results using LIMIT statements.
 */
public class SOQLWithApexFilterAntipattern {
    
    /**
     * ANTI-PATTERN: SOQL without WHERE clause and Apex filtering
     * This is the exact example from the anti-pattern description
     */
    public void soqlWithApexFilterAntiPattern() {
        List<Custom_Object__c> records = [
            SELECT Id, Name, Category__c, Amount__c, Status__c, 
                Priority__c, Type__c 
            FROM Custom_Object__c
        ];
        
        // ANTI-PATTERN: Filtering in Apex instead of SOQL WHERE clause
        // This retrieves unnecessary data and increases memory and CPU usage
        List<Custom_Object__c> filteredRecords = new List<Custom_Object__c>();
        for (Custom_Object__c record : records) {
            if (record.Status__c == 'Open' || record.Status__c == 'Pending') {
                filteredRecords.add(record);
            }
        }
    }
} 