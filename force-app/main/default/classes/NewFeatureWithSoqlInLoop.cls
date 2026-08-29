/**
 * Demo: a new feature class added via a pull request.
 * Introduces a fresh SOQL-in-loop antipattern to demonstrate ApexGuru catching
 * a problem in NEW code, right on the pull request, before it merges.
 */
public class NewFeatureWithSoqlInLoop {

    public void processAccounts(List<String> accountNames) {
        for (String name : accountNames) {
            // ANTIPATTERN: SOQL query inside the loop
            List<Account> accounts = [SELECT Id, Name FROM Account WHERE Name = :name];
        }
    }
}
