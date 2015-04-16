#!/usr/bin/gawk -f

# Scan the patch and issue "p4 add" or "p4 edit"
# usage:  $0 -v CL=xxx patch.file

# Afterwards the patch has to be applied (in a separate step)!


# todo: p4 add/edit does not report (by failure) that a file is
#    *already* opened (in a _different_ CL). Parse the output?
# so there is no guarantee, that on success all the files are in
# the requested CL.


# todo: dry
BEGIN {new=0;
        if (length(CL)>0) {
                cl_spec = "-c " CL;
                # print cl_spec;
        } else {
                cl_spec="";
                # print "no CL"
        }
        # dry?
        # exit

        # when files are changed (not added), the diff(1) is
        # controlled by the p4(1) itself. And the paths are then
        # absolute, not relative to the original workspace root.
        # So here we need to remove it:
        ROOT="/home/michal/perforce/corsys/"
        offset=length(ROOT)+1
}


/^--- \/dev\/null/ { new=1; next;}

# otherwise:
/^--- / {filename=$1; new=0; #old= $2
}

/^+++ / {
        filename=$2
        filename=substr(filename,offset)
        # drop the prefix:
        if (new) {
                printf "adding %s\n", filename;
                # -c CL -t text filename
                cmd="p4 add " cl_spec " " filename;
        } else {
                printf "editing %s\n", filename;
                # -c CL -t text filename
                cmd="p4 edit " cl_spec " " filename;
        }
        print cmd > "/dev/stderr"
        system(cmd);

        new=0;
}

