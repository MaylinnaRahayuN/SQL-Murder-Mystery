/*
Query dihasilkan dari command yang disediakan pada web: https://mystery.knightlab.com/
- mengecek daftar nama tabel
SELECT name 
  FROM sqlite_master
 where type = 'table'

- mengecek susunan kolom dari setiap tabel
 SELECT sql 
  FROM sqlite_master
 where name = 'crime_scene_report'
*/

--membuat Tabel crime_scene_report
CREATE TABLE crime_scene_report ( date integer, type text, description text, city text );

--membuat Tabel drivers_license
CREATE TABLE drivers_license ( id integer PRIMARY KEY, age integer, height integer, eye_color text, 
hair_color text, gender text, plate_number text, car_make text, car_model text );

--membuat Tabel income
CREATE TABLE income (ssn CHAR PRIMARY KEY, annual_income integer)

--membuat Tabel person
CREATE TABLE person (id integer PRIMARY KEY, name text, license_id integer, address_number integer, 
address_street_name text, ssn CHAR 
REFERENCES income (ssn), 
FOREIGN KEY (license_id) 
REFERENCES drivers_license (id))

--membuat Tabel facebook_event_checkin
CREATE TABLE facebook_event_checkin ( person_id integer, event_id integer, 
event_name text, date integer, FOREIGN KEY (person_id) REFERENCES person(id));

--membuat Tabel interview
CREATE TABLE interview ( person_id integer, transcript text, 
FOREIGN KEY (person_id) 
REFERENCES person(id) )

--membuat Tabel get_fit_now_member
CREATE TABLE get_fit_now_member ( id text PRIMARY KEY, person_id integer, 
name text, membership_start_date integer, membership_status text, 
FOREIGN KEY (person_id) REFERENCES person(id) )

--membuat Tabel get_fit_now_member
CREATE TABLE get_fit_now_check_in ( membership_id text, check_in_date integer, 
check_in_time integer, check_out_time integer, FOREIGN KEY (membership_id) 
REFERENCES get_fit_now_member(id) )


--impor data dari CSV ke tabel PostgreSQL
COPY crime_scene_report 
FROM 'D:/SQL Murder Mystery/exported_csv_proper/crime_scene_report.csv' DELIMITER ',' CSV HEADER;
select * from crime_scene_report;

COPY drivers_license 
FROM 'D:/SQL Murder Mystery/exported_csv_proper/drivers_license.csv' DELIMITER ',' CSV HEADER;
select * from drivers_license;

/* ADA EROR=> perlu perbaikan dengan mengatur 
ERROR:  nilai terlalu panjang untuk tipe character(1)
CONTEXT:  COPY income, line 2, column ssn: "100009868"
*/
 --Ubah dulu tipe kolom ssn
ALTER TABLE income
ALTER COLUMN ssn TYPE VARCHAR(11);


COPY income FROM 'D:/SQL Murder Mystery/exported_csv_proper/income.csv' DELIMITER ',' CSV HEADER;
select * from income;
SELECT COUNT(*) FROM income;

ALTER TABLE person
ALTER COLUMN ssn TYPE VARCHAR(11);

COPY person FROM 'D:/SQL Murder Mystery/exported_csv_proper/person_filtered.csv' DELIMITER ',' CSV HEADER;
select * from person;


COPY facebook_event_checkin
FROM 'D:/SQL Murder Mystery/exported_csv_proper/facebook_event_checkin_FINAL.csv'
DELIMITER ',' 
CSV HEADER;

select * from facebook_event_checkin ;


COPY interview(person_id, transcript)
FROM 'D:/SQL Murder Mystery/exported_csv_proper/interview_FINAL.csv'
DELIMITER ','
CSV HEADER;

select * from interview;


COPY get_fit_now_member 
FROM 'D:/SQL Murder Mystery/exported_csv_proper/get_fit_now_member_FINAL.csv' DELIMITER ',' CSV HEADER;
select * from get_fit_now_member;

COPY get_fit_now_check_in 
FROM 'D:/SQL Murder Mystery/exported_csv_proper/get_fit_now_check_in_FINAL.csv' 
DELIMITER ',' 
CSV HEADER;
select * from get_fit_now_check_in;


					--INVESTIGASI--
--kejadian apa aja ditanggal 15 januari 2018?
SELECT * FROM crime_scene_report 
WHERE date=20180115 AND city='SQL City';

-- ada 2 saksi, mari cek satu persatu

--saksi pertama tinggal di Northwestern Dr
 SELECT * FROM person 
 WHERE address_street_name='Northwestern Dr' order by address_number;

--saksi kedua nama Annable, tinggal di Franklin Ave
SELECT * FROM person 
WHERE address_street_name='Franklin Ave' And name like 'Annabel%';

--cek keterangan saksi dengan ID (14887, 16371) dari tabel interview
SELECT * FROM interview
WHERE person_id IN (14887, 16371);


--macth dari keterangan, saksi kedua ketemu 9 januari 2018, saksi pertama liat membership gym berawalan 48Z
SELECT * FROM get_fit_now_check_in
WHERE check_in_date=20180109;

--ada 2 orang dgn awalan membership itu
SELECT * FROM get_fit_now_member 
WHERE id IN('48Z55','48Z7A');

--oke sekarang cek namanya
SELECT * FROM person 
where id in (28819,67318);

--cek platnnomornya dari driver_license
SELECT * FROM drivers_license 
where id in (173289, 423327);

--hanya si 423327 yg bisa jadi suspect karna dia punya license dan platnya 0H42W2 sesuai saksi 1 bilang
SELECT * FROM drivers_license where id in (173289, 423327);

--YAP Si 423327 menjadi suspect karna paling sesuai dengan keterangan 2 saksi
INSERT INTO solution VALUES (1, 'Jeremy Bowers');     
        SELECT value FROM solution;

-- OMG dia pembunuhnya, tapi ada dalang lagi dibelakangnya? wait whooo? okk ayo cekk siapa dia!!
select * from interview 
where person_id= 67318;

--Oke dia menyebut she, berati dia seorang perempuan,  
--sebelumnya mari kita cek penyebutan gender pada Tabel driver_license
SELECT gender FROM drivers_license
--penyebutannya female,male

SELECT car_make FROM drivers_license;
--oke car_make berisi nama nama jenis mobil

SELECT car_model FROM drivers_license;
SELECT hair_color FROM drivers_license;

--Setelah itu mari detailkan bahwa dia seorang perempuan, dengan hair_color nya red, 
--Car_make nya Tesla, dan car_model nya Model S, 
--SQL Symphony Concert pada December 2017 sebanyak 3 kali
SELECT * FROM drivers_license where gender='female' 
AND car_make LIKE 'Tesla%' AND car_model ='Model S' AND hair_color='red';

--Oke kita mendaptkan 3 license_id, dan mari cek siapa mereka
SELECT * FROM person WHERE license_id IN (202298,291182, 918773);

--setelah mendaptkan nama dan id mereka, mari kita cek 
--siapa diantara mereka yg hadir di SQL Symphony Concert pada December 2017 sebanyak 3 kali
SELECT * FROM facebook_event_checkin 
WHERE person_id IN (78881,90700,99716) AND  event_name='SQL Symphony Concert';

--dan ya hanya si id 99716 yang hadir di event itu, maka dialah VILLAIN nyaa
SELECT * FROM person
where id=99716;

--submit deh
INSERT INTO solution VALUES (1, 'Miranda Priestly');
        
        SELECT value FROM solution;




--SEKIANNN,
-----Mayyy(6/7/25)