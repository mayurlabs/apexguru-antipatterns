/**
 * ApexGuru Antipattern Example: Copying List or Set Elements Using a For Loop
 * 
 * This class demonstrates the anti-pattern of using for loops to copy elements
 * from one collection to another. Using a For loop to copy parts of a list or set
 * takes more CPU time and can cause governor limit breaches, especially with large datasets.
 * 
 * Instead, Apex provides the addAll() method to copy elements efficiently in a single
 * operation, improving both performance and code clarity.
 */
public class CopyingListElementsAntipattern {
    
    /**
     * ANTI-PATTERN: Copying Set elements using for loop
     * This is the exact example from the anti-pattern description
     */
    public void copySetElementsAntiPattern() {
        Set<Id> attachmentPresentIdsCassic = new Set<Id>();
        Set<Id> attachmentPresentIds = new Set<Id>();
        
        // Populate the source set with some IDs
        attachmentPresentIdsCassic.add('001000000000001');
        attachmentPresentIdsCassic.add('001000000000002');
        attachmentPresentIdsCassic.add('001000000000003');
        
        // ANTI-PATTERN: Manually iterating to copy each Id
        // This takes more CPU time and can cause governor limit breaches
        for (Id ids : attachmentPresentIdsCassic) {
            attachmentPresentIds.add(ids);
        }
        
        System.debug('Copied IDs: ' + attachmentPresentIds);
    }
    
    /**
     * ANTI-PATTERN: Copying List elements using for loop
     */
    public void copyListElementsAntiPattern() {
        List<String> sourceList = new List<String>{'Apple', 'Banana', 'Cherry', 'Date'};
        List<String> targetList = new List<String>();
        
        // ANTI-PATTERN: Manually iterating to copy each element
        for (String item : sourceList) {
            targetList.add(item);
        }
        
        System.debug('Copied list: ' + targetList);
    }
    
    /**
     * ANTI-PATTERN: Copying Set to List using for loop
     */
    public void copySetToListAntiPattern() {
        Set<String> uniqueNames = new Set<String>{'John', 'Jane', 'Bob', 'Alice'};
        List<String> nameList = new List<String>();
        
        // ANTI-PATTERN: Manual iteration to convert Set to List
        for (String name : uniqueNames) {
            nameList.add(name);
        }
        
        System.debug('Name list: ' + nameList);
    }
} 