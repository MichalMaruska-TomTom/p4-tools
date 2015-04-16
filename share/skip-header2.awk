# out of this:
# --- A
# +++ B
# --- C
# +++ D
# extract:
# --- A
# +++ D
BEGIN {
        state=0;
}

/^--- / {
        if (state == 0) {
                state = 1;
                print;
                next;
        } else {
                # skip over
                state = 0;
                next;
        }
}

/^\+\+\+ / {
        if (state == 1) {
                state = 2;
                # skip over
                next;
        } else {
                print;
                state = 0;
                next;
        }
}

{print}

# so this story is more complex
# I can only gete A D if C is /tmp/tmp.*
# because for deleted files AB and CD are different files!
# for modified files C is /tmp/tmp.*, and A & B are depot/local with the same
# timestamp. and C is the current-time & D has the local timestamp.
