# Description:
#     Heading 1 is not included in the table of contents 
#     because it is the only one that should exist.
#
# Operations Notation:
#     -_|<file-name>|<url-prefix>
# 
# Usage:
#     awk -f main.awk <base-file>
# 
# One-liner:
#     awk -f main.awk <base-file> > <target-file>
#

BEGIN {
    count = 0
}

function table_of_contents_generator(file_path, url_prefix) {
    base_heading_number = 2
    ORS = ""
    cmd = "awk '/\#{1,7}/ {print $0}' " file_path

    while (cmd | getline line) {
        split(line, arr, " ")

        if (length(arr[1])) {
            sharp_length = length(arr[1])
            
            if (sharp_length > base_heading_number - 1) {
                if (sharp_length > base_heading_number) {
                    sharp_length = (abs(1 - sharp_length) - 1) + sharp_length - base_heading_number
                } else {
                    sharp_length = 0
                }
                for (i = 0; i < sharp_length; i++) {
                    print(" ")
                }
                print(sprintf("- [%s](%s)\n", arr[2], url_prefix))
            }

        }
    }
    close(cmd)
    ORS = "\n"
}

function abs(value) {
    value += 0;
    return value < 0 ? -value : value;
}

/-_\|.+.\|+/ {
    split($0, information, "|")
    table_of_contents_generator(information[2], information[3])
    count += 1
}

{
    if (count != 1) {
        print $0
    } else {
        count = 0
    }
}
