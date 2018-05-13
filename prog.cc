#include <mysql.h>
#include <iostream>
#include <string>

using namespace std;
MYSQL *conn, mysql;
MYSQL_RES *res;
MYSQL_ROW row;

int query_state;

int main()
{
    const char* server = "Courses";
    const char* user = "z1803493;
    const char* password = "1995Jul";
    const char* database = "z1803493;

    mysql_init(&mysql);
    conn = mysql_real_connect(&mysql, server, user, password, database, 0, 0, 0);

    if (!conn) {
        cout << mysql_error(&mysql) << endl;
        return -1;
    }
//item vs package
    string select_query = "Select i.item_id, p.package_id      from Item i, Package p      where i.item_id = p.item_id group by p.package_id ";
    query_state = mysql_query(conn, select_query.c_str());
    if (query_state) {
        cout << mysql_error(conn) << endl;
        return 1;
    }

    res = mysql_store_result(conn);
   
    cout<<"Item vs package"<<endl<<endl;
    while ((row = mysql_fetch_row(res)) != NULL) {
        cout<<"Item : "<<row[0]<<" Package id : "<<row[1]<<endl;
    }
    cout<<endl;

//vounteer cs task
     select_query = "Select v. vname  , t.task_description  from Volunteer v, task_assigned a, Task t  where v. volunteer_id = a.volunteer_id and a.tcode = t.tcode";
    query_state = mysql_query(conn, select_query.c_str());
    if (query_state) {
        cout << mysql_error(conn) << endl;
        return 1;
    }

    res = mysql_store_result(conn);
   
    cout<<"volunteer vs task "<<endl<<endl;
    while ((row = mysql_fetch_row(res)) != NULL) {
        cout<<"Volunteer name : "<<row[0]<<endl<<"Task Description : "<<row[1]<<endl;
    }
    cout<<endl;

//volunteer vs packing

    select_query = "Select v. vname, p.name_packaging from Volunteer v, task_assigned a, task_withshipping w, packaging_task p     where v. volunteer_id = a.volunteer_id and a.tcode = w.tcode and w.name_packaging = p.name_packaging";
    query_state = mysql_query(conn, select_query.c_str());
    if (query_state) {
        cout << mysql_error(conn) << endl;
        return 1;
    }

    res = mysql_store_result(conn);
   
    cout<<"volunteer vs packaging"<<endl<<endl;
    while ((row = mysql_fetch_row(res)) != NULL) {
        cout<<"Volunteer Name : "<<row[0]<<endl<<"Packaging Name : "<<row[1]<<endl;
    }
    cout<<endl;

//item vs count
    select_query = "Select i.item_description, count(i.item_id)     from Item i, Package p , packaging_task t  where i.item_id = p.item_id and p.package_id = t.package_id group by i.item_id";
    query_state = mysql_query(conn, select_query.c_str());
    if (query_state) {
        cout << mysql_error(conn) << endl;
        return 1;
    }

    res = mysql_store_result(conn);
   
    cout<<"Item vs count"<<endl<<endl;
    while ((row = mysql_fetch_row(res)) != NULL) {
        cout<<"Item : "<<row[0]<<endl<<"Count : "<<row[1]<<endl;
    }
    cout<<endl;

//list vs weight

    select_query = "Select  distinct l.list_name , p.weight from Packaging_list l ,Item i ,Package p      where l.item_id = i.item_id and p.item_id = i.item_id";
    query_state = mysql_query(conn, select_query.c_str());
    if (query_state) {
        cout << mysql_error(conn) << endl;
        return 1;
    }

    res = mysql_store_result(conn);
   
    cout<<"List vs weight"<<endl<<endl;
    while ((row = mysql_fetch_row(res)) != NULL) {
        cout<<"list : "<<row[0]<<endl<<"weight : "<<row[1]<<endl;
    }
    cout<<endl;


//updating volunteer names

    select_query = " update Volunteer set vname = \'SRK\' where volunteer_id = \'3\'";
    query_state = mysql_query(conn, select_query.c_str());
    if (query_state) {
        cout << mysql_error(conn) << endl;
        return 1;
    }
    cout<<"Updated the volunteer name coulumn"<<endl;

//deleting item
    select_query = "delete from Item where value = 0.01";
    query_state = mysql_query(conn, select_query.c_str());
    if (query_state) {
        cout << mysql_error(conn) << endl;
        return 1;
    }
    cout<<"Deletion sucessfully"<<endl;
//Updating item value
    select_query = "Update Item set value = 8.0 where value = 0.01";
    query_state = mysql_query(conn, select_query.c_str());
    if (query_state) {
        cout << mysql_error(conn) << endl;
        return 1;
    }
    cout<<"Updated the Item value"<<endl;

    
    mysql_free_result(res);
    mysql_close(conn);
}
