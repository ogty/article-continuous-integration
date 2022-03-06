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


    for (i = 0; i < 256; i++) { 
        c2p[sprintf("%c", i)] = sprintf("%%%02X", i);
    }

    for (i = 48; i < 58; i++) { 
        c2p[sprintf("%c", i)] = sprintf("%c", i);
    }

    for (i = 65; i < 91; i++) {
        c2p[sprintf("%c", i)] = sprintf("%c", i);
    }

    for (i = 97; i < 123; i++) {
        c2p[sprintf("%c", i)] = sprintf("%c", i);
    }

    c2p[" "] = "%20";
    c2p["-"] = "-";
    c2p["."] = ".";
    c2p["_"] = "_";
    c2p["~"] = "~";
    c2p["\""] = "%22";
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

function command_runner_and_playground(path, start, end, comment_word, url_word) {
    cmd = "awk /" start "/,/" end "/'{print $0}' " path;

    print "\n[" url_word "](https://play.rust-lang.org/?version=stable&mode=debug&edition=2021&code=";
    while (cmd | getline line) {
        print "%0A";
        for (i = 1; i <= length(line); i++) {
            if (line != comment_word " " start && line != comment_word " " end) {
                print c2p[substr(line, i, 1)];
            }
        }
    }
    close(cmd);
    print ")\n\n";
}

count = 0;

/```.+:.+\..+:.+:.+```/ {
    split($0, code_block, ":");
    
    language = code_block[1];
    filepath = code_block[2];
    start = code_block[3];
    end = code_block[4];

    sub("```", "", language);
    sub("```", "", end);

    print "```" language ":" filepath;
    cmd = "bash -c \"if [[ -e " filepath " ]]; then echo true; else echo false; fi;\"";
    if (cmd | getline line) {
        if (line == "true") {
            if (language == "rust" && length(code_block) == 5) {
                sub("```", "", code_block[5]);
                OFS = "";
                ORS = "";
                command_runner_and_playground(filepath, start, end, data[language], code_block[5]);
                OFS = " ";
                ORS = "\n";
            } else {
                command_runner(filepath, start, end, data[language]);
            }
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

    print "```" language;
    for (i = 1; i <= length(target_list); i++) {
        sub("```", "", target_list[i]);
        split(target_list[i], target, ":");

        filepath = target[1];
        start = target[2];
        end = target[3];

        cmd = "bash -c \"if [[ -e " filepath " ]]; then echo true; else echo false; fi;\"";
        if (cmd | getline line) {
            if (line == "true") {
                command_runner(filepath, start, end, data[language]);
            } else {
                print "ERROR";
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
