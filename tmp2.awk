BEGIN {
    column_length = 0;                                  # Counter variable for number of columns
    only_whitespace[0] = 0;                             # Initialize an associative array counting spaces per column
    generate_associative_array_counter = 0;             # Variable for one-time initialization of associative array
    file_name_for_temporary_table = "table-content.tmp" # Temporary file name for table

    table_generator();
}

function table_recode_reader(line) {
    # TODO: Change to a form that takes into account right-justification, etc.
    if (line ~ /^\|\s\-{2,}/) {
        return;
    }

    split(line, array, "|");           # Split table records by pipe
    column_length = length(array) - 2; # Get the number of columns

    if (generate_associative_array_counter == 0) {
        for (i = 1; i < column_length; i += 1) {
            only_whitespace[i] = 0;
        }
    }

    system(sprintf("echo '\t</tr>' >> %s", file_name_for_temporary_table));
    for (index_of_column = 2; index_of_column < length(array); index_of_column += 1) {
        # TODO: Remove surrounding whitespace
        column_word = sprintf("%s", gensub(/\s+/, "", "g", array[index_of_column]));

        if (column_word != "") { # If there is a string
            if (only_whitespace[index_of_column] > 0) {
                system(sprintf("echo '\t\t<td rowspan=\"%d\">%s</td>' >> %s", \
                    only_whitespace[index_of_column] + 1, \
                    column_word, \
                    file_name_for_temporary_table \
                ));
                only_whitespace[index_of_column] = 0;
            } else {
                system(sprintf("echo '\t\t<td>%s</td>' >> %s", column_word, file_name_for_temporary_table));
            }
        } else { # If there were only whitespace.
            only_whitespace[index_of_column] += 1;
        }
    }
    system(sprintf("echo '\t<tr>' >> %s", file_name_for_temporary_table));

    generate_associative_array_counter += 1;
}

function table_generator() {
    # Function to read a file backwards and generate a table
    # NOTE: All tables written in Markdown notation in the relevant Markdown file will be converted to HTML format.
    # NOTE: Columns are converted in reverse order
    # TODO: Adding proprietary notation

    # TODO: Get filename from settings section
    cmd = sprintf("tail -r README.txt");
    system(sprintf("echo '</table>' >> %s", file_name_for_temporary_table));
    while (cmd | getline line) {
        if (line ~ /^\|/) {
            table_recode_reader(line);
        }
    }
    system(sprintf("echo '<table>' >> %s", file_name_for_temporary_table));
    close(cmd);

    cmd = "tail -r table-content.tmp";
    while (cmd | getline line) {
        system(sprintf("echo '%s' >> table-content.txt", line));
    }
    system(sprintf("rm %s", file_name_for_temporary_table));
}
