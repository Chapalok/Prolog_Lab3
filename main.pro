implement main
    open core, stdio



class facts
    employee:(integer Id, name, integer Salary, integer DepartmentId).
clauses
    employee(1, "John Smith", 50000, 11).
    employee(2, "Jane Doe", 80000, 11).
    employee(3, "Bob Johnson", 60000, 22).
    employee(4, "Alice Brown", 99999, 22).
    employee(5, "David Davis", 40000, 33).



class predicates
    filterEmployees: (integer DepartmentId, List).

clauses
    filterEmployees(DepartmentId, Filtered) :-
    findall((Id, Name, Salary), employee(Id, Name, Salary, DepartmentId), Filtered).



class predicates
    printEmployees: (List).

clauses
    printEmployees([]).
    printEmployees([(Id, Name, Salary) | Rest]) :-
        format("ID: ~w, Name: ~w, Salary: ~w~n", [Id, Name, Salary]),
        printEmployees(Rest).




class predicates
    findEmployee: (integer Id, Employee).

clauses
   findEmployee(Id, (Id, Name, Salary, DepartmentId)) :-
    employee(Id, Name, Salary, DepartmentId).




class predicates
    calculateStatistics: (List, integer, integer, integer, integer).

clauses
    calculateStatistics([], 0, 0, 0, 0).
    calculateStatistics([(Id, _, Salary) | Rest], Count, Max, Min, Total) :-
    calculateStatistics(Rest, CountRest, MaxRest, MinRest, TotalRest),
    Count is CountRest + 1,
    Max is max(Salary, MaxRest),
    Min is min(Salary, MinRest),
    Total is TotalRest + Salary.




class predicates
    getTotalSalary: (List, integer).

clauses
    getTotalSalary([], 0).
    getTotalSalary([(Id, _, Salary) | Rest], Total) :-
    getTotalSalary(Rest, TotalRest),
    Total is TotalRest + Salary.



class predicates
    run: ().

clauses
    run() :-
    write("Enter department ID: "),
    read_line_to_string(user_input, Input),
    atom_number(Input, DepartmentId),
    filterEmployees(DepartmentId, Employees),
    printEmployees(Employees),
    findEmployee(3, Employee),
    format("Found Employee: ~w~n", [Employee]),
    calculateStatistics(Employees, Count, Max, Min, Total),
    Avg is Total / Count,
    format("Count: ~w, Max Salary: ~w, Min Salary: ~w, Total Salary: ~w, Avg Salary: ~w~n", [Count, Max, Min, Total, Avg]),
    getTotalSalary(Employees, TotalSalary),
    format("Total Salary: ~w~n", [TotalSalary]).


    end implement main
    goal
    console::runUtf8(main::run).