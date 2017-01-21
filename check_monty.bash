#!/bin/bash
#
# Performing checks on the Holberton School "monty interpretor" project

#######################################
# Print KO, in red, followed by a new line
# Globals:
#   None
# Arguments:
#   None
# Returns:
#   None
#######################################
function print_ko()
{
    echo -e "[\033[31mKO\033[37m]"
}

#######################################
# Print OK in green, followed by a new line
# Globals:
#   None
# Arguments:
#   None
# Returns:
#   None
#######################################
function print_ok()
{
    echo -e "[\033[32mOK\033[37m]"
}

#######################################
# Kill monty in a clean way and remove temporary files
# Globals:
#   MONTY
#   OUTPUTFILE
#   ERROROUTPUTFILE
#   LTRACEOUTPUTFILE
# Arguments:
#   None
# Returns:
#   None
#######################################
function stop_monty()
{
    if [ `pidof $MONTY | wc -l` -ne 0 ]; then
	   killall -9 $MONTY 2>&1 > /dev/null
    fi
    rm -f $OUTPUTFILE $ERROROUTPUTFILE $LTRACEOUTPUTFILE
}

# Load configuration
source config

# Cleanup
echo -ne "\033[37m"
rm -f $OUTPUTFILE $LTRACEOUTPUTFILE

# Printout explaining the process
echo Hello, and welcome to the monty testsuite!
echo First, make sure you have configured the config file
echo "  the var \$MONTY in config should point to your interpretor"
echo " "
echo The tests should produce only OK or KO.
echo Any extra output is extraneous, and is likely a mistake.
echo " "


# Locates all tests and launch them
for dir in `ls -d "$TESTDIR"/*/`
do
    echo "> $dir"
    for testname in `ls "$dir" -p | grep -v / | grep -v "~$"`
    do
	   echo -n "   # $testname: "
	   source "$dir$testname"
    done
done

# Cleanup
rm -f $OUTPUTFILE $LTRACEOUTPUTFILE $ERROROUTPUTFILE
rm -f checker_output_*
rm -f checker_tmp_file_*
rm -f /tmp/.checker_tmp_file_*
echo -ne "\033[37m"
