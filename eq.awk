function command_runner(path, start, end) {
    cmd = "awk /" start "/,/" end "/'{print $0}' " path
    while (cmd | getline) {
        print $0
    }
    close(cmd)
}

count = 0

/```.+:.+\..+:.+```/ {
    split($0, code_block, ":")
    
    language = code_block[1]
    filepath = code_block[2]
    specifiede_range_word = code_block[3]

    sub("```", "", language)
    sub("```", "", specifiede_range_word)

    print "```" language ":" filepath
    command_runner(filepath, "start", "end")
    print "```"
    count++
}

{   
    if (count == 0) {
        print $0
        count = 0
    }
}
