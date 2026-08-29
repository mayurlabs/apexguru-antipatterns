/**
 * Demo: a new feature class added via a pull request.
 * FIXED: moved the SOQL query outside the loop (bulkified) after ApexGuru flagged
 * the original version's SOQL-in-loop antipattern on this same pull request.
 */
public class NewFeatureWithSoqlInLoop {

    public void processAccounts(List<String> accountNames) {
        // FIX: single bulkified query outside the loop, instead of one query per iteration
        List<Account> accounts = [SELECT Id, Name FROM Account WHERE Name IN :accountNames];
    }
}
