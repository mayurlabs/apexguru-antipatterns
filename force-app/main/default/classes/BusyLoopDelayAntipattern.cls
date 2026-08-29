/**
 * ApexGuru Antipattern Example: Busy Loop Delay
 * 
 * This class demonstrates the anti-pattern of using busy loops for delays.
 * Busy loops that introduce a delay aren't efficient and lead to performance issues.
 * They waste CPU resources due to continuous loop execution and can cause
 * governor limit breaches that lead to transaction failures.
 * 
 * For delayed execution, use Salesforce alternatives like:
 * - System.schedule() for scheduled jobs
 * - System.enqueueJob() with delay parameter
 * - Queueable jobs with proper timing
 */
public class BusyLoopDelayAntipattern {
    
    /**
     * ANTI-PATTERN: Busy loop delay
     * This method demonstrates the wrong way to implement a delay
     */
    public void scheduleJobWithDelay() {
        Integer delayTime = 10; // Delay in seconds
        DateTime startTime = System.now();
        
        // ANTI-PATTERN: Busy loop to create a delay
        // This wastes CPU resources and can cause governor limit issues
        while (System.now() < startTime.addSeconds(delayTime)) {
            // Do nothing (busy wait)
            // This is inefficient and can cause performance problems
        }
        
        // Enqueue the Queueable job after the delay
        ID jobId = System.enqueueJob(new MyQueueableJob());
        System.debug('Job scheduled with ID: ' + jobId);
    }
    
    /**
     * ANTI-PATTERN: Another example with variable delay
     */
    public void processWithCustomDelay(Integer delaySeconds) {
        if (delaySeconds > 0) {
            DateTime startTime = System.now();
            
            // ANTI-PATTERN: Busy loop with variable delay
            while (System.now() < startTime.addSeconds(delaySeconds)) {
                // Empty loop - wastes CPU cycles
            }
        }
        
        // Process the actual work after delay
        processData();
    }
    
    /**
     * ANTI-PATTERN: Busy loop in a trigger context
     */
    public void triggerWithDelay(List<Account> accounts) {
        // Simulate some processing delay
        DateTime startTime = System.now();
        
        // ANTI-PATTERN: Busy loop in trigger context
        // This is especially problematic in triggers due to governor limits
        while (System.now() < startTime.addSeconds(5)) {
            // Empty loop
        }
        
        // Process accounts after delay
        for (Account acc : accounts) {
            acc.Description = 'Processed with delay: ' + System.now();
        }
    }
    
} 