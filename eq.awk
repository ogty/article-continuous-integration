BEGIN {
    data["awk"] = "#";
    data["bat"] = "rem";
    data["bash"] = "#";
    data["c"] = "//";
    data["c#"] = "//";
    data["c++"] = "//";
    data["css"] = "/*";
    data["dart"] = "//";
    data["go"] = "//";
    data["haskell"] = "--";
    data["html"] = "<!--";
    data["java"] = "//";
    data["javascript"] = "//";
    data["julia"] = "#";
    data["lisp"] = ";";
    data["lua"] = "--";
    data["makefile"] = "#";
    data["nim"] = "#";
    data["objectivec"] = "//";
    data["php"] = "//";
    data["powershell"] = "#";
    data["python"] = "#";
    data["r"] = "#";
    data["ruby"] = "#";
    data["rust"] = "//";
    data["scala"] = "//";
    data["sh"] = "#";
    data["swift"] = "//";
    data["typescript"] = "//";
}

function command_runner(path, start, end, comment_word) {
    cmd = "awk /" start "/,/" end "/'{print $0}' " path;
    while (cmd | getline line) {
        if (line != comment_word " " start && line != comment_word " " end) {
            print line;
        }
    }
    close(cmd);
}

count = 0

/```.+:.+\..+:.+:.+```/ {
    split($0, code_block, ":");
    
    language = code_block[1];
    filepath = code_block[2];
    start = code_block[3];
    end = code_block[4];

    sub("```", "", language);
    sub("```", "", end);

    print "```" language ":" filepath;
    cmd = "bash -c \"if [[ -e " filepath " ]]; then echo true; else echo false; fi;\""
    if (cmd | getline line) {
        if (line == "true") {
            command_runner(filepath, start, end, data[language]);
        } else {
            print "ERROR"
        }
    }
    close(cmd);
    print "```";

    count++;
}

/```.+\|(.+\..+:.+:.+?){2,}/ {
    print "";
    split($0, code_block_for_operation, "|");
    
    language = code_block_for_operation[1];
    targets =  code_block_for_operation[2];

    sub("```", "", language);
    split(targets, target_list, " ");

    print "```" language
    for (i = 1; i <= length(target_list); i++) {
        sub("```", "", target_list[i]);
        split(target_list[i], target, ":");

        filepath = target[1];
        start = target[2];
        end = target[3];

        cmd = "bash -c \"if [[ -e " filepath " ]]; then echo true; else echo false; fi;\""
        if (cmd | getline line) {
            if (line == "true") {
                command_runner(filepath, start, end, data[language]);
            } else {
                print "ERROR"
            }
        }
        close(cmd);

        if (i != length(target_list)) {
            print "";
        }
    }
    print "```";

    count++;
}

{   
    if (count == 0) {
        print $0;
        count = 0;
    }
}
