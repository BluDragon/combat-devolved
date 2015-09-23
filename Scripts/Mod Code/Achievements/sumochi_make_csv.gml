// accepts a ds_list and returns a comma-seperated list string

var list;
var i;

list = "";

for (i = 0; i < ds_list_size(argument0); i+=1) {
    list = list + ds_list_find_value(argument0, i);
    if (i != ds_list_size(argument0)-1) {
        list = list + ",";
    }
}

return list;
