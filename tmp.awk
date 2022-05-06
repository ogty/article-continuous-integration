BEGIN {
    delimiter = "|";
    column_counter = 0;
    data[0] = "";
}

/^\|/{
    if (column_counter == 1) {
        column_counter += 1;
        next;
    }

    split($0, column, delimiter);
    column_length = length(column);

    if (column_counter == 0) {
        print("<table>\n\t<thread>\n\t\t<tr>");
    } else {
        print("\t\t<tr>");
    }

    for (i = 2; i < column_length; i++) {
        if (column_counter == 0) {
            if (column[i] == "") {
                print("\t\t\t<th>", data[i], "</th>");
            } else {
                print("\t\t\t<th>", column[i], "</th>");
            }
        } else {
            if (column[i] == "") {
                print("\t\t\t<td>", data[i], "</td>");
            } else {
                print("\t\t\t<td>", column[i], "</td>");
            }
        }
        data[i] = column[i];
    }

    if (column_counter == 0) {
        print("\t\t</tr>\n\t</thread>\n\t<tbody>");
    } else if (column_counter == column_length - 2) {
        print("\t\t</tr>\n\t</tbody>\n</table>");
    } else {
        print("\t\t</tr>");
    }

    column_counter += 1;
}
