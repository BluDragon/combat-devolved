// Step event for the Medal Controller
{
    var i, map, age;
    
    // iterate through all the medals and increment their age
    // counters, removing ones that are too old
    for (i = ds_list_size(medals) - 1; i >= 0; i -= 1) {
        map = ds_list_find_value(medals, i);
        age = ds_map_find_value(map, "age");
        if (age < maxAge) {
            ds_map_replace(map, "age", age + 1);
        } else {
            ds_map_destroy(map);
            ds_list_delete(medals, i);
        }
    }
}
