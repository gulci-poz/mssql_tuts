/*
Konwencje nazewnicze:
- nazwa bazy - camel case, firma + nazwa
- nazwa tabeli - liczba mnoga od elementów, które zawiera; może też być liczba pojedyncza
- opcjonalnie prefix tbl do tablicy
- Id lub CustomerId - będzie więcej pisania, mamy redundantną informację; ma to sens przy tabeli CustomerOrders
- camel case lub underscore
*/

DROP DATABASE DataBizCustomers
CREATE DATABASE DataBizCustomers

USE DataBizCustomers;

DROP TABLE Customers;

CREATE TABLE Customers (
    Id INT
);

CREATE TABLE Orders (
    Id INT
);

CREATE TABLE CustomerOrders (
    CustomerId INT
    , OrderID INT
);
