
/^--- \/dev\/null/ {
        #skip this & next
        getline;
        next;
}

{
        print
}
