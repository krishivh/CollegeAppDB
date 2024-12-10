-- insert into User table
INSERT INTO `User` (firstName, lastName, email, phone, password, highSchool, GPA)
VALUES
('Alice', 'Smith', 'alice.smith@example.com', '1234567890', 'Password1!', 'Lincoln High', 3.8),
('Bob', 'Johnson', 'bob.johnson@example.com', '2345678901', 'SecureP@ss1', 'Roosevelt High', 3.6),
('Charlie', 'Brown', 'charlie.brown@example.com', '3456789012', 'Ch@rlie123', 'Washington High', 3.9),
('Diana', 'Prince', 'diana.prince@example.com', '4567890123', 'WonderW0m@n', 'Jefferson High', 4.0),
('Edward', 'Elric', 'edward.elric@example.com', '5678901234', 'Alch3my!', 'Central High', 3.7),
('Fiona', 'Gallagher', 'fiona.g@example.com', '6789012345', 'F!ona2024', 'Grant High', 3.4),
('George', 'Michaels', 'george.m@example.com', '7890123456', 'George$77', 'Adams High', 3.5),
('Hannah', 'Montana', 'hannah.m@example.com', '8901234567', 'Hannah99#', 'Monroe High', 3.6),
('Isaac', 'Newton', 'isaac.n@example.com', '9012345678', 'F0rce!99', 'Newton High', 3.9),
('Jack', 'Sparrow', 'jack.s@example.com', '1234567891', 'Pir@te007', 'Caribbean High', 3.2),
('Karen', 'Walker', 'karen.w@example.com', '2345678912', 'Karen@2023', 'Walker High', 3.3),
('Liam', 'Hemsworth', 'liam.h@example.com', '3456789123', 'Li@M1234', 'Hollywood High', 3.7),
('Megan', 'Fox', 'megan.f@example.com', '4567891234', 'M3gan$$9', 'Fox High', 3.8),
('Nathan', 'Drake', 'nathan.d@example.com', '5678912345', 'Adventur3!', 'Drake High', 3.6),
('Olivia', 'Pope', 'olivia.p@example.com', '6789123456', 'Fix3r!!99', 'Pope High', 3.9);

-- insert into Colleges table
INSERT INTO `Colleges` (name, location, yearFounded, averageGPA, userID)
VALUES
('Harvard University', 'Cambridge, MA', 1636, 3.8, 1),
('Stanford University', 'Stanford, CA', 1885, 3.9, 2),
('MIT', 'Cambridge, MA', 1861, 4.0, 3),
('UC Berkeley', 'Berkeley, CA', 1868, 3.7, 4),
('Caltech', 'Pasadena, CA', 1891, 3.9, 5),
('Princeton University', 'Princeton, NJ', 1746, 3.8, 6),
('Yale University', 'New Haven, CT', 1701, 3.7, 7),
('Columbia University', 'New York, NY', 1754, 3.8, 8),
('UChicago', 'Chicago, IL', 1890, 3.7, 9),
('UPenn', 'Philadelphia, PA', 1740, 3.6, 10),
('Duke University', 'Durham, NC', 1838, 3.8, 11),
('UCLA', 'Los Angeles, CA', 1919, 3.7, 12),
('University of Michigan', 'Ann Arbor, MI', 1817, 3.6, 13),
('Cornell University', 'Ithaca, NY', 1865, 3.7, 14),
('Brown University', 'Providence, RI', 1764, 3.6, 15);

-- insert into Applications table
INSERT INTO `Applications` (submissionStatus, applicationDeadline, userID, applicationType, collegeName)
VALUES
('Submitted', '2024-01-15', 1, 'Early Decision', 'Harvard University'),
('Pending', '2024-02-01', 2, 'Regular Decision', 'Stanford University'),
('Reviewed', '2024-03-01', 3, 'Early Action', 'MIT'),
('Accepted', '2024-04-15', 4, 'Regular Decision', 'UC Berkeley'),
('Rejected', '2024-05-01', 5, 'Regular Decision', 'Caltech'),
('Waitlisted', '2024-06-01', 6, 'Early Action', 'Princeton University'),
('Submitted', '2024-01-20', 7, 'Regular Decision', 'Yale University'),
('Pending', '2024-02-05', 8, 'Early Decision', 'Columbia University'),
('Reviewed', '2024-03-10', 9, 'Regular Decision', 'UChicago'),
('Accepted', '2024-04-20', 10, 'Regular Decision', 'UPenn'),
('Rejected', '2024-05-05', 11, 'Regular Decision', 'Duke University'),
('Waitlisted', '2024-06-10', 12, 'Early Action', 'UCLA'),
('Submitted', '2024-01-25', 13, 'Regular Decision', 'University of Michigan'),
('Pending', '2024-02-10', 14, 'Early Decision', 'Cornell University'),
('Reviewed', '2024-03-15', 15, 'Regular Decision', 'Brown University');

-- insert into Tasks table
INSERT INTO `Tasks` (taskName, dueDate, userID)
VALUES
('Write personal statement', '2023-12-01', 1),
('Submit transcript', '2023-12-05', 2),
('Complete FAFSA', '2023-12-10', 3),
('Request recommendation letters', '2023-12-15', 4),
('Finalize college list', '2023-12-20', 5),
('Review application essays', '2023-12-25', 6),
('Submit early decision applications', '2024-01-01', 7),
('Follow up with recommenders', '2024-01-05', 8),
('Check application statuses', '2024-01-10', 9),
('Prepare for interviews', '2024-01-15', 10),
('Apply for scholarships', '2024-01-20', 11),
('Create a college budget plan', '2024-01-25', 12),
('Plan college visits', '2024-01-30', 13),
('Submit regular decision applications', '2024-02-05', 14),
('Prepare for decision day', '2024-02-10', 15);

-- When launching the project, edit the run configurations and select Smart Tomcat.
