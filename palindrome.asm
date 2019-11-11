
// Assignment 6
// Trent (Will) Hughes
// ID: 113392078

//R0 Answer (-1 for true, 0 for false)
//R1 Temp char read
//R2 Number of chars read
//R3 Index of last char being compared
//R4 Offset of first char being compared
//R5 Index of first char being compared
//R6 2nd char read
//R7 3rd char read

// Setup offset to 1 to initialize R5
// R5 will be values in R5 + R4 (offset)
@R4
D=M
M=1

//Loop until key is pressed
(START) // A=0          D=0
@KBD    // A=KBD        D=0
D=M     // A=KBD        D=M[KBD]
@START  // A=(Start)    D=M[KBD]
D;JEQ   // A=(Start)    D=M[KBD] Jump if the D is zero, GOTO @Start

//Store the key pressed
@R1     // A=R1         D=M[KBD]
M=D     // A=R1         D=M[KBD]    M[R1]=M[KBD] <-- key pressed

//Check if the KBD value is 128(return) if it is go to (CHECK_PALINDROME)
@128                // A=128                    D=M[KBD]
D=D-A               // A=128                    D=M[KBD]-128 <-- (key pressed - 128)
@CHECK_PALINDROME   // A=(CHECK_PALINDROME)     
D;JEQ               // A=(CHECK_PALINDROME)     D=M[KBD]-128 <-- (key pressed - 128) Jump if zero

//Check if key is still being pressed
//Loop until released
(START2)            
@KBD                //A=KBD
D=M                 //A=KBD         D=M[KBD] <-- key pressed
@START2             //A=(START2)    D=M[KBD]
D;JNE               //Jump if key released

//Find index of memory to put the character
//Store the char at that index
//Increment number of characters read
@START3             //A=(START3)    D=M[KBD]
0;JMP              
(START3)
@R2                 //A=R2
MD=M+1              //A=R2  D=(M[KBD] + 1)   M[R2]=(M[KBD] + 1) <-- +1 means we have read another character [R2 is number of characters read]
@5                  //A=5   D=(M[KBD] + 1)   M[R2]=(M[KBD] + 1)
D=D+A               //A=5   D={(M[KBD] + 1) + 5} <-- trying to get character into R5
@R3                 //A=R3 <-- R3 is where to put the next character
M=D                 //A=R3  D={(M[KBD] + 1) + 5} M[R3]={(M[KBD] + 1) + 5}
@R1                 //A=R1  <-- R1 is temp character pressed
D=M                 //A=R1  D=M[R1]
@R3                 //A=R3
A=M                 //A=M[R3] or A=M[KBD] + 6 <-- the next characters location
M=D                 //M[KBD] + 6=M[R1] <-- We're putting temp character into it's location in memory

//Return to beginning to get another character read in
@START
0;JMP

(CHECK_PALINDROME)
// Must store value of addition of M[R4] + 6 in R5
@R4             // A=R4         <-- location of first char
D=M             // A=R4     D=M[R4] <--- offset of first char
@R5             // A=R6     D=M[R4]
M=D+A           // A=M[R6 + M[R4]]  D=M[R4] <-- (first) character 

// Check if R3 = R5, end successful
// Checks if indices are equal. 
// If so, we have succussfully read/compared all characters
@R3
D=M
@R5
A=M
D=D-A
@SUCCESS
D;JEQ

// Setup D register with last character for first/last char comparison (D=D-A)
@R3             // A=R3         <-- location of last character
D=M             // A=R3     D=M[R3]     <-- last character index (ABBA 9)
A=D             // A=M[R3]  D=M[R3] <-- last character char
D=M             // D[M[R3]]= M[R3]

// Setup A register with first char
@R5             // A=R4         <-- location of first char
A=M             // A=R4     D=M[R4] <--- offset of first char
A=M

// Check if last - first char equals 0
// If it is, then it is equal. Continue... to setup next char and check next chars
// If not, end program
D=D-A
@SETUP_NEXT_CHAR
D;JEQ

// Not Equal, Fail. Loop forever
(FAIL)
@FAIL
0;JMP

// Is palindrom, set result to -1
// And then loop forever, doing nothing
(SUCCESS)
@R0
D=M-1
@R0
M=D
@STOP
0;JMP

(STOP)
@STOP
0;JMP


(SETUP_NEXT_CHAR)

// Check if R5 > R3, end successful
// EVEN case where R5(index of first char) > R3(index of last char)
@R3
D=M
@R5
A=M
D=D-A
@SUCCESS
D;JLE

// Increment R4 (first char offset)
@R4         //A=R4
D=M         //A=R4 D=M[R4]
M=D+1       //A=R4 D=M[R4] M[R4] = M[R4] + 1
// Increment R4

// Decrement R3 (last char index)
@R3         //A=R3
D=M         //A=R3 D=M[R3]
M=D-1       //A=R3 D=M[R3] M[R3] = M[R3] - 1
@CHECK_PALINDROME
0;JEQ

@SETUP_NEXT_CHAR
0;JMP