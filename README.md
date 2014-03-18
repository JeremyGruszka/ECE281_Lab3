ECE281_Lab3
===========

##Lab3

#### Prelab Schematic Drawing

![alt text](https://raw.github.com/JeremyGruszka/ECE281_Lab3/master/schematic1.png "Schematic")


#### Debugging
1. got everything hooked up right i think
2. my board says 4321, need to fix that
3. realize that I need to hook up the floor variable to the nibble0
4. now board says 000floor#.  floors go up and down and reset as i have wired it. time to move onto B functionality part
5. I'm creating a second floor variable to be held in nibble1
6. create it, syntax is good, but board will only count the first 4 primary numbers
7. realized I forgot to change the next state logic on my elevator controller component
8. it worked, got the prime number functionality. now to work on the 3 input functionality
9. decided to change my program so it ran using only 1 floor variable, prime numbers still work
