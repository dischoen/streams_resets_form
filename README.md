# streams_resets_form

I wanted to filter a .table in a Phoenix LiveView with multiple
filters, i.e., one filter per column.
For that I added a .simple_form above the .table and created a
phx_change/handle_event pair.
Filtering for one column went well at once, but when I wanted
to filter for multiple columns and jumped to another field,
the first field was cleared.

After some trying, I came to this solution:
- Initially the form is filled with a map and to_form()
- In the handle_event function I take the actual values from the
  second parameter and put them in a map and call to_form again,
  which is again assigned to the socket.
