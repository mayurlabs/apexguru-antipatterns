/**
 * ApexGuru Antipattern Example: SOQL with Negative Expressions
 * 
 * This class demonstrates the anti-pattern of using negative expressions in SOQL queries
 * such as NOT IN or !=. These expressions don't index effectively, leading to full-table
 * scans. Less-efficient database operations increase query time and CPU usage.
 * 
 * Avoid negative expressions. Use positive expressions wherever possible.
 */
public class SOQLWithNegativeExpressionsAntipattern {
    
    /**
     * ANTI-PATTERN: Using NOT IN expression
     * This is the exact example from the anti-pattern description
     */
    public void soqlWithNotInAntiPattern() {
        // ANTI-PATTERN: Using NOT IN expression which doesn't index effectively
        List<Opportunity> opps = [
            SELECT Id FROM Opportunity 
            WHERE StageName NOT IN ('Closed Won', 'Closed Lost')
        ];
    }
    
    /**
     * ANTI-PATTERN: Using != expression for StageName
     */
    public void soqlWithNotEqualsStageAntiPattern() {
        // ANTI-PATTERN: Using != expression which doesn't index effectively
        List<Opportunity> opps = [
            SELECT Id, Name, Amount, StageName 
            FROM Opportunity 
            WHERE StageName != 'Closed Won'
        ];
    }
} 