# skip 2 lines after ==== header line.

# i.e. after
#  ==== //depot/path...
#  +++ /real/file/
#  --- /next/file/
#

/^====/ {
        print;
        getline;
        getline;
        getline
}

{
        print
}
