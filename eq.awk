BEGIN {
    data["awk"] = "#";
    data["bat"] = "rem";
    data["bash"] = "#";
    data["c"] = "//";
    data["c#"] = "//";
    data["cs"] = "//";
    data["c++"] = "//";
    data["cpp"] = "//";
    data["css"] = "/*";
    data["dart"] = "//";
    data["go"] = "//";
    data["haskell"] = "--";
    data["html"] = "<!--";
    data["java"] = "//";
    data["javascript"] = "//";
    data["js"] = "//";
    data["julia"] = "#";
    data["jl"] = "#";
    data["lisp"] = ";";
    data["lua"] = "--";
    data["makefile"] = "#";
    data["nim"] = "#";
    data["objectivec"] = "//";
    data["php"] = "//";
    data["powershell"] = "#";
    data["python"] = "#";
    data["py"] = "#";
    data["r"] = "#";
    data["ruby"] = "#";
    data["rb"] = "#";
    data["rust"] = "//";
    data["rs"] = "//";
    data["scala"] = "//";
    data["sh"] = "#";
    data["swift"] = "//";
    data["typescript"] = "//";
    data["ts"] = "//";
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

/```.+:.+\..+:.+```/ {
    split($0, code_block, ":");
    
    language = code_block[1];
    filepath = code_block[2];
    specifiede_range_word = code_block[3];

    sub("```", "", language);
    sub("```", "", specifiede_range_word);

    print "```" language ":" filepath;
    # TODO: Use arguments(start, end);
    # TODO: Check if file exists;
    command_runner(filepath, "start", "end", data[language]);
    print "```";

    count++;
}

{   
    if (count == 0) {
        print $0;
        count = 0;
    }
}
