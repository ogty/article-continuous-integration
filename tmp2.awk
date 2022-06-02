BEGIN {
    column_length = 0;                        # Counter variable for number of columns
    only_whitespace[0] = 0;                   # Initialize an associative array counting spaces per column
    table_content_counter = 1;                # Count the number of occurrences of joinable tables
    table_content_prefix_counter = 1;         # Variable to count the number of "<--->"
    file_name_for_temporary_table = "";       # Temporary file name for table
    generate_associative_array_counter = 0;   # Variable for one-time initialization of associative array
    number_of_table_generator_executions = 0; # Variable to make table_generator() run only once

    # TODO: If there was no table-content folder, create one
}

function table_recode_reader(line) {
    # TODO: Change to a form that takes into account right-justification, etc.
    if (line ~ /^\|\s\-{2,}/) {
        return;
    }

    split(line, array, "|");           # Split table records by pipe
    column_length = length(array) - 2; # Get the number of columns

    # Initialize an associative array counting whitespace
    if (generate_associative_array_counter == 0) {
        for (i = 1; i < column_length; i += 1) {
            only_whitespace[i] = 0;
        }
    }

    # Row creation and output
    system(sprintf("echo ' </tr>' >> %s", file_name_for_temporary_table));
    #                     ^ Whitespace for style available
    for (index_of_column = 2; index_of_column < length(array); index_of_column += 1) {
        # TODO: Remove surrounding whitespace
        column_word = sprintf("%s", gensub(/\s+/, "", "g", array[index_of_column]));

        if (column_word != "") { # If there is a string
            if (only_whitespace[index_of_column] > 0) {
                system(sprintf("echo '  <td rowspan=\"%d\">%s</td>' >> %s", \
                    #                 ^^ Whitespace for style available
                    only_whitespace[index_of_column] + 1, \
                    column_word, \
                    file_name_for_temporary_table \
                ));
                only_whitespace[index_of_column] = 0;
            } else {
                system(sprintf("echo '  <td>%s</td>' >> %s", column_word, file_name_for_temporary_table));
                #                     ^^ Whitespace for style available
            }
        } else { # If there were only whitespace.
            only_whitespace[index_of_column] += 1;
        }
    }
    system(sprintf("echo ' <tr>' >> %s", file_name_for_temporary_table));
    #                     ^ Whitespace for style available

    generate_associative_array_counter += 1;
}

function table_generator(table_counter) {
    # Function to read a file backwards and generate a table
    # NOTE: All tables written in Markdown notation in the relevant Markdown file will be converted to HTML format.
    # NOTE: Columns are converted in reverse order

    file_name_for_temporary_table = sprintf("table-content-%d.tmp", table_counter)
    file_name_for_table = sprintf("table-content-%d.txt", table_counter);

    # Initialize per-table files to prevent overwriting
    system(sprintf("echo ' ' > %s", file_name_for_table));

    # Leaves and reads the target file and creates a joined table
    system(sprintf("echo '</table>' >> %s", file_name_for_temporary_table));
    cmd = sprintf("tail -r README.txt"); # TODO: Get filename from settings section
    most_recent_table_content_counter = 0;
    while (cmd | getline line) {
        # Counting target tables in the file read stage
        if (line ~ /^<--->/) {
            most_recent_table_content_counter += 1;
        }

        # Comparison of the target table count in the file read phase with the number of tables already created
        if (most_recent_table_content_counter != table_content_prefix_counter) {
            continue;
        }

        # Create table if number matches
        if (line ~ /^\|/) {
            table_recode_reader(line);
        }

    }
    system(sprintf("echo '<table>' >> %s", file_name_for_temporary_table));
    close(cmd);

    # Reverse the contents of the temporary file and write to the main file
    cmd = sprintf("tail -r %s", file_name_for_temporary_table);
    while (cmd | getline line) {
        system(sprintf("echo '%s' >> %s", line, file_name_for_table));
    }
    close(cmd);

    system(sprintf("rm %s", file_name_for_temporary_table)); # Delete temporary files
    system(sprintf("cat %s", file_name_for_table));          # Output to console

    table_content_prefix_counter += 1;
}

# Create tables written in markdown notation that can be joined
# Notation: <---...<--->
/^<---/,/^<--->/ {
    if (number_of_table_generator_executions == 0) {
        table_generator(table_content_counter);
        generate_associative_array_counter = 0;
        table_content_counter += 1;
    }

    number_of_table_generator_executions += 1;
    next;
}

{
    print($0);
    number_of_table_generator_executions = 0;
}
