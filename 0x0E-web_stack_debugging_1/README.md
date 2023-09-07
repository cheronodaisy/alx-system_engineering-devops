#0x0E. Web stack debugging #1
The folllowing are some debugging tips that I learned from this project:
Machine
Debugging is pretty much about verifying assumptions, in a perfect world the software or system we are working on would be working perfectly, the server is in perfect shape and everybody is happy. But actually, it NEVER goes this way, things ALWAYS fail (it’s tremendous!).

For the machine level, you want to ask yourself these questions:

Does the server have free disk space? - df
Is the server able to keep up with CPU load? - w, top, ps
Does the server have available memory? free
Are the server disk(s) able to keep up with read/write IO? - htop
If the answer is no for any of these questions, then that might be the reason why things are not going as expected. There are often 3 ways of solving the issue:

free up resources (stop process(es) or reduce their resource consumption)
increase the machine resources (adding memory, CPU, disk space…)
distributing the resource usage to other machines
Network issue
For the machine level, you want to ask yourself these questions:

Does the server have the expected network interfaces and IPs up and running? ifconfig
Does the server listen on the sockets that it is supposed to? netstat (netstat -lpd or netstat -lpn)
Can you connect from the location you want to connect from, to the socket you want to connect to? telnet to the IP + PORT (telnet 8.8.8.8 80)
Does the server have the correct firewall rules? iptables, ufw:
iptables -L
sudo ufw status
Process issue
If a piece of Software isn’t behaving as expected, it can obviously be because of above reasons… but the good news is that there is more to look into (there is ALWAYS more to look into actually).

Is the software started? init, init.d:
service NAME_OF_THE_SERVICE status
/etc/init.d/NAME_OF_THE_SERVICE status
Is the software process running? pgrep, ps:
pgrep -lf NAME_OF_THE_PROCESS
ps auxf
Is there anything interesting in the logs? look for log files in /var/log/ and tail -f is your friend
