/**
 * ApexGuru Antipattern Example: Redundant SOQL
 * 
 * This class demonstrates the anti-pattern of having redundant SOQL queries.
 * Instead, use a single SOQL query to get all the data you need.
 */
public class RedundantSOQLDatabaseService {
    
    Boolean validatePortalUsers(Contact masterContact, Contact childContact) {

        User[] masterPortalUserArr = [
            SELECT Id
            FROM User
            WHERE IsPortalEnabled = TRUE AND ContactId = :masterContact.id
        ];
        User[] childPortalUserArr = [
            SELECT Id
            FROM User
            WHERE IsPortalEnabled = TRUE AND ContactId = :childContact.id
        ];

        User masterPortalUser = masterPortalUserArr.size() > 0 ? masterPortalUserArr[0] : null;
        User childPortalUser = childPortalUserArr.size() > 0 ? childPortalUserArr[0] : null;

        if (masterPortalUser != null && childPortalUser != null) {
            return True;
        }
        return False;
        
    }

}
