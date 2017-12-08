#! /usr/bin/perl


# enrich a DIFF(1) input  with (revision xx) addendum which complements the filename
# with perforce version number.
use strict;

# Usage: $0 {depot-name}

my ($DEPOT_ROOT)=@ARGV;

my $GUESS_REVISION_TOOLS ="p4-revision-of";
my $added=0;

while (<STDIN>) {
    chomp;                      # strip record separator
    if ( /diff --git/) {
        # skip over
        # print $_,"\n";
    } elsif ( /--- \/dev\/null/ ) {
        print $_,"\n";
        $added=1;
    } elsif ( /--- a/) {
        my $filename=substr($_, 6);
        $added=0;
        my $revision=`$GUESS_REVISION_TOOLS \"$DEPOT_ROOT/$filename\"`;
        # todo:  \t ?
        printf ("--- %s/%s	(revision %d)\n", $DEPOT_ROOT, $filename, $revision);
    } elsif (/^\+\+\+ b/) {
        my $filename=substr($_, 6);
        # fixme: if removed?
        if ($added == 1) {
            printf "+++ $DEPOT_ROOT/$filename\t(revision none)\n";
        }else {
            printf "+++ $DEPOT_ROOT/$filename\n";
        }
    } else {
        print $_,"\n";
    };
}
