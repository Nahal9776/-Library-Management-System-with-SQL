CREATE TABLE StorageSection (
    Storage_Section_ID SERIAL PRIMARY KEY,
    Section_Name VARCHAR(100) NOT NULL
);
CREATE TABLE LibraryAdministrator (
    Admin_ID SERIAL PRIMARY KEY,
    Admin_Name VARCHAR(100) NOT NULL
);
CREATE TABLE Catalog (
    Catalog_ID SERIAL PRIMARY KEY,
    Description TEXT,
    Condition VARCHAR(50),
    Availibility BOOLEAN,
    Admin_ID INT REFERENCES LibraryAdministrator(Admin_ID)
);
CREATE TABLE Publisher (
    ISBN VARCHAR(13) PRIMARY KEY,
    Publisher_Language VARCHAR(50)
);
CREATE TABLE Author (
    Author_Name VARCHAR(100) PRIMARY KEY,
    Author_Genre VARCHAR(50)
);
CREATE TABLE Patron (
    Patron_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100),
    PhoneNumber VARCHAR(20),
    BorrowingHistory TEXT
);
CREATE TABLE Reservation (
    Reservation_ID SERIAL PRIMARY KEY,
    Status VARCHAR(50),
    Reservation_Date DATE,
    Request_Date DATE
);
CREATE TABLE LateFee (
    Late_Fee_ID SERIAL PRIMARY KEY,
    Amount DECIMAL(10, 2) NOT NULL
);
CREATE TABLE TransactionReport (
    Transaction_ID SERIAL PRIMARY KEY,
    Return_Date DATE
);
CREATE TABLE Loan (
    Loan_ID SERIAL PRIMARY KEY,
    Return_Date DATE,
    Due_Date DATE,
    Check_Out_Date DATE,
    Late_Fee_ID INT REFERENCES LateFee(Late_Fee_ID),
    Transaction_ID INT REFERENCES TransactionReport(Transaction_ID)
);
CREATE TABLE Renewal (
    Renewal_ID SERIAL PRIMARY KEY,
    NewDueDate DATE NOT NULL,
    Subscription VARCHAR(255) NOT NULL,
    Transaction_ID INT NOT NULL,
    FOREIGN KEY (Transaction_ID) REFERENCES TransactionReport(Transaction_ID)
);
CREATE TABLE Book (
    Book_ID SERIAL PRIMARY KEY,
    Edition VARCHAR(50),
    Availibility BOOLEAN,
    ISBN VARCHAR(13) REFERENCES Publisher(ISBN),
    Author_Name VARCHAR(100) REFERENCES Author(Author_Name),
    Catalog_ID INT REFERENCES Catalog(Catalog_ID),
    Storage_Section_ID INT REFERENCES StorageSection(Storage_Section_ID),
    Patron_ID INT REFERENCES Patron(Patron_ID),
    Reservation_ID INT REFERENCES Reservation(Reservation_ID),
    Loan_ID INT REFERENCES Loan(Loan_ID)
);
