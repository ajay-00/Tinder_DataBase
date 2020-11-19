DROP TABLE Tinder_User CASCADE CONSTRAINTS;
DROP TABLE Profile;
DROP TABLE Location;
DROP TABLE Membership CASCADE CONSTRAINTS;
DROP TABLE Other_User;
DROP TABLE Report; 
DROP TABLE Unmatch;
DROP TABLE Messages;

CREATE TABLE Tinder_User (
    unique_id NUMBER,   
    user_name VARCHAR2(40 CHAR) NOT NULL,
    CONSTRAINT tinder_user PRIMARY KEY(unique_id)
);

INSERT INTO Tinder_User(unique_id, user_name)
VALUES (1,'Tim');

INSERT INTO Tinder_User(unique_id, user_name)
VALUES (2,'Bob');

INSERT INTO Tinder_User(unique_id, user_name)
VALUES (3,'Alex');

INSERT INTO Tinder_User(unique_id, user_name)
VALUES (4,'Mike');

INSERT INTO Tinder_User(unique_id, user_name)
VALUES (5,'Jenifer');


--Query
SELECT unique_id,user_name FROM Tinder_User 
WHERE unique_id = 5;

SELECT unique_id,user_name FROM Tinder_User 
WHERE user_name='Alex';

SELECT unique_id,user_name FROM Tinder_User 
WHERE unique_id > 2;





CREATE TABLE Membership(
    membership_id NUMBER,
    status NUMBER NOT NULL,
    CONSTRAINT membership_id PRIMARY KEY(membership_id)
);

INSERT INTO Membership(membership_id, status)
VALUES (1,1);

INSERT INTO Membership(membership_id, status)
VALUES (2,0);

INSERT INTO Membership(membership_id, status)
VALUES (3,1);

INSERT INTO Membership(membership_id, status)
VALUES (4,0);

INSERT INTO Membership(membership_id, status)
VALUES (5,1);

--Query
SELECT membership_id,status FROM Membership 
WHERE status > 0;

SELECT membership_id,status FROM Membership 
WHERE membership_id = 4;


CREATE TABLE Profile (
    profile_key NUMBER,
    profile_user NUMBER,
    gender_prefrences VARCHAR2(2 CHAR) NOT NULL, 
    user_gender VARCHAR2(20 CHAR) NOT NULL,
    education VARCHAR2(100 CHAR),
    about_me VARCHAR2 (2000 CHAR),
    hobbies VARCHAR2 (2000 CHAR),
    profile_name VARCHAR2 (40 CHAR),
    birth_date DATE NOT NULL, 
    age NUMBER NOT NULL CHECK(age >= 18),  
    membership_status CHAR(1) NOT NULL,
    membership_id_profile NUMBER, 
    CONSTRAINT profile_number FOREIGN KEY(profile_user) REFERENCES Tinder_User(unique_id),
    CONSTRAINT membership_number FOREIGN KEY(membership_id_profile) REFERENCES Membership(membership_id),
    CONSTRAINT profile_key PRIMARY KEY(profile_key)  
);



INSERT INTO Profile(profile_key, profile_user, gender_prefrences, user_gender,
                    profile_name, birth_date,age, membership_status, membership_id_profile)
VALUES (1,1,'g', 'm','Tim', to_date('04/10/2000','dd/mm/yyyy'), 20,1,1);

INSERT INTO Profile(profile_key, profile_user, gender_prefrences, user_gender,
                    profile_name, birth_date,age, membership_status, membership_id_profile)
VALUES (2,2,'g', 'm','Bob', to_date('04/10/1995','dd/mm/yyyy'), 25,0,2);

INSERT INTO Profile(profile_key, profile_user, gender_prefrences, user_gender,
                    profile_name, birth_date,age, membership_status, membership_id_profile)
VALUES (3,3,'m', 'g','Alex', to_date('04/10/1998','dd/mm/yyyy'), 22,1,3);

INSERT INTO Profile(profile_key, profile_user, gender_prefrences, user_gender,
                    profile_name, birth_date,age, membership_status, membership_id_profile)
