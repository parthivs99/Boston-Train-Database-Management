USE master;
GO
SELECT *
FROM sys.symmetric_keys
WHERE name = '##MS_ServiceMasterKey##';
GO

-- Create database Key
USE Test;
GO
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Password123';
GO

-- Create self signed certificate
USE Test;
GO
CREATE CERTIFICATE Certificate1
WITH SUBJECT = 'Protect Data';
GO

-- Create symmetric Key
USE Test;
GO
CREATE SYMMETRIC KEY SymmetricKey1 
 WITH ALGORITHM = AES_128 
 ENCRYPTION BY CERTIFICATE Certificate1;
GO

USE Test;
GO
ALTER TABLE Payment 
ADD Credit_card_number_encrypt varbinary(MAX) NULL
GO

-- Populating encrypted data into new column
USE Test;
GO
-- Opens the symmetric key for use
OPEN SYMMETRIC KEY SymmetricKey1
DECRYPTION BY CERTIFICATE Certificate1;
GO


UPDATE Payment
SET Credit_card_number_encrypt = EncryptByKey (Key_GUID('SymmetricKey1'),CardNumber)
FROM Payment;
GO
-- Closes the symmetric key
CLOSE SYMMETRIC KEY SymmetricKey1;
GO


SELECT * FROM Payment

USE Test;
GO
ALTER TABLE Customer_data
DROP COLUMN CardNumber;
GO


