/**
 * ApexGuru Antipattern Example: Aggregating Records in Apex
 * 
 * This class demonstrates the anti-pattern of manually computing aggregate functions in Apex
 * instead of using SOQL's built-in aggregate functions. This approach wastes CPU resources
 * and results in bloated, less readable code that's harder to maintain.
 * 
 * Instead, use SOQL's built-in aggregate functions like SUM(), AVG(), COUNT(), and 
 * COUNT_DISTINCT() to perform the work at the database level.
 */
public class AggregatingRecordsInApexAntipattern {
    
    /**
     * ANTI-PATTERN: Manually aggregating records in Apex
     * Should use SOQL aggregate functions like SUM() instead
     */
    public void aggregatingRecordsInApexAntiPattern() {
        // ANTI-PATTERN: Manual aggregation in Apex instead of SOQL SUM()
        List<Opportunity> opportunities = [SELECT Id, Amount FROM Opportunity LIMIT 100];
        Decimal sum = 0;
        for (Opportunity opp : opportunities) {
            sum += opp.Amount;
        }
    }
}