#! /usr/bin/awk -f

# The input format is:
# ... change 654056
# ... status have|need|partial


# So what we do:
# find the first "need" or "partial"

# and we might add +3 as the # other changes we have

# Major is never 0. Hence End is set only once, to a non-zero.
BEGIN {end=0; major=-1; plus=0}


/^... change ([0-9])+/ {
        change=$3;
};


# we have 2 states: 1/ until now all have
#                   2/ already something not "have"

# (end=0) state 1

/^... status have/ {
        major=change;
        # in state 2
        if (end > 0)
                plus++;
};


/^... status (partial|need)/ {
        if (end == 0) {
                #enter state 2
                end=major;
                plus=0;
        };
}


END {
        if (end==0) {
                # still in state 1
                end=major;
                # plus = 0;
        }
        if (plus!=0)
                printf "%d+%d\n", end, plus;
        else
                printf "%d\n", end;
}
