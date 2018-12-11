---
layout: post
title:  "CSCB09 Software Tools and Systems Programming - Shell Programming"
date:   2018-08-07 10:46:00 -0400
tags: cscb09 course-notes
category: cscb09
---

This article is mainly notes I have taken for CSCB09/CSC209 at UofT.

<!--more-->

## File Expansion

This is like a lite version of Regex.

* `*` means zero or more characters.
* `?` means "exactly one character".
* `[x-y]` means range from x to y.
* `[^oa]` means any char but o or a.
* `~` home directory
* `~user` home dir for user

## Program Structure

Scripts usually start with `#!/bin/bash` or `#!/bin/sh`.

Basically, `#!` followed by your script interpreter, not the same on every machine. This will tell the machine how to execute the script.

It is followed by shell commands, anything you can do with the interactive version of it, you can put it into the file.

Note: You must mark the file as executable, use chmod.

Run the program by typing `./script.sh`. The file does not have to end in `.sh`.

## Variables

To assign a variable, use the following syntax

```bash
VAR=value # No space before/after =
```

To get a value, use the following syntax

```bash
$VAR
```

You don't need to declare type, if you try to access a variable that is not assigned, it will just give you an empty string.

For example:

```
zhengj69@mathlab:~$ FOO=test
zhengj69@mathlab:~$ echo $FOO
test
zhengj69@mathlab:~$ echo $bar

zhengj69@mathlab:~$
```

### Built-in Variables

Use `printenv` to see a list of variables that is built-in to your system.

One of the very useful one is `$PATH`. I won't go to details here, since you should know how to use `$PATH`.

### Scopes

Variables defined in script are lost when it ends.

Subshell does not have access to parent shell's variables.

To let subshell access parent shell's variables, you have to `export` it.

```
$ export FOO="test"
$ ./script.sh # script.sh now have access to $FOO
```

To maintain variables after running a script, you have to `source` it.

```
$ source script.sh
$ # parent shell now have access to variables within script.sh
```

## Quotes

Quotes are essential to shell programming. There are three types of quotes:

### `'` Single Quote

Everything within a single quote are literal, for example, if you type `echo '$FOO'`, it will literally output `$FOO`.

### `"` Double Quote

Double quote will expand variables within it, for example the following script:

```bash
#!/bin/sh
FOO="test"
echo "FOO's value is $FOO"
```

It will expand `$FOO` and output `FOO's value is test`.

### `` ` `` Backtick

Backtick will create a new shell process, run the command within it, and store the output value.

For example the following script:

```bash
#!/bin/sh
FOO=`ls -a | grep *.c`
echo "FOO's value is $FOO"
```

It should output all `.c` files within the current directory.

> Note: Since backtick will create a new shell process, avoid it if you can.

## Reading From STDIN

To read from STDIN, we use `read` command.

* It will read 1 line from standard input (keyboard).
* Assign words to specified variables.
* Leftovers will all be assigned to last variable.

Consider the following script

```bash
#!/bin/sh
echo "Please enter two words:"
read FOO BAR
echo "$FOO, $BAR"
```

When you run it and enter `hello world`, you should get the following output

```
zhengj69@mathlab:~$ ./test.sh
Please enter two words:
hello world
hello, world
```

If you enter `hi my name is jun`, you will get the following output

```
zhengj69@mathlab:~$ ./test.sh
Please enter two words:
hi my name is jun
hi, my name is jun
```

## Commandline Arguments

All commandline arguments are placed in `positional paramaters`.

Basically it just means, `$1` is the first argument, `$2` is the second, and so on.

> After `$9`, use curly brackets to wrap the number `${10}`
> `sh` only allows 9 positional arguments, `bash` allows more.

* `$0` is the script name
* `$#` is the number of arguments
* `$*` `$@` will list all arguments

Consider the following script

```bash
#!/bin/sh
echo "The script is called: $0"
echo "First argument is: $1"
echo "Second argument is: $2"
echo "We have $# arguments in total"
echo "All arguments $@"
```

Running it with `./test.sh hello world my name is jun` will have the following output

```
The script is called: ./test.sh
First argument is: hello
Second argument is: world
We have 6 arguments in total
All arguments hello world my name is jun
```

### Arrays

There is only one "array" within bourne shell, which is the positional parameters.

Use the `set` command to assign parameters to positional parameters.

For example:

```bash
set hello world
```

Will set `$1` to `hello`, and `$2` to `world`.

The previous arguments will be lost!

It is very useful to get command outputs, for example ``set `date` ``

### Shifting Arguments

`shift` command will shift all positional arguments to the left.

For example

```bash
set hello world
shift
```

It will result in `hello` being lost, and `world` become `$1`. It is useful to loop through all arguments.

## If Statement

In bash, if statement will proceed only if the command returns 0, otherwise it will run else.

Return value of a command is not the output of the command.

UNIX returns 0 if a command runs successfully, other numbers for failure.

You can check the last process' return value with `$?`.

For example, the following scripts

```bash
if ls
then
    echo Exit code is $?
else
    echo Failure, exit code is $?
fi
```

It will print `Exit code is 0` if `ls` runs successfully.

### Test Command

`test` is a command you can use to test stuff, it will return 0 if true, 1 if false.

For example you can do this:

```bash
if test $FOO = $BAR
then
    echo Strings are identical
else
    echo Strings are different
fi
```

Short form of `test` is `[]`

```bash
if [ $FOO = $BAR ]
then
    echo Strings are identical
else
    echo Strings are different
fi
```

There are many things you can test on, following is some of them

* `-z string` - Empty string?
* `str1 = str2` - Identical string?
* `str1 != str2` - Different string?
* `int1 -eq int2` - Identical number?
* `-ne, -gt, -lt, -e` - Also for numbers
* `-a, -o`, - And, Or
* `-d name` - Exists a directory
* `-f name` - Exists a file
* `-r name` - Exists a readable file
* `-w name` - Exists a writable file
* `-x name` - Exists an executable file

## Expr

`expr` is used to do integer arithmetics. It can also be used for strings, but we usually don't do that.

For example

```bash
x=1
x=`expr $x + 1`
# If you want to do multiplication, you have to escape
x=`expr $x \* 5`
```

## While Loop

While loop will keep running as long as the command returns 0.

The basic structure is

```bash
while command
do
    more commands
done
```

You can use while to read from a file, line by line

```bash
file="myfile"

while read line
do
    echo $line
done < $file
```

## For Loop

For loop will loop though all provided values

```bash
for i in 1 2 "test" $FOO
do
    echo $i
done
```

One example for for loop would be to rename all files within a directory to `filename.txt`.

```bash
for i in `ls`
do
    mv $i $i.txt
done
```

You can also use for loop to loop through all positional arguments

```bash
for word in $*
do
    echo $word
done
```

## Subroutines

You can also create your own functions like this

```bash
func() {
    arg1=$1
    arg2=$2
    echo $arg1 $arg2
    return 1
}
func hello world
```

Arguements are passed as positional parameters. There is no variable scope, you can access variables inside or outside of the subroutine.

Return value is in `$?`, since subroutine is just a command.