#Postmorterm

Postmortem: Web Stack Outage Incident

Issue Summary:
 Duration: Start Time: October 14, 2023, 10:00 AM (EAT) | End Time: October 14, 2023, 1:30 PM (EAT)
 Impact: The outage resulted in a disruption of services due to 500 Internal Server Errors encountered by users attempting to access the Holberton WordPress site via GET requests. This issue affected 100% of the user base during the outage period.

Timeline:
 Detection Time: October 14, 2023, 10:00 AM (EAT)
 Detection Method: An engineer noticed a surge in error reports and user complaints regarding inability to access the WordPress site. Manual investigation confirmed widespread 500 Internal Server Errors.
 Actions Taken: The engineering team initiated a thorough analysis, inspecting running processes, Apache configurations, and server logs. Initial attempts with strace on the root Apache process provided no useful information. Subsequent strace on the wwwdata process revealed an 1 ENOENT (No such file or directory) error while attempting to access the file /var/www/html/wpincludes/classwplocale.phpp.
 Misleading Paths: Initial investigations into running processes and Apache configurations did not yield significant insights. Strace on the root Apache process did not provide any useful information, leading to further exploration with strace on the wwwdata process, which finally pinpointed the issue.
 Escalation: The incident was escalated to the senior engineering team and database administrators when initial investigations failed to identify the root cause.
 Resolution: The root cause was traced to a corrupted file reference in the wpsettings.php file. A trailing 'p' in the file extension (.phpp) caused the 500 Internal Server Errors. The erroneous character was removed, resolving the issue and restoring expected HTML responses.

Root Cause and Resolution:
 Root Cause: A corrupted file reference in the wpsettings.php file led to the 500 Internal Server Errors. The incorrect file extension (.phpp) caused the server to fail when attempting to access the classwplocale.php file.
 Resolution: The erroneous 'p' character in the file extension was removed from the wpsettings.php file, correcting the file reference. Subsequent tests confirmed the restoration of expected HTML responses, resolving the issue.

Corrective and Preventative Measures:
 Improvements/Fixes:
  1. Automated Error Checking: Implement automated scripts to periodically check file references and configurations, alerting for discrepancies.
  2. Enhanced Debugging Tools: Invest in advanced debugging tools that provide detailed insights into file access and execution paths during runtime.
  3. Code Review Protocols: Establish rigorous code review protocols to catch and rectify potential syntax and configuration errors before deployment.

 Tasks:
  1. Automated Error Checking Implementation: Develop and deploy scripts to automatically verify file references and configurations, alerting the team for any inconsistencies.
  2. Debugging Tool Integration: Integrate advanced debugging tools into the development and testing environments, enabling engineers to gain deep insights into code execution paths and file accesses.
  3. Code Review Guidelines: Establish comprehensive code review guidelines, emphasizing thorough checks for syntax errors, file references, and configurations before any code deployment.

Additionally, a Puppet manifest was created to automate the correction of this specific error, ensuring rapid resolution in case of similar incidents in the future. By implementing these measures, we aim to enhance our system's resilience and minimize the risk of similar incidents.

