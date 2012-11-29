#! /usr/bin/awk -f

# The input format is:
# ... change 654056
# ... status have|need|partial


# So what we do:
# find the first "need" or "partial"

# and we might add +3 as the # other changes we have

# Major is never 0. Hence End is set only once, to a non-zero.

# Note: it's assumed that 0 is not a valid P4 changelist.
# so  0+1-1 means: no entire changelist (i.e. the initial one)
# has been (entirely) synced.

# major is the last p4 CL processed
# end   is the last CL, up to which _fully_ synced.
# plus/minus  additional/missing CLs.

BEGIN {end=0; contiguous=1; plus=0; minus=0}

/^... change ([0-9])+/ {
        change=$3;
};


# we have 2 states: 1/ until now all have -- contiguous=1
#                   2/ already something not "have"

# (end=0) state 1

/^... status have/ {
        if (!contiguous)
                 plus++;
        else
          end=change;
};


/^... status (partial|need)/ {
        minus++;
        if (contiguous) {
                contiguous = 0;
        };
}


END {
        if (!contiguous)
                printf "%d+%d-%d\n", end, plus, minus;
        else
                printf "%d\n", end;
}
