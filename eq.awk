function command_runner(path) {
    cmd = "awk -f ./process.awk " path
    while (cmd | getline) {
        print $0
    }
}

/```.+:.+\..+:.+```/ {
    split($0, code_block, ":")
    
    language = code_block[1]
    filepath = code_block[2]
    tmp = code_block[3]

    sub("```", "", language)
    sub("```", "", tmp)

    print "MATCH    : " $0
    print "LANGUAGE : " language
    print "FILEPATH : " filepath
    print "TMP      : " tmp
    print "----------------------------"
    
    if (language == "rust") {
        print "Comment out " toupper(language) " is //."
        command_runner(filepath)
    }

    # 
    # common part
    # 
}
