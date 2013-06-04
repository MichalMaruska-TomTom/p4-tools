# skip 2 lines after ==== header line.

/^====/ {
        print;
        getline;
        getline;
        getline
}

{
        print
}
