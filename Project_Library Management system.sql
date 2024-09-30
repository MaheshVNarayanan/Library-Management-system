create database library;
use library;

#create the table branch
create table Branch (
Branch_no int Primary key,
Manager_Id  int,
Branch_address varchar(50),
Contact_no int);

create table employee (
Emp_Id int Primary key,
Emp_name varchar(50),
Position varchar(50),
salary int,
Branch_no int,
foreign key (Branch_no) references Branch(Branch_no));

create table books(
ISBN varchar(20) Primary key,
book_title varchar(255),
Category varchar(255),
Rental_Price int,
Status varchar(3),
Author varchar(255),
Publisher varchar(255));

create table customer(
Customer_Id int primary key,
Customer_name varchar(50),
Customer_address varchar(255),
Reg_date date);

create table issueStatus(
Issue_Id  int primary key,
Issued_cust_id int,
Issued_book_name varchar(255),
Issue_date date,
Isbn_book varchar(20),
foreign key (Issued_cust_id) references customer(customer_Id),
foreign key (Isbn_book) references books(ISBN));

create table returnStatus(
Return_Id int Primary key,
Return_cust varchar(50),
Return_book_name varchar(255),
Return_date date,
Isbn_book2 varchar(20),
foreign key (Isbn_book2) references books(ISBN));

insert into branch(Branch_no,Manager_Id,Branch_address,Contact_no)
values (1,001,"Gandhinagar 2nd street",8547612),
(2,002,"In hariharnagar",9567612),
(3,003,"Mutharamkunnu P.O",9847617),
(4,004,"pondicheery inn",7547616),
(5,005,"4th place,right street",9647618);

INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no)
VALUES 
(101, 'Rohit Sharma', 'Manager', 75000, 1),
(102, 'Parthiv Patel', 'Manager', 72000, 2),
(103, 'Sandeep Kumar', 'Manager', 71000, 3),
(104, 'Priya Punia', 'Assistant', 45000, 1),
(105, 'Amitabh Bachhan', 'Assistant', 46000, 2),
(106, 'Shreyas Iyer', 'Assistant', 47000, 3);

INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher)
VALUES 
('978-81-932003-1-2', 'Mastering Python', 'Technology', 400, 'yes', 'Ravindra Joshi', 'Tech Publications'),
('978-93-5273-001-1', 'Java Fundamentals', 'Technology', 350, 'yes', 'Amit Singh', 'Pearson India'),
('978-81-291-2451-0', 'The White Tiger', 'Fiction', 300, 'no', 'Aravind Adiga', 'HarperCollins India'),
('978-93-86021-62-3', 'Thousand splenid suns', 'Fiction', 200, 'yes', 'Khaleed hosseini', 'Bloomsberry Publishing House'),
('978-81-7992-740-9', 'India After Gandhi', 'History', 450, 'no', 'Ramachandra Guha', 'HarperCollins India'),
('978-93-88322-32-1', 'Shiva trilogy', 'Fantasy', 250, 'yes', 'Amish tripathi', 'Westland Press');

INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date)
VALUES 
(201, 'Ankit Gupta', '12 Lokhandwala, Mumbai', '2021-12-01'),
(202, 'Sakshi singh', '34 Jayanagar, Bangalore', '2022-01-15'),
(203, 'Abhinav Mehta', '56 Salt Lake, Kolkata', '2021-06-18'),
(204, 'Kavita Patil', '78 Andheri, Mumbai', '2023-05-25'),
(205, 'Nitish Reddy', '90 Koramangala, Bangalore', '2022-07-12');

INSERT INTO IssueStatus (Issue_Id, Issued_cust_id, Issued_book_name, Issue_date, Isbn_book)
VALUES 
(301, 201, 'Mastering Python', '2023-06-01', '978-81-932003-1-2'),
(302, 202, 'Java Fundamentals', '2023-06-05', '978-93-5273-001-1'),
(303, 203, 'Thousand Splendid suns', '2023-07-01', '978-93-86021-62-3');

INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2)
VALUES 
(401, 201, 'Mastering Python', '2023-06-10', '978-81-932003-1-2'),
(402, 202, 'Java Fundamentals', '2023-06-20', '978-93-5273-001-1'),
(403, 203, 'Thousand Splendid suns', '2023-07-10', '978-93-86021-62-3');


#Retrieve the book title, category, and rental price of all available books.

select book_title,Category,Rental_Price from books where status ="yes";

#List the employee names and their respective salaries in descending order of salary

select Emp_name,salary from employee order by salary desc;

# Retrieve the book titles and the corresponding customers who have issued those books.

Select books.book_title,customer.Customer_name from issuestatus join books on books.ISBN=issuestatus.Isbn_book
join customer on customer.Customer_Id=issuestatus.Issued_cust_id;



#Display the total count of books in each category

select Category,count(*) as total_books from books group by Category;

#Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000. 

select Emp_name,Position from employee where salary>50000;

#List the customer names who registered before 2022-01-01 and have not issued any books yet.
select customer.Customer_name from customer 
left join issuestatus on customer.Customer_Id=issuestatus.Issued_cust_id where
customer.Reg_date <"2022-01-01" and issuestatus.Issued_cust_id is Null;


# Display the branch numbers and the total count of employees in each branch.

select Branch_no,count(*) as total_empployees from branch group by Branch_no;

#Display the names of customers who have issued books in the month of June 2023.
SELECT Customer.Customer_name FROM IssueStatus 
JOIN Customer ON issuestatus.Issued_cust_id = Customer.Customer_Id
WHERE Issue_date BETWEEN '2023-06-01' AND '2023-06-30';

#Retrieve book_title from book table containing history

Select book_title from books where Category ="History"; -- Just in case-Couldn't understand the Qn fully)

select book_title from books where book_title like "%history%"; # no output

#Retrieve the branch numbers along with the count of employees for branches having more than 5 employees

select Branch_no,Count(*) as count_of_employees from employee group by Branch_no having Count(*) >5;

#Retrieve the names of employees who manage branches and their respective branch addresses.

Select employee.Emp_name,branch.Branch_address
from employee join branch on employee.Emp_Id=branch.Manager_Id;

# Display the names of customers who have issued books with a rental price higher than Rs. 25.

select customer.Customer_name
from issuestatus join books on books.ISBN=issuestatus.Isbn_book
join customer on issuestatus.Issued_cust_id=customer.Customer_Id
where books.Rental_Price >25;