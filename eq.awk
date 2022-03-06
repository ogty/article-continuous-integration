/start/,/end/ {
    print $0
}

/```.+:.+\..+/,/```/ {
    print $0
    split($0, a, ":")
    language = a[1]
    filepath = a[2]
    print "language: " language
    print "filepath: " filepath
}
