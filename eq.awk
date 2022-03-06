/```.+:.+\..+/,/```/ {
    print $0
    split($0, code_blcok_start_line, ":")
    language = code_blcok_start_line[1]
    sub("```", "", language)
    filepath = code_blcok_start_line[2]
    
    if (language == "rust") {
        print "Comment out " toupper(language) " is //."
        {
            "cat " filepath | getline code_block
            print code_block
        }
        {
            "awk '/# 1/,/# -1/{print $0}' ./main.py" | getline code_block
            print code_block
        }

    } else if (language == "python") {
        print "#"
    } else {
        print "Sorry, I don't know how to handle this language: " language
    }
}
