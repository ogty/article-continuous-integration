# Description:
#     The output replaces the specific notation described 
#     in the text file on which the Markdown file is based 
#     with the source code referenced therein.
#
# General Notation:
#     ```<language>:<file path>:<start>:<end>:[url string]```
#
# Operations Notation:
#     ```<language>|pattern pattern ...```
#                           ^^^^^^^ 
#                               <file path>:<start>:<end>
#
# Usage:
#     awk -f main.awk <base file>
#
# One-liner:
#     awk -f main.awk <base file> > <target file>


BEGIN {
    # Languages comment-out format
    data["awk"] = "#";
    data["bash"] = "#";
    data["bat"] = "rem";
    data["c"] = "//";
    data["c#"] = "//";
    data["c++"] = "//";
    data["cpp"] = "//";
    data["cs"] = "//";
    data["css"] = "/*";
    data["dart"] = "//";
    data["go"] = "//";
    data["haskell"] = "--";
    data["html"] = "<!--";
    data["java"] = "//";
    data["javascript"] = "//";
    data["jl"] = "#";
    data["js"] = "//";
    data["julia"] = "#";
    data["lisp"] = ";";
    data["lua"] = "--";
    data["makefile"] = "#";
    data["nim"] = "#";
    data["objectivec"] = "//";
    data["php"] = "//";
    data["powershell"] = "#";
    data["py"] = "#";
    data["python"] = "#";
    data["r"] = "#";
    data["rb"] = "#";
    data["rs"] = "//";
    data["ruby"] = "#";
    data["rust"] = "//";
    data["scala"] = "//";
    data["sh"] = "#";
    data["swift"] = "//";
    data["ts"] = "//";
    data["typescript"] = "//";

    # URL encoding
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
    
    c2p["-"] = "-";
    c2p["."] = ".";
    c2p["_"] = "_";
    c2p["%"] = "%25";
    c2p["+"] = "%2B";
    c2p[" "] = "%20";
    c2p["/"] = "%2F";
    c2p["?"] = "%3F";
    c2p["#"] = "%23";
    c2p["&"] = "%26";
    c2p["="] = "%3D";
    c2p[";"] = "%3B";
    c2p[":"] = "%3A";
    c2p["@"] = "%40";
    c2p["$"] = "%24";
    c2p["\""] = "%22";
    c2p["<"] = "%3C";
    c2p[">"] = "%3E";
    c2p["#"] = "%23";
    c2p["{"] = "%7B";
    c2p["}"] = "%7D";
    c2p["|"] = "%7C";
    c2p["\\"] = "%5C";
    c2p["^"] = "%5E";
    c2p["~"] = "%7E";
    c2p["["] = "%5B";
    c2p["]"] = "%5D";
    c2p["`"] = "%60";
    c2p["\'"] = "%27";
}


# Counter variable to separate code blocks from the rest of the code
count = 0;

# Variable for playground URL
global_filepath = "";
global_start = "";
global_end = "";
global_comment_word = "";
global_url_word = "";


# Function to retrieve a specific range of source code
function command_runner(path, start, end, comment_word) {
    cmd = "awk /" start "/,/" end "/'{print $0}' " path;

    while (cmd | getline line) {
        if (line != comment_word " " start && line != comment_word " " end) {
            print line;
        }
    }

    close(cmd);
}


# Function to retrieve a specific range of source code for a playground URL
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
    print ")\n";

    close(cmd);
}


# Code block generation from program loading
/```.+:.+\..+:.+:.+```/ && !/```.+\|.+```/ {
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
            # For playground
            if (language == "rust" && length(code_block) == 5) {
                sub("```", "", code_block[5]);
                global_filepath = filepath;
                global_start = start;
                global_end = end;
                global_comment_word = data[language];
                global_url_word = code_block[5];
                count += 1;
            }

            # Stdout source code
            command_runner(filepath, start, end, data[language]);
        } else {
            print "No such file";
        }
    }
    close(cmd);
    print "```";

    count += 1;
}


# Code block operation
/```.+\|(.+\..+:.+:.+?){2,}```/ {
    print "";
    split($0, code_block_for_operation, "|");
    
    language = code_block_for_operation[1];
    targets = code_block_for_operation[2];

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
}


# Processing of code other than code blocks and for playground
{   
    if (count == 0) {
        print $0;
        count = 0;
    } else if (count == 2) {
        OFS = "";
        ORS = "";
        command_runner_and_playground(\
            global_filepath,
            global_start,
            global_end,
            global_comment_word,
            global_url_word\
        );
        OFS = " ";
        ORS = "\n";
        count = 0;
    }
}