VALUES (4,4,'g', 'm','Mike', to_date('04/10/2000','dd/mm/yyyy'), 20,0,4);

INSERT INTO Profile(profile_key, profile_user, gender_prefrences, user_gender,
                    profile_name, birth_date,age, membership_status, membership_id_profile)
VALUES (5,5,'m', 'g','Jenifer', to_date('04/10/2000','dd/mm/yyyy'), 20,1,5);


--Query
SELECT profile_name, user_gender, age FROM Profile 
WHERE user_gender = 'g';

SELECT profile_name, user_gender, age FROM Profile 
WHERE age >20;

SELECT profile_name, user_gender, age FROM Profile 
WHERE user_gender = 'm' AND age >20;

SELECT profile_name, user_gender, age FROM Profile 
WHERE user_gender = 'm' OR age >20;

SELECT profile_name, user_gender, age FROM Profile 
ORDER BY age ASC;

SELECT profile_name, user_gender, age FROM Profile 
WHERE membership_status = 1;


CREATE TABLE Location (
    location_id NUMBER,
    user_id_loc NUMBER,
    longitude DECIMAL, 
    latitude DECIMAL,
    CONSTRAINT location_now_id PRIMARY KEY(location_id),
    CONSTRAINT profile_number_loc FOREIGN KEY(user_id_loc) REFERENCES Tinder_User(unique_id)
);

INSERT INTO Location(location_id, user_id_loc,longitude, latitude)
VALUES (1,1,43.6532,79.3832);

INSERT INTO Location(location_id, user_id_loc,longitude, latitude)
VALUES (2,2,43.6532,79.3832);

INSERT INTO Location(location_id, user_id_loc,longitude, latitude)
VALUES (3,3,43.6532,79.3832);

INSERT INTO Location(location_id, user_id_loc,longitude, latitude)
VALUES (4,4,45.5017,73.5673);

INSERT INTO Location(location_id, user_id_loc,longitude, latitude)
VALUES (5,5,45.5017,73.5673);


CREATE TABLE Other_User (
    other_user NUMBER,
    CONSTRAINT other_user_id FOREIGN KEY(other_user) REFERENCES Tinder_User(unique_id)
);

INSERT INTO Other_User(other_user)
VALUES (1);

INSERT INTO Other_User(other_user)
VALUES (2);

INSERT INTO Other_User(other_user)
VALUES (3);

INSERT INTO Other_User(other_user)
VALUES (4);

INSERT INTO Other_User(other_user)
VALUES (5);



CREATE TABLE Unmatch (
    unmatch_user_id NUMBER,
    CONSTRAINT unmatch_user_id FOREIGN KEY(unmatch_user_id) REFERENCES Tinder_User(unique_id)
);
INSERT INTO Unmatch(unmatch_user_id)
VALUES (1);


CREATE TABLE Report (
    report_user_id NUMBER,
    CONSTRAINT report_user_id FOREIGN KEY(report_user_id) REFERENCES Tinder_User(unique_id)
);
INSERT INTO Report(report_user_id)
VALUES (1);

CREATE TABLE Messages (
    message_id NUMBER, 
    read_message CHAR(1) NOT NULL,
    time_sent TIMESTAMP NOT NULL,
    message_content VARCHAR2(2000 CHAR),
    other_userid NUMBER, 
    user_id  NUMBER , 
    CONSTRAINT message_id PRIMARY KEY(message_id),
    CONSTRAINT other_id FOREIGN KEY(other_userid) REFERENCES Tinder_User(unique_id),
    CONSTRAINT user_id FOREIGN KEY(user_id) REFERENCES Tinder_User(unique_id)
);

INSERT INTO Messages(message_id, read_message, time_sent, message_content, other_userid, user_id)
VALUES (1,1, CURRENT_TIMESTAMP,'hello', 3,1);

--Query
SELECT message_id, time_sent, message_content, other_userid , user_id FROM Messages 
WHERE read_message = 1;

