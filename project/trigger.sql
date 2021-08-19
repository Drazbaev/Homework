DELIMITER //
CREATE TRIGGER validate_name_description_update BEFORE UPDATE ON goods
FOR EACH ROW BEGIN
  IF NEW.name IS NULL AND NEW.description IS NULL THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Both product name and product description are NULL';
  END IF;
END//
