
// if user has types something @KBD if no key is being pressed its 0
// loop while value is 0
// take value and put it in d register and then put in memory later
// R0 is going to be where we put the answer to whether or not the word is a palindrome true = -1
// false = 0

//R0 answer
//R1 temp char Read
//R2 Number of characters read
//R3
//R4
//R5 first char Read
//R6 2nd char read
//R7 3rd char read

@R4
D=M
M=1


//Making R2 -1 because later on we are incrementing before we use it

//Reading if the key is zero, reread again. Loop until a key is pressed
(START) // A=0          D=0
@KBD    // A=KBD        D=0
D=M     // A=KBD        D=M[KBD]
@START  // A=(Start)    D=M[KBD]
D;JEQ   // A=(Start)    D=M[KBD] Jump if the D is zero, GOTO @Start

//Store the D register somewhere in memory
@R1     // A=R1         D=M[KBD]
M=D     // A=R1         D=M[KBD]    M[R1]=M[KBD] <-- key pressed

//Check if the KBD value is 128(return) if it is go to (CHECK_PALINDROME)
@128                // A=128                    D=M[KBD]
D=D-A               // A=128                    D=M[KBD]-128 <-- (key pressed - 128)
@CHECK_PALINDROME   // A=(CHECK_PALINDROME)     
D;JEQ               // A=(CHECK_PALINDROME)     D=M[KBD]-128 <-- (key pressed - 128) Jump if zero


//Make sure the key isn't being held down
(START2)            
@KBD                //A=KBD
D=M                 //A=KBD         D=M[KBD] <-- key pressed
@START2             //A=(START2)    D=M[KBD]
D;JNE               //Jump if they key has been released


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

@START
0;JMP


// // Increment R4
// @R4         //A=R4
// D=M         //A=R4 D=M[R4]
// M=D+1       //A=R4 D=M[R4] M[R4] = M[R4] + 1
// // Increment R4

(CHECK_PALINDROME)
// Must store value of addition of M[R4] + 6 in R5
@R4             // A=R4         <-- location of first char
D=M             // A=R4     D=M[R4] <--- offset of first char
@R5             // A=R6     D=M[R4]
M=D+A           // A=M[R6 + M[R4]]  D=M[R4] <-- (first) character 

// Check if R3 = R5, end successful
@R3
D=M
@R5
A=M
D=D-A
@SUCCESS
D;JEQ

// Setup D=D-A to check if they are zero, and we will jump if it is (w/ label)
@R3             // A=R3         <-- location of last character
D=M             // A=R3     D=M[R3]     <-- last character index (ABBA 9)
A=D             // A=M[R3]  D=M[R3] <-- last character char
D=M             // D[M[R3]]= M[R3]
// the above will get last character in D is working

// Get index of first character
@R5             // A=R4         <-- location of first char
A=M             // A=R4     D=M[R4] <--- offset of first char
A=M

// Check M[KBD+1] with M[R3] or first character and last 
D=D-A
@SETUP_NEXT_CHAR
D;JEQ

// Not Equal, Fail
@R0
D=M-1
@R0
M=D
(FAIL)
@33
@FAIL
0;JMP

(SUCCESS)
@77
@SUCCESS
0;JMP

// (CHECK_PALINDROME)
// @CHECK_PALINDROME
// 0;JMP

(SETUP_NEXT_CHAR)

// Check if R5 < R3, end successful
@R3
D=M
@R5
A=M
D=D-A
@SUCCESS
D;JLE

// Increment R4
@R4         //A=R4
D=M         //A=R4 D=M[R4]
M=D+1       //A=R4 D=M[R4] M[R4] = M[R4] + 1
// Increment R4

@R3         //A=R3
D=M         //A=R3 D=M[R3]
M=D-1       //A=R3 D=M[R3] M[R3] = M[R3] - 1
@CHECK_PALINDROME
0;JEQ

@SETUP_NEXT_CHAR
0;JMP


(TEST)
@22
@TEST
0;JMP





//R4 = last letter where the char is (5+R2)
//R3 = pointer to the first letter (5)
//subtract them @R4 D=M @R3 D=M-D D;JEQ(then increment R3 and decrement R4)
//(Exit) @Exit 0;JMP (When you have the answer)
//Either R3 and R4 is equal then were done, or the R3 and R4 pass each other(@R3 D=M @R4 D=D-M @IS_PALINDROME D;JGE)


// // start at negative one
// // @R2
// // M=-1

// (START)
// @KBD
// D=M
// @START
// D;JEQ


// @R1 //Store keyboard code
// M=D // In memory

// (START2) // Wait for user to letup pressing the key
// @KBD
// D=M
// @START2
// D;JNE // Wait for user to stop pressing key

// @START3
// (START3)
// @R2
// MD=M+1
// @5
// D=D+A
// @R3
// M=D
// @R1
// D=M
// @R3
// A=M
// M=D

// @START
// 0;JMP


// TODO: 0;JMP to below code. We need label 
// TODO or if they don't hit RETURN. Go somewhere else (not below code). Go back to user input code


// @R2
// //D=M // one operation
// MD=M+1 // double operation (1) increment number of characters
// @5 // Constant value
// D=D+A // 0+5. 
// @R3
// M=D 
// @R1
// D=M

// // Get R3 into permanent memory 
// @R3
// A=M
// M=D

// Set R3 to first
// Set R4 to last

// Do logic subtract R4-R3. if they are equal aka 0
// Increment R3, Decriment R4
// Check if equal... Continue
// If they are ever not 0. Then they are not equal
// Set R0 to 0
// Exit infinitely to finish program
//(Exit)
//@Exit
//0;JMP
// If R4 and R3 have converged 
// Or if the R3

// Example 
// @R3
// D=MD
// @R4
// D=D-MD
// @IS_PALINDROME
// D;JGE // They have passed the comparison. Aka crossed

// Increment number of characters read
// Moved to (1)
//@R2
//M=M+1

//R0 will be answer -1 for palindrom 0 for no palindrom
//R1 will be temporary character read
//R2 will be number of characters read
//R3 Where to put the character just read
//R4
//R5 first character read
//R6 second character read