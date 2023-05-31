implement main
    open core, stdio

domains
    name = string.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class facts
    emp : (integer Id, name, string Gender, string Birthday).

clauses
    emp(1, "John Smith", "Male", "01/01/1990").
    emp(2, "Jane Doe", "Female", "02/02/1995").
    emp(3, "Bob Johnson", "Male", "03/03/1985").
    emp(4, "Alice Brown", "Female", "04/04/1992").
    emp(5, "Tom Wilson", "Male", "05/05/1998").

class predicates
    printEmployees : ().
    updateEmployee : (integer Id, name, string Gender, string Birthday).

clauses
    printEmployees() :-
        emp(Id, name, Gender, Birthday),
        write(Id, "\t", name, "\t", Gender, "\t", Birthday),
        nl,
        fail.
    printEmployees() :-
        write("All employees are shown above\n").

clauses
    updateEmployee(Id, name, Gender, Birthday) :-
        retract(emp(Id, _, _, _)),
        asserta(emp(Id, name, Gender, Birthday)),
        fail.
    updateEmployee(_, _, _, _).

clauses
    run() :-
        printEmployees(),
        write("Enter employee id to update: "),
        X = toTerm(stdio::readLine()),
        write("Enter employee name: "),
        Y = stdio::readLine(),
        write("Enter employee gender: "),
        Z = stdio::readLine(),
        write("Enter employee birthday: "),
        W = stdio::readLine(),
        updateEmployee(X, toTerm(Y), toTerm(Z), toTerm(W)),
        printEmployees(),
        _ = stdio::readLine().

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class facts
    dep : (integer Id, name).

clauses
    dep(11, "Отдел продаж").
    dep(33, "Отдел рекламы").
    dep(22, "Отдел разработки").


class predicates
    printDepartments : ().
    updateDepartment : (integer Id, name).

clauses
    printDepartments() :-
        dep(Id, name),
        write(Id, "\t", name),
        nl,
        fail.
    printDepartments() :-
        write("All departments are shown above\n").

clauses
    updateDepartment(Id, name) :-
        retract(dep(Id, _)),
        asserta(dep(Id, name)),
        fail.
    updateDepartment(_, _).

clauses
    run() :-
        printDepartments(),
        write("Enter department id to update: "),
        X = toTerm(stdio::readLine()),
        write("Enter department name: "),
        Y = stdio::readLine(),
        updateDepartment(X, toTerm(Y)),
        printDepartments(),
        _ = stdio::readLine(),

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class facts
    position:(integer Id, name, name, integer Id).

clauses
    position(111, "Менеджер", "Отдел продажами", 11).
    position(112, "Маркетолог", "Отдел продажами", 11).
    position(113, "Бизнес-аналитик", "Отдел продажами", 11).
    position(221, "Программист", "Отдел разработки", 22).
    position(222, "Frontender", "Отдел разработки", 22).
    position(223, "Тестировщик", "Отдел разработки", 22).
    position(223, "Тестировщик", "Отдел разработки", 22).
    position(331, "SMM-менеджер ", "Отдел рекламы", 33).
    position(332, "Трафик-менеджер  ", "Отдел рекламы", 33).
    position(333, "Бренд-менеджер  ", "Отдел рекламы", 33).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class facts
    occupation:(integer Id, integer Id, name).
clauses
    occupation(1, 111, "2015, 9, 1").
    occupation(2, 112, "2010, 6, 1").
    occupation(3, 113, "2018, 1, 1").
    occupation(4, 221, "2012, 12, 12").
    occupation(5, 222, "2013, 10, 1").

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class facts
    salary:(integer Id, integer Salary).
clauses
    salary(1, 50000).
    salary(2, 80000).
    salary(3, 60000).
    salary(4, 99999).
    salary(5, 40000).

class predicates
    printSalaries: ().
    average_salary: ().
    increaseSalary: ().

clauses
    average_salary(Avg) :-
        findall(Salary, salary(_, Salary), Salaries),
        sum_list(Salaries, Total),
        length(Salaries, Count),
        Avg is Total / Count.

clauses
    printSalaries :-
        format("ID\tSalary~n"),
        forall(salary(ID, Salary),
               format("~w\t~w~n", [ID, Salary])).

clauses
    increaseSalary(Increase) :-
        retract(salary(ID, Salary)),
        NewSalary is Salary + Increase,
        assert(salary(ID, NewSalary)),
        fail.
    increaseSalary(_).

clauses
    run() :-
        printSalaries(),
        write("Enter a number to increase salaries: "),
        read_line_to_string(user_input, Input),
        atom_number(Input, Increase),
        increaseSalary(Increase),
        printSalaries(),
        average_salary(NewAvg),
        format("New Average Salary: ~w~n", [NewAvg]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class facts
    vacancy:(name, integer Salary).
clauses
    vacancy("Трафик-менеджер", 60000).
    vacancy("Бренд-менеджер", 80000).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class facts
    expenses:(integer Id, integer Salary).
clauses
    expenses(11, 100000).
    expenses(22, 150000).
    expenses(33, 90000).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class facts
    intern:(integer Id, name, string Gender, string Birthday).
clauses
    intern(8, "Смирнова Екатерина Александровна", "женский", "1995, 8, 25").

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class facts
    office:(integer Id, name).
clauses
    office(1111, "Москва").
    office(2222, "Санкт-Петербург").
    office(3333, "Душанбе").

class predicates
    printFindOffice: ().

clauses
    printFindOffice() :-
        office(Id, name),
        write(Id, ":\t", name, " - "),
        nl,
        fail.
    printFindOffice() :-
        nl.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class facts
    dismissal:(integer Id, name).
clauses
    dismissal(3, "Bob Johnson").
    dismissal(5, "Bob Johnson").

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class facts
    increase:(integer Id, name, integer Salary1, integer Salary1).

clauses
    increase(1, "John Smith", 50000, 70000).
    increase(2, "Jane Doe", 80000, 1000000).
    increase(4, "Alice Brown", 99999, 700000).

class predicates
    is_it_possible: (integer X, integer Y).

clauses
    is_it_possible(X, Y) :-
        X - Y < 25000,
        write("Можно").
    is_it_possible(X, Y) :-
        X - Y > 25000,
        write("Нельзя").

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class facts
    intern:(integer Id, name, string Gender, string Birthday).
clauses
    intern(8, "Смирнова Екатерина Александровна", "женский", "1995, 8, 25").

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end implement main

goal
    console::runUtf8(main::run).