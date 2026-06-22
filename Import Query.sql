CREATE TABLE nyc_inspection (
    camis                  BIGINT,
    dba                    VARCHAR(255),
    boro                   VARCHAR(50),
    street                 VARCHAR(255),
    cuisine_description    VARCHAR(100),
    inspection_date        DATE,
    action                 TEXT,
    violation_code         VARCHAR(10),
    violation_description  TEXT,
    critical_flag          VARCHAR(20),
    score                  INT,
    grade                  CHAR(1),
    grade_date             DATE,
    inspection_type        VARCHAR(100),
    nta                    VARCHAR(10)
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/nyc_inspection(AutoRecovered).csv'
INTO TABLE nyc_inspection
CHARACTER SET latin1
FIELDS TERMINATED BY ','
		ENCLOSED BY '"'
		ESCAPED BY '\\'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS     
(camis,dba,boro,street,cuisine_description,@raw_inspection_date,action,violation_code,
violation_description,critical_flag,@raw_score,grade,@raw_grade_date,inspection_type,nta)
SET
	inspection_date = IF(@raw_inspection_date = '', NULL,STR_TO_DATE(@raw_inspection_date, '%m/%d/%Y')),
	grade_date = IF(@raw_grade_date = '', NULL,STR_TO_DATE(@raw_grade_date, '%m/%d/%Y')),
    score = IF(@raw_score = '',NULL, CAST(@raw_score AS SIGNED))
;
