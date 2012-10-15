#!/bin/bash

# generate version string

######################
# release version
MAJOR=0
MINOR=1
MICRO=2

######################
# libtool/API version

# updating: http://www.gnu.org/software/libtool/manual/html_node/Updating-version-info.html#Updating-version-info

# The implementation number of the current interface.
API_REVISION=1
# The most recent interface number that this library implements.
API_CURRENT=1
# The difference between the newest and oldest interfaces that this library 
# implements. In other words, the library implements all the interface numbers 
# in the range from number current - age to current.
API_AGE=0


# ----------------------------------------------

# function to print helptext
function help()
{
    echo "$0 --long | --short | --major | --minor | --micro | --git | --api-revision | --api-current | --api-age"
}

# output micro version
function micro()
{
    echo -n $MICRO
}

# output minor version
function minor()
{
    echo -n $MINOR
}

# output major version
function major()
{
    echo -n $MAJOR
}

# output api revision
function api_revision()
{
    echo -n $API_REVISION
}

# output api current
function api_current()
{
    echo -n $API_CURRENT
}

# output api age
function api_age()
{
    echo -n $API_AGE
}

# output git version
function output_git()
{
    T=$(git describe --always --dirty)
    echo -n ${T%%"\n"*}
}

# output short version string
function output_short()
{
    echo -n $(major).$(minor).$(micro)
}

# output long version string
function output_long()
{
    echo -n $(major).$(minor).$(micro)-$(output_git)
}

# parse cmdline arguments
TEMP=`getopt -o lsMmugrca --long long,short,major,minor,micro,git,api-revision,api-current,api-age -n 'version.sh' -- "$@"`
if [ $? != 0 ] ; then help ; echo "Terminating..." >&2 ; exit 1 ; fi

# Note the quotes around `$TEMP': they are essential!
eval set -- "$TEMP"

while true ; do
    case "$1" in
        # long
        -l|--long) output_long ; shift 1 ;;

        # short
        -s|--short) output_short ; shift 1 ;;

        # git
        -g|--git) output_git ; shift 1 ;;

        # major
        -M|--major) major ; shift 1 ;;

        # minor
        -m|--minor) minor ; shift 1 ;;

        # micro
        -u|--micro) micro ; shift 1 ;;

        # api-revision
        -r|--api-revision) api_revision ; shift 1 ;;

        # api-current
        -c|--api-current) api_current ; shift 1 ;;

        # api-age
        -c|--api-age) api_age ; shift 1 ;;

        # ?!
        --) help ; shift ; break ;;
        *) echo "Argument parsing error!" ; help ; exit 1 ;;
    esac
done

