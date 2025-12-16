-- File: init.sql
-- 1. Tạo Database nếu chưa tồn tại
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'TodoDbLocal')
BEGIN
    CREATE DATABASE TodoDbLocal;
END
GO

USE TodoDbLocal;
GO

-- 2. Tạo bảng Todos nếu chưa tồn tại
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Todos]') AND type in (N'U'))
BEGIN
    CREATE TABLE Todos (
        Id INT PRIMARY KEY IDENTITY(1,1),
        Title NVARCHAR(255) NOT NULL,
        IsCompleted BIT DEFAULT 0,
        CreatedAt DATETIME DEFAULT GETDATE(),
        DueDate DATETIME NULL
    );
END
GO

-- 3. Cấp quyền cho user 'sa' (Fix lỗi 500)
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'sa')
BEGIN
    CREATE USER sa FOR LOGIN sa;
    ALTER ROLE db_owner ADD MEMBER sa;
END
GO

IF NOT EXISTS (SELECT top 1 * FROM Todos)
BEGIN
    INSERT INTO Todos (Title) VALUES (N'Learn Docker Automate Init');

    INSERT INTO Todos (Title) VALUES (N'Learn SQL Server');

    INSERT INTO Todos (Title, IsCompleted) VALUES (N'Learn Entity Framework Core', 1);
END
GO