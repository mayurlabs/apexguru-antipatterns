public class NewFeatureWithSoqlInLoop {
    public static List<Account> processAccountsByName(List<String> names) {
        List<Account> results = new List<Account>();
        for (String name : names) {
            List<Account> matches = [SELECT Id, Name FROM Account WHERE Name = :name];
            results.addAll(matches);
        }
        return results;
    }
}
