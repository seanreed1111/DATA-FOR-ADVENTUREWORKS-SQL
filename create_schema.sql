--
-- PostgreSQL database dump
--

-- Dumped from database version 13.0 (Debian 13.0-1.pgdg100+1)
-- Dumped by pg_dump version 13.0 (Debian 13.0-1.pgdg100+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: hr; Type: SCHEMA; Schema: -; Owner: adventureworks_user
--

CREATE SCHEMA hr;


ALTER SCHEMA hr OWNER TO adventureworks_user;

--
-- Name: humanresources; Type: SCHEMA; Schema: -; Owner: adventureworks_user
--

CREATE SCHEMA humanresources;


ALTER SCHEMA humanresources OWNER TO adventureworks_user;

--
-- Name: SCHEMA humanresources; Type: COMMENT; Schema: -; Owner: adventureworks_user
--

COMMENT ON SCHEMA humanresources IS 'Contains objects related to employees and departments.';


--
-- Name: pe; Type: SCHEMA; Schema: -; Owner: adventureworks_user
--

CREATE SCHEMA pe;


ALTER SCHEMA pe OWNER TO adventureworks_user;

--
-- Name: person; Type: SCHEMA; Schema: -; Owner: adventureworks_user
--

CREATE SCHEMA person;


ALTER SCHEMA person OWNER TO adventureworks_user;

--
-- Name: SCHEMA person; Type: COMMENT; Schema: -; Owner: adventureworks_user
--

COMMENT ON SCHEMA person IS 'Contains objects related to names and addresses of customers, vendors, and employees';


--
-- Name: pr; Type: SCHEMA; Schema: -; Owner: adventureworks_user
--

CREATE SCHEMA pr;


ALTER SCHEMA pr OWNER TO adventureworks_user;

--
-- Name: production; Type: SCHEMA; Schema: -; Owner: adventureworks_user
--

CREATE SCHEMA production;


ALTER SCHEMA production OWNER TO adventureworks_user;

--
-- Name: SCHEMA production; Type: COMMENT; Schema: -; Owner: adventureworks_user
--

COMMENT ON SCHEMA production IS 'Contains objects related to products, inventory, and manufacturing.';


--
-- Name: pu; Type: SCHEMA; Schema: -; Owner: adventureworks_user
--

CREATE SCHEMA pu;


ALTER SCHEMA pu OWNER TO adventureworks_user;

--
-- Name: purchasing; Type: SCHEMA; Schema: -; Owner: adventureworks_user
--

CREATE SCHEMA purchasing;


ALTER SCHEMA purchasing OWNER TO adventureworks_user;

--
-- Name: SCHEMA purchasing; Type: COMMENT; Schema: -; Owner: adventureworks_user
--

COMMENT ON SCHEMA purchasing IS 'Contains objects related to vendors and purchase orders.';


--
-- Name: sa; Type: SCHEMA; Schema: -; Owner: adventureworks_user
--

CREATE SCHEMA sa;


ALTER SCHEMA sa OWNER TO adventureworks_user;

--
-- Name: sales; Type: SCHEMA; Schema: -; Owner: adventureworks_user
--

CREATE SCHEMA sales;


ALTER SCHEMA sales OWNER TO adventureworks_user;

--
-- Name: SCHEMA sales; Type: COMMENT; Schema: -; Owner: adventureworks_user
--

COMMENT ON SCHEMA sales IS 'Contains objects related to customers, sales orders, and sales territories.';


--
-- Name: tablefunc; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS tablefunc WITH SCHEMA public;


--
-- Name: EXTENSION tablefunc; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION tablefunc IS 'functions that manipulate whole tables, including crosstab';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: AccountNumber; Type: DOMAIN; Schema: public; Owner: adventureworks_user
--

CREATE DOMAIN public."AccountNumber" AS character varying(15);


ALTER DOMAIN public."AccountNumber" OWNER TO adventureworks_user;

--
-- Name: Flag; Type: DOMAIN; Schema: public; Owner: adventureworks_user
--

CREATE DOMAIN public."Flag" AS boolean NOT NULL;


ALTER DOMAIN public."Flag" OWNER TO adventureworks_user;

--
-- Name: Name; Type: DOMAIN; Schema: public; Owner: adventureworks_user
--

CREATE DOMAIN public."Name" AS character varying(50);


ALTER DOMAIN public."Name" OWNER TO adventureworks_user;

--
-- Name: NameStyle; Type: DOMAIN; Schema: public; Owner: adventureworks_user
--

CREATE DOMAIN public."NameStyle" AS boolean NOT NULL;


ALTER DOMAIN public."NameStyle" OWNER TO adventureworks_user;

--
-- Name: OrderNumber; Type: DOMAIN; Schema: public; Owner: adventureworks_user
--

CREATE DOMAIN public."OrderNumber" AS character varying(25);


ALTER DOMAIN public."OrderNumber" OWNER TO adventureworks_user;

--
-- Name: Phone; Type: DOMAIN; Schema: public; Owner: adventureworks_user
--

CREATE DOMAIN public."Phone" AS character varying(25);


ALTER DOMAIN public."Phone" OWNER TO adventureworks_user;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: department; Type: TABLE; Schema: humanresources; Owner: adventureworks_user
--

CREATE TABLE humanresources.department (
    departmentid integer NOT NULL,
    name public."Name" NOT NULL,
    groupname public."Name" NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE humanresources.department OWNER TO adventureworks_user;

--
-- Name: TABLE department; Type: COMMENT; Schema: humanresources; Owner: adventureworks_user
--

COMMENT ON TABLE humanresources.department IS 'Lookup table containing the departments within the Adventure Works Cycles company.';


--
-- Name: COLUMN department.departmentid; Type: COMMENT; Schema: humanresources; Owner: adventureworks_user
--

COMMENT ON COLUMN humanresources.department.departmentid IS 'Primary key for Department records.';


--
-- Name: COLUMN department.name; Type: COMMENT; Schema: humanresources; Owner: adventureworks_user
--

COMMENT ON COLUMN humanresources.department.name IS 'Name of the department.';


--
-- Name: COLUMN department.groupname; Type: COMMENT; Schema: humanresources; Owner: adventureworks_user
--

COMMENT ON COLUMN humanresources.department.groupname IS 'Name of the group to which the department belongs.';


--
-- Name: d; Type: VIEW; Schema: hr; Owner: adventureworks_user
--

CREATE VIEW hr.d AS
 SELECT department.departmentid AS id,
    department.departmentid,
    department.name,
    department.groupname,
    department.modifieddate
   FROM humanresources.department;


ALTER TABLE hr.d OWNER TO adventureworks_user;

--
-- Name: employee; Type: TABLE; Schema: humanresources; Owner: adventureworks_user
--

CREATE TABLE humanresources.employee (
    businessentityid integer NOT NULL,
    nationalidnumber character varying(15) NOT NULL,
    loginid character varying(256) NOT NULL,
    jobtitle character varying(50) NOT NULL,
    birthdate date NOT NULL,
    maritalstatus character(1) NOT NULL,
    gender character(1) NOT NULL,
    hiredate date NOT NULL,
    salariedflag public."Flag" DEFAULT true NOT NULL,
    vacationhours smallint DEFAULT 0 NOT NULL,
    sickleavehours smallint DEFAULT 0 NOT NULL,
    currentflag public."Flag" DEFAULT true NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    organizationnode character varying DEFAULT '/'::character varying,
    CONSTRAINT "CK_Employee_BirthDate" CHECK (((birthdate >= '1930-01-01'::date) AND (birthdate <= (now() - '18 years'::interval)))),
    CONSTRAINT "CK_Employee_Gender" CHECK ((upper((gender)::text) = ANY (ARRAY['M'::text, 'F'::text]))),
    CONSTRAINT "CK_Employee_HireDate" CHECK (((hiredate >= '1996-07-01'::date) AND (hiredate <= (now() + '1 day'::interval)))),
    CONSTRAINT "CK_Employee_MaritalStatus" CHECK ((upper((maritalstatus)::text) = ANY (ARRAY['M'::text, 'S'::text]))),
    CONSTRAINT "CK_Employee_SickLeaveHours" CHECK (((sickleavehours >= 0) AND (sickleavehours <= 120))),
    CONSTRAINT "CK_Employee_VacationHours" CHECK (((vacationhours >= '-40'::integer) AND (vacationhours <= 240)))
);


ALTER TABLE humanresources.employee OWNER TO adventureworks_user;

--
-- Name: TABLE employee; Type: COMMENT; Schema: humanresources; Owner: adventureworks_user
--

COMMENT ON TABLE humanresources.employee IS 'Employee information such as salary, department, and title.';


--
-- Name: COLUMN employee.businessentityid; Type: COMMENT; Schema: humanresources; Owner: adventureworks_user
--

COMMENT ON COLUMN humanresources.employee.businessentityid IS 'Primary key for Employee records.  Foreign key to BusinessEntity.BusinessEntityID.';


--
-- Name: COLUMN employee.nationalidnumber; Type: COMMENT; Schema: humanresources; Owner: adventureworks_user
--

COMMENT ON COLUMN humanresources.employee.nationalidnumber IS 'Unique national identification number such as a social security number.';


--
-- Name: COLUMN employee.loginid; Type: COMMENT; Schema: humanresources; Owner: adventureworks_user
--

COMMENT ON COLUMN humanresources.employee.loginid IS 'Network login.';


--
-- Name: COLUMN employee.jobtitle; Type: COMMENT; Schema: humanresources; Owner: adventureworks_user
--

COMMENT ON COLUMN humanresources.employee.jobtitle IS 'Work title such as Buyer or Sales Representative.';


--
-- Name: COLUMN employee.birthdate; Type: COMMENT; Schema: humanresources; Owner: adventureworks_user
--

COMMENT ON COLUMN humanresources.employee.birthdate IS 'Date of birth.';


--
-- Name: COLUMN employee.maritalstatus; Type: COMMENT; Schema: humanresources; Owner: adventureworks_user
--

COMMENT ON COLUMN humanresources.employee.maritalstatus IS 'M = Married, S = Single';


--
-- Name: COLUMN employee.gender; Type: COMMENT; Schema: humanresources; Owner: adventureworks_user
--

COMMENT ON COLUMN humanresources.employee.gender IS 'M = Male, F = Female';


--
-- Name: COLUMN employee.hiredate; Type: COMMENT; Schema: humanresources; Owner: adventureworks_user
--

COMMENT ON COLUMN humanresources.employee.hiredate IS 'Employee hired on this date.';


--
-- Name: COLUMN employee.salariedflag; Type: COMMENT; Schema: humanresources; Owner: adventureworks_user
--

COMMENT ON COLUMN humanresources.employee.salariedflag IS 'Job classification. 0 = Hourly, not exempt from collective bargaining. 1 = Salaried, exempt from collective bargaining.';


--
-- Name: COLUMN employee.vacationhours; Type: COMMENT; Schema: humanresources; Owner: adventureworks_user
--

COMMENT ON COLUMN humanresources.employee.vacationhours IS 'Number of available vacation hours.';


--
-- Name: COLUMN employee.sickleavehours; Type: COMMENT; Schema: humanresources; Owner: adventureworks_user
--

COMMENT ON COLUMN humanresources.employee.sickleavehours IS 'Number of available sick leave hours.';


--
-- Name: COLUMN employee.currentflag; Type: COMMENT; Schema: humanresources; Owner: adventureworks_user
--

COMMENT ON COLUMN humanresources.employee.currentflag IS '0 = Inactive, 1 = Active';


--
-- Name: COLUMN employee.organizationnode; Type: COMMENT; Schema: humanresources; Owner: adventureworks_user
--

COMMENT ON COLUMN humanresources.employee.organizationnode IS 'Where the employee is located in corporate hierarchy.';


--
-- Name: e; Type: VIEW; Schema: hr; Owner: adventureworks_user
--

CREATE VIEW hr.e AS
 SELECT employee.businessentityid AS id,
    employee.businessentityid,
    employee.nationalidnumber,
    employee.loginid,
    employee.jobtitle,
    employee.birthdate,
    employee.maritalstatus,
    employee.gender,
    employee.hiredate,
    employee.salariedflag,
    employee.vacationhours,
    employee.sickleavehours,
    employee.currentflag,
    employee.rowguid,
    employee.modifieddate,
    employee.organizationnode
   FROM humanresources.employee;


ALTER TABLE hr.e OWNER TO adventureworks_user;

--
-- Name: employeedepartmenthistory; Type: TABLE; Schema: humanresources; Owner: adventureworks_user
--

CREATE TABLE humanresources.employeedepartmenthistory (
    businessentityid integer NOT NULL,
    departmentid smallint NOT NULL,
    shiftid smallint NOT NULL,
    startdate date NOT NULL,
    enddate date,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_EmployeeDepartmentHistory_EndDate" CHECK (((enddate >= startdate) OR (enddate IS NULL)))
);


ALTER TABLE humanresources.employeedepartmenthistory OWNER TO adventureworks_user;

--
-- Name: TABLE employeedepartmenthistory; Type: COMMENT; Schema: humanresources; Owner: adventureworks_user
--

COMMENT ON TABLE humanresources.employeedepartmenthistory IS 'Employee department transfers.';


--
-- Name: COLUMN employeedepartmenthistory.businessentityid; Type: COMMENT; Schema: humanresources; Owner: adventureworks_user
--

COMMENT ON COLUMN humanresources.employeedepartmenthistory.businessentityid IS 'Employee identification number. Foreign key to Employee.BusinessEntityID.';


--
-- Name: COLUMN employeedepartmenthistory.departmentid; Type: COMMENT; Schema: humanresources; Owner: adventureworks_user
--

COMMENT ON COLUMN humanresources.employeedepartmenthistory.departmentid IS 'Department in which the employee worked including currently. Foreign key to Department.DepartmentID.';


--
-- Name: COLUMN employeedepartmenthistory.shiftid; Type: COMMENT; Schema: humanresources; Owner: adventureworks_user
--

COMMENT ON COLUMN humanresources.employeedepartmenthistory.shiftid IS 'Identifies which 8-hour shift the employee works. Foreign key to Shift.Shift.ID.';


--
-- Name: COLUMN employeedepartmenthistory.startdate; Type: COMMENT; Schema: humanresources; Owner: adventureworks_user
--

COMMENT ON COLUMN humanresources.employeedepartmenthistory.startdate IS 'Date the employee started work in the department.';


--
-- Name: COLUMN employeedepartmenthistory.enddate; Type: COMMENT; Schema: humanresources; Owner: adventureworks_user
--

COMMENT ON COLUMN humanresources.employeedepartmenthistory.enddate IS 'Date the employee left the department. NULL = Current department.';


--
-- Name: edh; Type: VIEW; Schema: hr; Owner: adventureworks_user
--

CREATE VIEW hr.edh AS
 SELECT employeedepartmenthistory.businessentityid AS id,
    employeedepartmenthistory.businessentityid,
    employeedepartmenthistory.departmentid,
    employeedepartmenthistory.shiftid,
    employeedepartmenthistory.startdate,
    employeedepartmenthistory.enddate,
    employeedepartmenthistory.modifieddate
   FROM humanresources.employeedepartmenthistory;


ALTER TABLE hr.edh OWNER TO adventureworks_user;

--
-- Name: employeepayhistory; Type: TABLE; Schema: humanresources; Owner: adventureworks_user
--

CREATE TABLE humanresources.employeepayhistory (
    businessentityid integer NOT NULL,
    ratechangedate timestamp without time zone NOT NULL,
    rate numeric NOT NULL,
    payfrequency smallint NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_EmployeePayHistory_PayFrequency" CHECK ((payfrequency = ANY (ARRAY[1, 2]))),
    CONSTRAINT "CK_EmployeePayHistory_Rate" CHECK (((rate >= 6.50) AND (rate <= 200.00)))
);


ALTER TABLE humanresources.employeepayhistory OWNER TO adventureworks_user;

--
-- Name: TABLE employeepayhistory; Type: COMMENT; Schema: humanresources; Owner: adventureworks_user
--

COMMENT ON TABLE humanresources.employeepayhistory IS 'Employee pay history.';


--
-- Name: COLUMN employeepayhistory.businessentityid; Type: COMMENT; Schema: humanresources; Owner: adventureworks_user
--

COMMENT ON COLUMN humanresources.employeepayhistory.businessentityid IS 'Employee identification number. Foreign key to Employee.BusinessEntityID.';


--
-- Name: COLUMN employeepayhistory.ratechangedate; Type: COMMENT; Schema: humanresources; Owner: adventureworks_user
--

COMMENT ON COLUMN humanresources.employeepayhistory.ratechangedate IS 'Date the change in pay is effective';


--
-- Name: COLUMN employeepayhistory.rate; Type: COMMENT; Schema: humanresources; Owner: adventureworks_user
--

COMMENT ON COLUMN humanresources.employeepayhistory.rate IS 'Salary hourly rate.';


--
-- Name: COLUMN employeepayhistory.payfrequency; Type: COMMENT; Schema: humanresources; Owner: adventureworks_user
--

COMMENT ON COLUMN humanresources.employeepayhistory.payfrequency IS '1 = Salary received monthly, 2 = Salary received biweekly';


--
-- Name: eph; Type: VIEW; Schema: hr; Owner: adventureworks_user
--

CREATE VIEW hr.eph AS
 SELECT employeepayhistory.businessentityid AS id,
    employeepayhistory.businessentityid,
    employeepayhistory.ratechangedate,
    employeepayhistory.rate,
    employeepayhistory.payfrequency,
    employeepayhistory.modifieddate
   FROM humanresources.employeepayhistory;


ALTER TABLE hr.eph OWNER TO adventureworks_user;

--
-- Name: jobcandidate; Type: TABLE; Schema: humanresources; Owner: adventureworks_user
--

CREATE TABLE humanresources.jobcandidate (
    jobcandidateid integer NOT NULL,
    businessentityid integer,
    resume xml,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE humanresources.jobcandidate OWNER TO adventureworks_user;

--
-- Name: TABLE jobcandidate; Type: COMMENT; Schema: humanresources; Owner: adventureworks_user
--

COMMENT ON TABLE humanresources.jobcandidate IS 'RÃ©sumÃ©s submitted to Human Resources by job applicants.';


--
-- Name: COLUMN jobcandidate.jobcandidateid; Type: COMMENT; Schema: humanresources; Owner: adventureworks_user
--

COMMENT ON COLUMN humanresources.jobcandidate.jobcandidateid IS 'Primary key for JobCandidate records.';


--
-- Name: COLUMN jobcandidate.businessentityid; Type: COMMENT; Schema: humanresources; Owner: adventureworks_user
--

COMMENT ON COLUMN humanresources.jobcandidate.businessentityid IS 'Employee identification number if applicant was hired. Foreign key to Employee.BusinessEntityID.';


--
-- Name: COLUMN jobcandidate.resume; Type: COMMENT; Schema: humanresources; Owner: adventureworks_user
--

COMMENT ON COLUMN humanresources.jobcandidate.resume IS 'RÃ©sumÃ© in XML format.';


--
-- Name: jc; Type: VIEW; Schema: hr; Owner: adventureworks_user
--

CREATE VIEW hr.jc AS
 SELECT jobcandidate.jobcandidateid AS id,
    jobcandidate.jobcandidateid,
    jobcandidate.businessentityid,
    jobcandidate.resume,
    jobcandidate.modifieddate
   FROM humanresources.jobcandidate;


ALTER TABLE hr.jc OWNER TO adventureworks_user;

--
-- Name: shift; Type: TABLE; Schema: humanresources; Owner: adventureworks_user
--

CREATE TABLE humanresources.shift (
    shiftid integer NOT NULL,
    name public."Name" NOT NULL,
    starttime time without time zone NOT NULL,
    endtime time without time zone NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE humanresources.shift OWNER TO adventureworks_user;

--
-- Name: TABLE shift; Type: COMMENT; Schema: humanresources; Owner: adventureworks_user
--

COMMENT ON TABLE humanresources.shift IS 'Work shift lookup table.';


--
-- Name: COLUMN shift.shiftid; Type: COMMENT; Schema: humanresources; Owner: adventureworks_user
--

COMMENT ON COLUMN humanresources.shift.shiftid IS 'Primary key for Shift records.';


--
-- Name: COLUMN shift.name; Type: COMMENT; Schema: humanresources; Owner: adventureworks_user
--

COMMENT ON COLUMN humanresources.shift.name IS 'Shift description.';


--
-- Name: COLUMN shift.starttime; Type: COMMENT; Schema: humanresources; Owner: adventureworks_user
--

COMMENT ON COLUMN humanresources.shift.starttime IS 'Shift start time.';


--
-- Name: COLUMN shift.endtime; Type: COMMENT; Schema: humanresources; Owner: adventureworks_user
--

COMMENT ON COLUMN humanresources.shift.endtime IS 'Shift end time.';


--
-- Name: s; Type: VIEW; Schema: hr; Owner: adventureworks_user
--

CREATE VIEW hr.s AS
 SELECT shift.shiftid AS id,
    shift.shiftid,
    shift.name,
    shift.starttime,
    shift.endtime,
    shift.modifieddate
   FROM humanresources.shift;


ALTER TABLE hr.s OWNER TO adventureworks_user;

--
-- Name: department_departmentid_seq; Type: SEQUENCE; Schema: humanresources; Owner: adventureworks_user
--

CREATE SEQUENCE humanresources.department_departmentid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE humanresources.department_departmentid_seq OWNER TO adventureworks_user;

--
-- Name: department_departmentid_seq; Type: SEQUENCE OWNED BY; Schema: humanresources; Owner: adventureworks_user
--

ALTER SEQUENCE humanresources.department_departmentid_seq OWNED BY humanresources.department.departmentid;


--
-- Name: jobcandidate_jobcandidateid_seq; Type: SEQUENCE; Schema: humanresources; Owner: adventureworks_user
--

CREATE SEQUENCE humanresources.jobcandidate_jobcandidateid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE humanresources.jobcandidate_jobcandidateid_seq OWNER TO adventureworks_user;

--
-- Name: jobcandidate_jobcandidateid_seq; Type: SEQUENCE OWNED BY; Schema: humanresources; Owner: adventureworks_user
--

ALTER SEQUENCE humanresources.jobcandidate_jobcandidateid_seq OWNED BY humanresources.jobcandidate.jobcandidateid;


--
-- Name: shift_shiftid_seq; Type: SEQUENCE; Schema: humanresources; Owner: adventureworks_user
--

CREATE SEQUENCE humanresources.shift_shiftid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE humanresources.shift_shiftid_seq OWNER TO adventureworks_user;

--
-- Name: shift_shiftid_seq; Type: SEQUENCE OWNED BY; Schema: humanresources; Owner: adventureworks_user
--

ALTER SEQUENCE humanresources.shift_shiftid_seq OWNED BY humanresources.shift.shiftid;


--
-- Name: address; Type: TABLE; Schema: person; Owner: adventureworks_user
--

CREATE TABLE person.address (
    addressid integer NOT NULL,
    addressline1 character varying(60) NOT NULL,
    addressline2 character varying(60),
    city character varying(30) NOT NULL,
    stateprovinceid integer NOT NULL,
    postalcode character varying(15) NOT NULL,
    spatiallocation character varying(44),
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.address OWNER TO adventureworks_user;

--
-- Name: TABLE address; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON TABLE person.address IS 'Street address information for customers, employees, and vendors.';


--
-- Name: COLUMN address.addressid; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.address.addressid IS 'Primary key for Address records.';


--
-- Name: COLUMN address.addressline1; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.address.addressline1 IS 'First street address line.';


--
-- Name: COLUMN address.addressline2; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.address.addressline2 IS 'Second street address line.';


--
-- Name: COLUMN address.city; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.address.city IS 'Name of the city.';


--
-- Name: COLUMN address.stateprovinceid; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.address.stateprovinceid IS 'Unique identification number for the state or province. Foreign key to StateProvince table.';


--
-- Name: COLUMN address.postalcode; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.address.postalcode IS 'Postal code for the street address.';


--
-- Name: COLUMN address.spatiallocation; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.address.spatiallocation IS 'Latitude and longitude of this address.';


--
-- Name: businessentityaddress; Type: TABLE; Schema: person; Owner: adventureworks_user
--

CREATE TABLE person.businessentityaddress (
    businessentityid integer NOT NULL,
    addressid integer NOT NULL,
    addresstypeid integer NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.businessentityaddress OWNER TO adventureworks_user;

--
-- Name: TABLE businessentityaddress; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON TABLE person.businessentityaddress IS 'Cross-reference table mapping customers, vendors, and employees to their addresses.';


--
-- Name: COLUMN businessentityaddress.businessentityid; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.businessentityaddress.businessentityid IS 'Primary key. Foreign key to BusinessEntity.BusinessEntityID.';


--
-- Name: COLUMN businessentityaddress.addressid; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.businessentityaddress.addressid IS 'Primary key. Foreign key to Address.AddressID.';


--
-- Name: COLUMN businessentityaddress.addresstypeid; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.businessentityaddress.addresstypeid IS 'Primary key. Foreign key to AddressType.AddressTypeID.';


--
-- Name: countryregion; Type: TABLE; Schema: person; Owner: adventureworks_user
--

CREATE TABLE person.countryregion (
    countryregioncode character varying(3) NOT NULL,
    name public."Name" NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.countryregion OWNER TO adventureworks_user;

--
-- Name: TABLE countryregion; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON TABLE person.countryregion IS 'Lookup table containing the ISO standard codes for countries and regions.';


--
-- Name: COLUMN countryregion.countryregioncode; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.countryregion.countryregioncode IS 'ISO standard code for countries and regions.';


--
-- Name: COLUMN countryregion.name; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.countryregion.name IS 'Country or region name.';


--
-- Name: emailaddress; Type: TABLE; Schema: person; Owner: adventureworks_user
--

CREATE TABLE person.emailaddress (
    businessentityid integer NOT NULL,
    emailaddressid integer NOT NULL,
    emailaddress character varying(50),
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.emailaddress OWNER TO adventureworks_user;

--
-- Name: TABLE emailaddress; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON TABLE person.emailaddress IS 'Where to send a person email.';


--
-- Name: COLUMN emailaddress.businessentityid; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.emailaddress.businessentityid IS 'Primary key. Person associated with this email address.  Foreign key to Person.BusinessEntityID';


--
-- Name: COLUMN emailaddress.emailaddressid; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.emailaddress.emailaddressid IS 'Primary key. ID of this email address.';


--
-- Name: COLUMN emailaddress.emailaddress; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.emailaddress.emailaddress IS 'E-mail address for the person.';


--
-- Name: person; Type: TABLE; Schema: person; Owner: adventureworks_user
--

CREATE TABLE person.person (
    businessentityid integer NOT NULL,
    persontype character(2) NOT NULL,
    namestyle public."NameStyle" DEFAULT false NOT NULL,
    title character varying(8),
    firstname public."Name" NOT NULL,
    middlename public."Name",
    lastname public."Name" NOT NULL,
    suffix character varying(10),
    emailpromotion integer DEFAULT 0 NOT NULL,
    additionalcontactinfo xml,
    demographics xml,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_Person_EmailPromotion" CHECK (((emailpromotion >= 0) AND (emailpromotion <= 2))),
    CONSTRAINT "CK_Person_PersonType" CHECK (((persontype IS NULL) OR (upper((persontype)::text) = ANY (ARRAY['SC'::text, 'VC'::text, 'IN'::text, 'EM'::text, 'SP'::text, 'GC'::text]))))
);


ALTER TABLE person.person OWNER TO adventureworks_user;

--
-- Name: TABLE person; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON TABLE person.person IS 'Human beings involved with AdventureWorks: employees, customer contacts, and vendor contacts.';


--
-- Name: COLUMN person.businessentityid; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.person.businessentityid IS 'Primary key for Person records.';


--
-- Name: COLUMN person.persontype; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.person.persontype IS 'Primary type of person: SC = Store Contact, IN = Individual (retail) customer, SP = Sales person, EM = Employee (non-sales), VC = Vendor contact, GC = General contact';


--
-- Name: COLUMN person.namestyle; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.person.namestyle IS '0 = The data in FirstName and LastName are stored in western style (first name, last name) order.  1 = Eastern style (last name, first name) order.';


--
-- Name: COLUMN person.title; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.person.title IS 'A courtesy title. For example, Mr. or Ms.';


--
-- Name: COLUMN person.firstname; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.person.firstname IS 'First name of the person.';


--
-- Name: COLUMN person.middlename; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.person.middlename IS 'Middle name or middle initial of the person.';


--
-- Name: COLUMN person.lastname; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.person.lastname IS 'Last name of the person.';


--
-- Name: COLUMN person.suffix; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.person.suffix IS 'Surname suffix. For example, Sr. or Jr.';


--
-- Name: COLUMN person.emailpromotion; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.person.emailpromotion IS '0 = Contact does not wish to receive e-mail promotions, 1 = Contact does wish to receive e-mail promotions from AdventureWorks, 2 = Contact does wish to receive e-mail promotions from AdventureWorks and selected partners.';


--
-- Name: COLUMN person.additionalcontactinfo; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.person.additionalcontactinfo IS 'Additional contact information about the person stored in xml format.';


--
-- Name: COLUMN person.demographics; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.person.demographics IS 'Personal information such as hobbies, and income collected from online shoppers. Used for sales analysis.';


--
-- Name: personphone; Type: TABLE; Schema: person; Owner: adventureworks_user
--

CREATE TABLE person.personphone (
    businessentityid integer NOT NULL,
    phonenumber public."Phone" NOT NULL,
    phonenumbertypeid integer NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.personphone OWNER TO adventureworks_user;

--
-- Name: TABLE personphone; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON TABLE person.personphone IS 'Telephone number and type of a person.';


--
-- Name: COLUMN personphone.businessentityid; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.personphone.businessentityid IS 'Business entity identification number. Foreign key to Person.BusinessEntityID.';


--
-- Name: COLUMN personphone.phonenumber; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.personphone.phonenumber IS 'Telephone number identification number.';


--
-- Name: COLUMN personphone.phonenumbertypeid; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.personphone.phonenumbertypeid IS 'Kind of phone number. Foreign key to PhoneNumberType.PhoneNumberTypeID.';


--
-- Name: phonenumbertype; Type: TABLE; Schema: person; Owner: adventureworks_user
--

CREATE TABLE person.phonenumbertype (
    phonenumbertypeid integer NOT NULL,
    name public."Name" NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.phonenumbertype OWNER TO adventureworks_user;

--
-- Name: TABLE phonenumbertype; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON TABLE person.phonenumbertype IS 'Type of phone number of a person.';


--
-- Name: COLUMN phonenumbertype.phonenumbertypeid; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.phonenumbertype.phonenumbertypeid IS 'Primary key for telephone number type records.';


--
-- Name: COLUMN phonenumbertype.name; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.phonenumbertype.name IS 'Name of the telephone number type';


--
-- Name: stateprovince; Type: TABLE; Schema: person; Owner: adventureworks_user
--

CREATE TABLE person.stateprovince (
    stateprovinceid integer NOT NULL,
    stateprovincecode character(3) NOT NULL,
    countryregioncode character varying(3) NOT NULL,
    isonlystateprovinceflag public."Flag" DEFAULT true NOT NULL,
    name public."Name" NOT NULL,
    territoryid integer NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.stateprovince OWNER TO adventureworks_user;

--
-- Name: TABLE stateprovince; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON TABLE person.stateprovince IS 'State and province lookup table.';


--
-- Name: COLUMN stateprovince.stateprovinceid; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.stateprovince.stateprovinceid IS 'Primary key for StateProvince records.';


--
-- Name: COLUMN stateprovince.stateprovincecode; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.stateprovince.stateprovincecode IS 'ISO standard state or province code.';


--
-- Name: COLUMN stateprovince.countryregioncode; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.stateprovince.countryregioncode IS 'ISO standard country or region code. Foreign key to CountryRegion.CountryRegionCode.';


--
-- Name: COLUMN stateprovince.isonlystateprovinceflag; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.stateprovince.isonlystateprovinceflag IS '0 = StateProvinceCode exists. 1 = StateProvinceCode unavailable, using CountryRegionCode.';


--
-- Name: COLUMN stateprovince.name; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.stateprovince.name IS 'State or province description.';


--
-- Name: COLUMN stateprovince.territoryid; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.stateprovince.territoryid IS 'ID of the territory in which the state or province is located. Foreign key to SalesTerritory.SalesTerritoryID.';


--
-- Name: vemployee; Type: VIEW; Schema: humanresources; Owner: adventureworks_user
--

CREATE VIEW humanresources.vemployee AS
 SELECT e.businessentityid,
    p.title,
    p.firstname,
    p.middlename,
    p.lastname,
    p.suffix,
    e.jobtitle,
    pp.phonenumber,
    pnt.name AS phonenumbertype,
    ea.emailaddress,
    p.emailpromotion,
    a.addressline1,
    a.addressline2,
    a.city,
    sp.name AS stateprovincename,
    a.postalcode,
    cr.name AS countryregionname,
    p.additionalcontactinfo
   FROM ((((((((humanresources.employee e
     JOIN person.person p ON ((p.businessentityid = e.businessentityid)))
     JOIN person.businessentityaddress bea ON ((bea.businessentityid = e.businessentityid)))
     JOIN person.address a ON ((a.addressid = bea.addressid)))
     JOIN person.stateprovince sp ON ((sp.stateprovinceid = a.stateprovinceid)))
     JOIN person.countryregion cr ON (((cr.countryregioncode)::text = (sp.countryregioncode)::text)))
     LEFT JOIN person.personphone pp ON ((pp.businessentityid = p.businessentityid)))
     LEFT JOIN person.phonenumbertype pnt ON ((pp.phonenumbertypeid = pnt.phonenumbertypeid)))
     LEFT JOIN person.emailaddress ea ON ((p.businessentityid = ea.businessentityid)));


ALTER TABLE humanresources.vemployee OWNER TO adventureworks_user;

--
-- Name: vemployeedepartment; Type: VIEW; Schema: humanresources; Owner: adventureworks_user
--

CREATE VIEW humanresources.vemployeedepartment AS
 SELECT e.businessentityid,
    p.title,
    p.firstname,
    p.middlename,
    p.lastname,
    p.suffix,
    e.jobtitle,
    d.name AS department,
    d.groupname,
    edh.startdate
   FROM (((humanresources.employee e
     JOIN person.person p ON ((p.businessentityid = e.businessentityid)))
     JOIN humanresources.employeedepartmenthistory edh ON ((e.businessentityid = edh.businessentityid)))
     JOIN humanresources.department d ON ((edh.departmentid = d.departmentid)))
  WHERE (edh.enddate IS NULL);


ALTER TABLE humanresources.vemployeedepartment OWNER TO adventureworks_user;

--
-- Name: vemployeedepartmenthistory; Type: VIEW; Schema: humanresources; Owner: adventureworks_user
--

CREATE VIEW humanresources.vemployeedepartmenthistory AS
 SELECT e.businessentityid,
    p.title,
    p.firstname,
    p.middlename,
    p.lastname,
    p.suffix,
    s.name AS shift,
    d.name AS department,
    d.groupname,
    edh.startdate,
    edh.enddate
   FROM ((((humanresources.employee e
     JOIN person.person p ON ((p.businessentityid = e.businessentityid)))
     JOIN humanresources.employeedepartmenthistory edh ON ((e.businessentityid = edh.businessentityid)))
     JOIN humanresources.department d ON ((edh.departmentid = d.departmentid)))
     JOIN humanresources.shift s ON ((s.shiftid = edh.shiftid)));


ALTER TABLE humanresources.vemployeedepartmenthistory OWNER TO adventureworks_user;

--
-- Name: vjobcandidate; Type: VIEW; Schema: humanresources; Owner: adventureworks_user
--

CREATE VIEW humanresources.vjobcandidate AS
 SELECT jobcandidate.jobcandidateid,
    jobcandidate.businessentityid,
    ((xpath('/n:Resume/n:Name/n:Name.Prefix/text()'::text, jobcandidate.resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying(30) AS "Name.Prefix",
    ((xpath('/n:Resume/n:Name/n:Name.First/text()'::text, jobcandidate.resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying(30) AS "Name.First",
    ((xpath('/n:Resume/n:Name/n:Name.Middle/text()'::text, jobcandidate.resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying(30) AS "Name.Middle",
    ((xpath('/n:Resume/n:Name/n:Name.Last/text()'::text, jobcandidate.resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying(30) AS "Name.Last",
    ((xpath('/n:Resume/n:Name/n:Name.Suffix/text()'::text, jobcandidate.resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying(30) AS "Name.Suffix",
    ((xpath('/n:Resume/n:Skills/text()'::text, jobcandidate.resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying AS "Skills",
    ((xpath('n:Address/n:Addr.Type/text()'::text, jobcandidate.resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying(30) AS "Addr.Type",
    ((xpath('n:Address/n:Addr.Location/n:Location/n:Loc.CountryRegion/text()'::text, jobcandidate.resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying(100) AS "Addr.Loc.CountryRegion",
    ((xpath('n:Address/n:Addr.Location/n:Location/n:Loc.State/text()'::text, jobcandidate.resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying(100) AS "Addr.Loc.State",
    ((xpath('n:Address/n:Addr.Location/n:Location/n:Loc.City/text()'::text, jobcandidate.resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying(100) AS "Addr.Loc.City",
    ((xpath('n:Address/n:Addr.PostalCode/text()'::text, jobcandidate.resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying(20) AS "Addr.PostalCode",
    ((xpath('/n:Resume/n:EMail/text()'::text, jobcandidate.resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying AS "EMail",
    ((xpath('/n:Resume/n:WebSite/text()'::text, jobcandidate.resume, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[]))[1])::character varying AS "WebSite",
    jobcandidate.modifieddate
   FROM humanresources.jobcandidate;


ALTER TABLE humanresources.vjobcandidate OWNER TO adventureworks_user;

--
-- Name: vjobcandidateeducation; Type: VIEW; Schema: humanresources; Owner: adventureworks_user
--

CREATE VIEW humanresources.vjobcandidateeducation AS
 SELECT jc.jobcandidateid,
    ((xpath('/root/ns:Education/ns:Edu.Level/text()'::text, jc.doc, '{{ns,http://adventureworks.com}}'::text[]))[1])::character varying(50) AS "Edu.Level",
    (((xpath('/root/ns:Education/ns:Edu.StartDate/text()'::text, jc.doc, '{{ns,http://adventureworks.com}}'::text[]))[1])::character varying(20))::date AS "Edu.StartDate",
    (((xpath('/root/ns:Education/ns:Edu.EndDate/text()'::text, jc.doc, '{{ns,http://adventureworks.com}}'::text[]))[1])::character varying(20))::date AS "Edu.EndDate",
    ((xpath('/root/ns:Education/ns:Edu.Degree/text()'::text, jc.doc, '{{ns,http://adventureworks.com}}'::text[]))[1])::character varying(50) AS "Edu.Degree",
    ((xpath('/root/ns:Education/ns:Edu.Major/text()'::text, jc.doc, '{{ns,http://adventureworks.com}}'::text[]))[1])::character varying(50) AS "Edu.Major",
    ((xpath('/root/ns:Education/ns:Edu.Minor/text()'::text, jc.doc, '{{ns,http://adventureworks.com}}'::text[]))[1])::character varying(50) AS "Edu.Minor",
    ((xpath('/root/ns:Education/ns:Edu.GPA/text()'::text, jc.doc, '{{ns,http://adventureworks.com}}'::text[]))[1])::character varying(5) AS "Edu.GPA",
    ((xpath('/root/ns:Education/ns:Edu.GPAScale/text()'::text, jc.doc, '{{ns,http://adventureworks.com}}'::text[]))[1])::character varying(5) AS "Edu.GPAScale",
    ((xpath('/root/ns:Education/ns:Edu.School/text()'::text, jc.doc, '{{ns,http://adventureworks.com}}'::text[]))[1])::character varying(100) AS "Edu.School",
    ((xpath('/root/ns:Education/ns:Edu.Location/ns:Location/ns:Loc.CountryRegion/text()'::text, jc.doc, '{{ns,http://adventureworks.com}}'::text[]))[1])::character varying(100) AS "Edu.Loc.CountryRegion",
    ((xpath('/root/ns:Education/ns:Edu.Location/ns:Location/ns:Loc.State/text()'::text, jc.doc, '{{ns,http://adventureworks.com}}'::text[]))[1])::character varying(100) AS "Edu.Loc.State",
    ((xpath('/root/ns:Education/ns:Edu.Location/ns:Location/ns:Loc.City/text()'::text, jc.doc, '{{ns,http://adventureworks.com}}'::text[]))[1])::character varying(100) AS "Edu.Loc.City"
   FROM ( SELECT unnesting.jobcandidateid,
            ((('<root xmlns:ns="http://adventureworks.com">'::text || ((unnesting.education)::character varying)::text) || '</root>'::text))::xml AS doc
           FROM ( SELECT jobcandidate.jobcandidateid,
                    unnest(xpath('/ns:Resume/ns:Education'::text, jobcandidate.resume, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[])) AS education
                   FROM humanresources.jobcandidate) unnesting) jc;


ALTER TABLE humanresources.vjobcandidateeducation OWNER TO adventureworks_user;

--
-- Name: vjobcandidateemployment; Type: VIEW; Schema: humanresources; Owner: adventureworks_user
--

CREATE VIEW humanresources.vjobcandidateemployment AS
 SELECT jobcandidate.jobcandidateid,
    ((unnest(xpath('/ns:Resume/ns:Employment/ns:Emp.StartDate/text()'::text, jobcandidate.resume, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[])))::character varying(20))::date AS "Emp.StartDate",
    ((unnest(xpath('/ns:Resume/ns:Employment/ns:Emp.EndDate/text()'::text, jobcandidate.resume, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[])))::character varying(20))::date AS "Emp.EndDate",
    (unnest(xpath('/ns:Resume/ns:Employment/ns:Emp.OrgName/text()'::text, jobcandidate.resume, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[])))::character varying(100) AS "Emp.OrgName",
    (unnest(xpath('/ns:Resume/ns:Employment/ns:Emp.JobTitle/text()'::text, jobcandidate.resume, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[])))::character varying(100) AS "Emp.JobTitle",
    (unnest(xpath('/ns:Resume/ns:Employment/ns:Emp.Responsibility/text()'::text, jobcandidate.resume, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[])))::character varying AS "Emp.Responsibility",
    (unnest(xpath('/ns:Resume/ns:Employment/ns:Emp.FunctionCategory/text()'::text, jobcandidate.resume, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[])))::character varying AS "Emp.FunctionCategory",
    (unnest(xpath('/ns:Resume/ns:Employment/ns:Emp.IndustryCategory/text()'::text, jobcandidate.resume, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[])))::character varying AS "Emp.IndustryCategory",
    (unnest(xpath('/ns:Resume/ns:Employment/ns:Emp.Location/ns:Location/ns:Loc.CountryRegion/text()'::text, jobcandidate.resume, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[])))::character varying AS "Emp.Loc.CountryRegion",
    (unnest(xpath('/ns:Resume/ns:Employment/ns:Emp.Location/ns:Location/ns:Loc.State/text()'::text, jobcandidate.resume, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[])))::character varying AS "Emp.Loc.State",
    (unnest(xpath('/ns:Resume/ns:Employment/ns:Emp.Location/ns:Location/ns:Loc.City/text()'::text, jobcandidate.resume, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume}}'::text[])))::character varying AS "Emp.Loc.City"
   FROM humanresources.jobcandidate;


ALTER TABLE humanresources.vjobcandidateemployment OWNER TO adventureworks_user;

--
-- Name: a; Type: VIEW; Schema: pe; Owner: adventureworks_user
--

CREATE VIEW pe.a AS
 SELECT address.addressid AS id,
    address.addressid,
    address.addressline1,
    address.addressline2,
    address.city,
    address.stateprovinceid,
    address.postalcode,
    address.spatiallocation,
    address.rowguid,
    address.modifieddate
   FROM person.address;


ALTER TABLE pe.a OWNER TO adventureworks_user;

--
-- Name: addresstype; Type: TABLE; Schema: person; Owner: adventureworks_user
--

CREATE TABLE person.addresstype (
    addresstypeid integer NOT NULL,
    name public."Name" NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.addresstype OWNER TO adventureworks_user;

--
-- Name: TABLE addresstype; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON TABLE person.addresstype IS 'Types of addresses stored in the Address table.';


--
-- Name: COLUMN addresstype.addresstypeid; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.addresstype.addresstypeid IS 'Primary key for AddressType records.';


--
-- Name: COLUMN addresstype.name; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.addresstype.name IS 'Address type description. For example, Billing, Home, or Shipping.';


--
-- Name: at; Type: VIEW; Schema: pe; Owner: adventureworks_user
--

CREATE VIEW pe.at AS
 SELECT addresstype.addresstypeid AS id,
    addresstype.addresstypeid,
    addresstype.name,
    addresstype.rowguid,
    addresstype.modifieddate
   FROM person.addresstype;


ALTER TABLE pe.at OWNER TO adventureworks_user;

--
-- Name: businessentity; Type: TABLE; Schema: person; Owner: adventureworks_user
--

CREATE TABLE person.businessentity (
    businessentityid integer NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.businessentity OWNER TO adventureworks_user;

--
-- Name: TABLE businessentity; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON TABLE person.businessentity IS 'Source of the ID that connects vendors, customers, and employees with address and contact information.';


--
-- Name: COLUMN businessentity.businessentityid; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.businessentity.businessentityid IS 'Primary key for all customers, vendors, and employees.';


--
-- Name: be; Type: VIEW; Schema: pe; Owner: adventureworks_user
--

CREATE VIEW pe.be AS
 SELECT businessentity.businessentityid AS id,
    businessentity.businessentityid,
    businessentity.rowguid,
    businessentity.modifieddate
   FROM person.businessentity;


ALTER TABLE pe.be OWNER TO adventureworks_user;

--
-- Name: bea; Type: VIEW; Schema: pe; Owner: adventureworks_user
--

CREATE VIEW pe.bea AS
 SELECT businessentityaddress.businessentityid AS id,
    businessentityaddress.businessentityid,
    businessentityaddress.addressid,
    businessentityaddress.addresstypeid,
    businessentityaddress.rowguid,
    businessentityaddress.modifieddate
   FROM person.businessentityaddress;


ALTER TABLE pe.bea OWNER TO adventureworks_user;

--
-- Name: businessentitycontact; Type: TABLE; Schema: person; Owner: adventureworks_user
--

CREATE TABLE person.businessentitycontact (
    businessentityid integer NOT NULL,
    personid integer NOT NULL,
    contacttypeid integer NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.businessentitycontact OWNER TO adventureworks_user;

--
-- Name: TABLE businessentitycontact; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON TABLE person.businessentitycontact IS 'Cross-reference table mapping stores, vendors, and employees to people';


--
-- Name: COLUMN businessentitycontact.businessentityid; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.businessentitycontact.businessentityid IS 'Primary key. Foreign key to BusinessEntity.BusinessEntityID.';


--
-- Name: COLUMN businessentitycontact.personid; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.businessentitycontact.personid IS 'Primary key. Foreign key to Person.BusinessEntityID.';


--
-- Name: COLUMN businessentitycontact.contacttypeid; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.businessentitycontact.contacttypeid IS 'Primary key.  Foreign key to ContactType.ContactTypeID.';


--
-- Name: bec; Type: VIEW; Schema: pe; Owner: adventureworks_user
--

CREATE VIEW pe.bec AS
 SELECT businessentitycontact.businessentityid AS id,
    businessentitycontact.businessentityid,
    businessentitycontact.personid,
    businessentitycontact.contacttypeid,
    businessentitycontact.rowguid,
    businessentitycontact.modifieddate
   FROM person.businessentitycontact;


ALTER TABLE pe.bec OWNER TO adventureworks_user;

--
-- Name: cr; Type: VIEW; Schema: pe; Owner: adventureworks_user
--

CREATE VIEW pe.cr AS
 SELECT countryregion.countryregioncode,
    countryregion.name,
    countryregion.modifieddate
   FROM person.countryregion;


ALTER TABLE pe.cr OWNER TO adventureworks_user;

--
-- Name: contacttype; Type: TABLE; Schema: person; Owner: adventureworks_user
--

CREATE TABLE person.contacttype (
    contacttypeid integer NOT NULL,
    name public."Name" NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.contacttype OWNER TO adventureworks_user;

--
-- Name: TABLE contacttype; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON TABLE person.contacttype IS 'Lookup table containing the types of business entity contacts.';


--
-- Name: COLUMN contacttype.contacttypeid; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.contacttype.contacttypeid IS 'Primary key for ContactType records.';


--
-- Name: COLUMN contacttype.name; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.contacttype.name IS 'Contact type description.';


--
-- Name: ct; Type: VIEW; Schema: pe; Owner: adventureworks_user
--

CREATE VIEW pe.ct AS
 SELECT contacttype.contacttypeid AS id,
    contacttype.contacttypeid,
    contacttype.name,
    contacttype.modifieddate
   FROM person.contacttype;


ALTER TABLE pe.ct OWNER TO adventureworks_user;

--
-- Name: e; Type: VIEW; Schema: pe; Owner: adventureworks_user
--

CREATE VIEW pe.e AS
 SELECT emailaddress.emailaddressid AS id,
    emailaddress.businessentityid,
    emailaddress.emailaddressid,
    emailaddress.emailaddress,
    emailaddress.rowguid,
    emailaddress.modifieddate
   FROM person.emailaddress;


ALTER TABLE pe.e OWNER TO adventureworks_user;

--
-- Name: p; Type: VIEW; Schema: pe; Owner: adventureworks_user
--

CREATE VIEW pe.p AS
 SELECT person.businessentityid AS id,
    person.businessentityid,
    person.persontype,
    person.namestyle,
    person.title,
    person.firstname,
    person.middlename,
    person.lastname,
    person.suffix,
    person.emailpromotion,
    person.additionalcontactinfo,
    person.demographics,
    person.rowguid,
    person.modifieddate
   FROM person.person;


ALTER TABLE pe.p OWNER TO adventureworks_user;

--
-- Name: password; Type: TABLE; Schema: person; Owner: adventureworks_user
--

CREATE TABLE person.password (
    businessentityid integer NOT NULL,
    passwordhash character varying(128) NOT NULL,
    passwordsalt character varying(10) NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE person.password OWNER TO adventureworks_user;

--
-- Name: TABLE password; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON TABLE person.password IS 'One way hashed authentication information';


--
-- Name: COLUMN password.passwordhash; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.password.passwordhash IS 'Password for the e-mail account.';


--
-- Name: COLUMN password.passwordsalt; Type: COMMENT; Schema: person; Owner: adventureworks_user
--

COMMENT ON COLUMN person.password.passwordsalt IS 'Random value concatenated with the password string before the password is hashed.';


--
-- Name: pa; Type: VIEW; Schema: pe; Owner: adventureworks_user
--

CREATE VIEW pe.pa AS
 SELECT password.businessentityid AS id,
    password.businessentityid,
    password.passwordhash,
    password.passwordsalt,
    password.rowguid,
    password.modifieddate
   FROM person.password;


ALTER TABLE pe.pa OWNER TO adventureworks_user;

--
-- Name: pnt; Type: VIEW; Schema: pe; Owner: adventureworks_user
--

CREATE VIEW pe.pnt AS
 SELECT phonenumbertype.phonenumbertypeid AS id,
    phonenumbertype.phonenumbertypeid,
    phonenumbertype.name,
    phonenumbertype.modifieddate
   FROM person.phonenumbertype;


ALTER TABLE pe.pnt OWNER TO adventureworks_user;

--
-- Name: pp; Type: VIEW; Schema: pe; Owner: adventureworks_user
--

CREATE VIEW pe.pp AS
 SELECT personphone.businessentityid AS id,
    personphone.businessentityid,
    personphone.phonenumber,
    personphone.phonenumbertypeid,
    personphone.modifieddate
   FROM person.personphone;


ALTER TABLE pe.pp OWNER TO adventureworks_user;

--
-- Name: sp; Type: VIEW; Schema: pe; Owner: adventureworks_user
--

CREATE VIEW pe.sp AS
 SELECT stateprovince.stateprovinceid AS id,
    stateprovince.stateprovinceid,
    stateprovince.stateprovincecode,
    stateprovince.countryregioncode,
    stateprovince.isonlystateprovinceflag,
    stateprovince.name,
    stateprovince.territoryid,
    stateprovince.rowguid,
    stateprovince.modifieddate
   FROM person.stateprovince;


ALTER TABLE pe.sp OWNER TO adventureworks_user;

--
-- Name: address_addressid_seq; Type: SEQUENCE; Schema: person; Owner: adventureworks_user
--

CREATE SEQUENCE person.address_addressid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE person.address_addressid_seq OWNER TO adventureworks_user;

--
-- Name: address_addressid_seq; Type: SEQUENCE OWNED BY; Schema: person; Owner: adventureworks_user
--

ALTER SEQUENCE person.address_addressid_seq OWNED BY person.address.addressid;


--
-- Name: addresstype_addresstypeid_seq; Type: SEQUENCE; Schema: person; Owner: adventureworks_user
--

CREATE SEQUENCE person.addresstype_addresstypeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE person.addresstype_addresstypeid_seq OWNER TO adventureworks_user;

--
-- Name: addresstype_addresstypeid_seq; Type: SEQUENCE OWNED BY; Schema: person; Owner: adventureworks_user
--

ALTER SEQUENCE person.addresstype_addresstypeid_seq OWNED BY person.addresstype.addresstypeid;


--
-- Name: businessentity_businessentityid_seq; Type: SEQUENCE; Schema: person; Owner: adventureworks_user
--

CREATE SEQUENCE person.businessentity_businessentityid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE person.businessentity_businessentityid_seq OWNER TO adventureworks_user;

--
-- Name: businessentity_businessentityid_seq; Type: SEQUENCE OWNED BY; Schema: person; Owner: adventureworks_user
--

ALTER SEQUENCE person.businessentity_businessentityid_seq OWNED BY person.businessentity.businessentityid;


--
-- Name: contacttype_contacttypeid_seq; Type: SEQUENCE; Schema: person; Owner: adventureworks_user
--

CREATE SEQUENCE person.contacttype_contacttypeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE person.contacttype_contacttypeid_seq OWNER TO adventureworks_user;

--
-- Name: contacttype_contacttypeid_seq; Type: SEQUENCE OWNED BY; Schema: person; Owner: adventureworks_user
--

ALTER SEQUENCE person.contacttype_contacttypeid_seq OWNED BY person.contacttype.contacttypeid;


--
-- Name: emailaddress_emailaddressid_seq; Type: SEQUENCE; Schema: person; Owner: adventureworks_user
--

CREATE SEQUENCE person.emailaddress_emailaddressid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE person.emailaddress_emailaddressid_seq OWNER TO adventureworks_user;

--
-- Name: emailaddress_emailaddressid_seq; Type: SEQUENCE OWNED BY; Schema: person; Owner: adventureworks_user
--

ALTER SEQUENCE person.emailaddress_emailaddressid_seq OWNED BY person.emailaddress.emailaddressid;


--
-- Name: phonenumbertype_phonenumbertypeid_seq; Type: SEQUENCE; Schema: person; Owner: adventureworks_user
--

CREATE SEQUENCE person.phonenumbertype_phonenumbertypeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE person.phonenumbertype_phonenumbertypeid_seq OWNER TO adventureworks_user;

--
-- Name: phonenumbertype_phonenumbertypeid_seq; Type: SEQUENCE OWNED BY; Schema: person; Owner: adventureworks_user
--

ALTER SEQUENCE person.phonenumbertype_phonenumbertypeid_seq OWNED BY person.phonenumbertype.phonenumbertypeid;


--
-- Name: stateprovince_stateprovinceid_seq; Type: SEQUENCE; Schema: person; Owner: adventureworks_user
--

CREATE SEQUENCE person.stateprovince_stateprovinceid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE person.stateprovince_stateprovinceid_seq OWNER TO adventureworks_user;

--
-- Name: stateprovince_stateprovinceid_seq; Type: SEQUENCE OWNED BY; Schema: person; Owner: adventureworks_user
--

ALTER SEQUENCE person.stateprovince_stateprovinceid_seq OWNED BY person.stateprovince.stateprovinceid;


--
-- Name: vadditionalcontactinfo; Type: VIEW; Schema: person; Owner: adventureworks_user
--

CREATE VIEW person.vadditionalcontactinfo AS
 SELECT p.businessentityid,
    p.firstname,
    p.middlename,
    p.lastname,
    (xpath('(act:telephoneNumber)[1]/act:number/text()'::text, additional.node, '{{act,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes}}'::text[]))[1] AS telephonenumber,
    btrim((((xpath('(act:telephoneNumber)[1]/act:SpecialInstructions/text()'::text, additional.node, '{{act,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes}}'::text[]))[1])::character varying)::text) AS telephonespecialinstructions,
    (xpath('(act:homePostalAddress)[1]/act:Street/text()'::text, additional.node, '{{act,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes}}'::text[]))[1] AS street,
    (xpath('(act:homePostalAddress)[1]/act:City/text()'::text, additional.node, '{{act,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes}}'::text[]))[1] AS city,
    (xpath('(act:homePostalAddress)[1]/act:StateProvince/text()'::text, additional.node, '{{act,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes}}'::text[]))[1] AS stateprovince,
    (xpath('(act:homePostalAddress)[1]/act:PostalCode/text()'::text, additional.node, '{{act,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes}}'::text[]))[1] AS postalcode,
    (xpath('(act:homePostalAddress)[1]/act:CountryRegion/text()'::text, additional.node, '{{act,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes}}'::text[]))[1] AS countryregion,
    (xpath('(act:homePostalAddress)[1]/act:SpecialInstructions/text()'::text, additional.node, '{{act,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes}}'::text[]))[1] AS homeaddressspecialinstructions,
    (xpath('(act:eMail)[1]/act:eMailAddress/text()'::text, additional.node, '{{act,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes}}'::text[]))[1] AS emailaddress,
    btrim((((xpath('(act:eMail)[1]/act:SpecialInstructions/text()'::text, additional.node, '{{act,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes}}'::text[]))[1])::character varying)::text) AS emailspecialinstructions,
    (xpath('((act:eMail)[1]/act:SpecialInstructions/act:telephoneNumber)[1]/act:number/text()'::text, additional.node, '{{act,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes}}'::text[]))[1] AS emailtelephonenumber,
    p.rowguid,
    p.modifieddate
   FROM (person.person p
     LEFT JOIN ( SELECT person.businessentityid,
            unnest(xpath('/ci:AdditionalContactInfo'::text, person.additionalcontactinfo, '{{ci,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo}}'::text[])) AS node
           FROM person.person
          WHERE (person.additionalcontactinfo IS NOT NULL)) additional ON ((p.businessentityid = additional.businessentityid)));


ALTER TABLE person.vadditionalcontactinfo OWNER TO adventureworks_user;

--
-- Name: vstateprovincecountryregion; Type: MATERIALIZED VIEW; Schema: person; Owner: adventureworks_user
--

CREATE MATERIALIZED VIEW person.vstateprovincecountryregion AS
 SELECT sp.stateprovinceid,
    sp.stateprovincecode,
    sp.isonlystateprovinceflag,
    sp.name AS stateprovincename,
    sp.territoryid,
    cr.countryregioncode,
    cr.name AS countryregionname
   FROM (person.stateprovince sp
     JOIN person.countryregion cr ON (((sp.countryregioncode)::text = (cr.countryregioncode)::text)))
  WITH NO DATA;


ALTER TABLE person.vstateprovincecountryregion OWNER TO adventureworks_user;

--
-- Name: billofmaterials; Type: TABLE; Schema: production; Owner: adventureworks_user
--

CREATE TABLE production.billofmaterials (
    billofmaterialsid integer NOT NULL,
    productassemblyid integer,
    componentid integer NOT NULL,
    startdate timestamp without time zone DEFAULT now() NOT NULL,
    enddate timestamp without time zone,
    unitmeasurecode character(3) NOT NULL,
    bomlevel smallint NOT NULL,
    perassemblyqty numeric(8,2) DEFAULT 1.00 NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_BillOfMaterials_BOMLevel" CHECK ((((productassemblyid IS NULL) AND (bomlevel = 0) AND (perassemblyqty = 1.00)) OR ((productassemblyid IS NOT NULL) AND (bomlevel >= 1)))),
    CONSTRAINT "CK_BillOfMaterials_EndDate" CHECK (((enddate > startdate) OR (enddate IS NULL))),
    CONSTRAINT "CK_BillOfMaterials_PerAssemblyQty" CHECK ((perassemblyqty >= 1.00)),
    CONSTRAINT "CK_BillOfMaterials_ProductAssemblyID" CHECK ((productassemblyid <> componentid))
);


ALTER TABLE production.billofmaterials OWNER TO adventureworks_user;

--
-- Name: TABLE billofmaterials; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON TABLE production.billofmaterials IS 'Items required to make bicycles and bicycle subassemblies. It identifies the heirarchical relationship between a parent product and its components.';


--
-- Name: COLUMN billofmaterials.billofmaterialsid; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.billofmaterials.billofmaterialsid IS 'Primary key for BillOfMaterials records.';


--
-- Name: COLUMN billofmaterials.productassemblyid; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.billofmaterials.productassemblyid IS 'Parent product identification number. Foreign key to Product.ProductID.';


--
-- Name: COLUMN billofmaterials.componentid; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.billofmaterials.componentid IS 'Component identification number. Foreign key to Product.ProductID.';


--
-- Name: COLUMN billofmaterials.startdate; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.billofmaterials.startdate IS 'Date the component started being used in the assembly item.';


--
-- Name: COLUMN billofmaterials.enddate; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.billofmaterials.enddate IS 'Date the component stopped being used in the assembly item.';


--
-- Name: COLUMN billofmaterials.unitmeasurecode; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.billofmaterials.unitmeasurecode IS 'Standard code identifying the unit of measure for the quantity.';


--
-- Name: COLUMN billofmaterials.bomlevel; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.billofmaterials.bomlevel IS 'Indicates the depth the component is from its parent (AssemblyID).';


--
-- Name: COLUMN billofmaterials.perassemblyqty; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.billofmaterials.perassemblyqty IS 'Quantity of the component needed to create the assembly.';


--
-- Name: bom; Type: VIEW; Schema: pr; Owner: adventureworks_user
--

CREATE VIEW pr.bom AS
 SELECT billofmaterials.billofmaterialsid AS id,
    billofmaterials.billofmaterialsid,
    billofmaterials.productassemblyid,
    billofmaterials.componentid,
    billofmaterials.startdate,
    billofmaterials.enddate,
    billofmaterials.unitmeasurecode,
    billofmaterials.bomlevel,
    billofmaterials.perassemblyqty,
    billofmaterials.modifieddate
   FROM production.billofmaterials;


ALTER TABLE pr.bom OWNER TO adventureworks_user;

--
-- Name: culture; Type: TABLE; Schema: production; Owner: adventureworks_user
--

CREATE TABLE production.culture (
    cultureid character(6) NOT NULL,
    name public."Name" NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.culture OWNER TO adventureworks_user;

--
-- Name: TABLE culture; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON TABLE production.culture IS 'Lookup table containing the languages in which some AdventureWorks data is stored.';


--
-- Name: COLUMN culture.cultureid; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.culture.cultureid IS 'Primary key for Culture records.';


--
-- Name: COLUMN culture.name; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.culture.name IS 'Culture description.';


--
-- Name: c; Type: VIEW; Schema: pr; Owner: adventureworks_user
--

CREATE VIEW pr.c AS
 SELECT culture.cultureid AS id,
    culture.cultureid,
    culture.name,
    culture.modifieddate
   FROM production.culture;


ALTER TABLE pr.c OWNER TO adventureworks_user;

--
-- Name: document; Type: TABLE; Schema: production; Owner: adventureworks_user
--

CREATE TABLE production.document (
    title character varying(50) NOT NULL,
    owner integer NOT NULL,
    folderflag public."Flag" DEFAULT false NOT NULL,
    filename character varying(400) NOT NULL,
    fileextension character varying(8),
    revision character(5) NOT NULL,
    changenumber integer DEFAULT 0 NOT NULL,
    status smallint NOT NULL,
    documentsummary text,
    document bytea,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    documentnode character varying DEFAULT '/'::character varying NOT NULL,
    CONSTRAINT "CK_Document_Status" CHECK (((status >= 1) AND (status <= 3)))
);


ALTER TABLE production.document OWNER TO adventureworks_user;

--
-- Name: TABLE document; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON TABLE production.document IS 'Product maintenance documents.';


--
-- Name: COLUMN document.title; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.document.title IS 'Title of the document.';


--
-- Name: COLUMN document.owner; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.document.owner IS 'Employee who controls the document.  Foreign key to Employee.BusinessEntityID';


--
-- Name: COLUMN document.folderflag; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.document.folderflag IS '0 = This is a folder, 1 = This is a document.';


--
-- Name: COLUMN document.filename; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.document.filename IS 'File name of the document';


--
-- Name: COLUMN document.fileextension; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.document.fileextension IS 'File extension indicating the document type. For example, .doc or .txt.';


--
-- Name: COLUMN document.revision; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.document.revision IS 'Revision number of the document.';


--
-- Name: COLUMN document.changenumber; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.document.changenumber IS 'Engineering change approval number.';


--
-- Name: COLUMN document.status; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.document.status IS '1 = Pending approval, 2 = Approved, 3 = Obsolete';


--
-- Name: COLUMN document.documentsummary; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.document.documentsummary IS 'Document abstract.';


--
-- Name: COLUMN document.document; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.document.document IS 'Complete document.';


--
-- Name: COLUMN document.rowguid; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.document.rowguid IS 'ROWGUIDCOL number uniquely identifying the record. Required for FileStream.';


--
-- Name: COLUMN document.documentnode; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.document.documentnode IS 'Primary key for Document records.';


--
-- Name: d; Type: VIEW; Schema: pr; Owner: adventureworks_user
--

CREATE VIEW pr.d AS
 SELECT document.title,
    document.owner,
    document.folderflag,
    document.filename,
    document.fileextension,
    document.revision,
    document.changenumber,
    document.status,
    document.documentsummary,
    document.document,
    document.rowguid,
    document.modifieddate,
    document.documentnode
   FROM production.document;


ALTER TABLE pr.d OWNER TO adventureworks_user;

--
-- Name: illustration; Type: TABLE; Schema: production; Owner: adventureworks_user
--

CREATE TABLE production.illustration (
    illustrationid integer NOT NULL,
    diagram xml,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.illustration OWNER TO adventureworks_user;

--
-- Name: TABLE illustration; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON TABLE production.illustration IS 'Bicycle assembly diagrams.';


--
-- Name: COLUMN illustration.illustrationid; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.illustration.illustrationid IS 'Primary key for Illustration records.';


--
-- Name: COLUMN illustration.diagram; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.illustration.diagram IS 'Illustrations used in manufacturing instructions. Stored as XML.';


--
-- Name: i; Type: VIEW; Schema: pr; Owner: adventureworks_user
--

CREATE VIEW pr.i AS
 SELECT illustration.illustrationid AS id,
    illustration.illustrationid,
    illustration.diagram,
    illustration.modifieddate
   FROM production.illustration;


ALTER TABLE pr.i OWNER TO adventureworks_user;

--
-- Name: location; Type: TABLE; Schema: production; Owner: adventureworks_user
--

CREATE TABLE production.location (
    locationid integer NOT NULL,
    name public."Name" NOT NULL,
    costrate numeric DEFAULT 0.00 NOT NULL,
    availability numeric(8,2) DEFAULT 0.00 NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_Location_Availability" CHECK ((availability >= 0.00)),
    CONSTRAINT "CK_Location_CostRate" CHECK ((costrate >= 0.00))
);


ALTER TABLE production.location OWNER TO adventureworks_user;

--
-- Name: TABLE location; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON TABLE production.location IS 'Product inventory and manufacturing locations.';


--
-- Name: COLUMN location.locationid; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.location.locationid IS 'Primary key for Location records.';


--
-- Name: COLUMN location.name; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.location.name IS 'Location description.';


--
-- Name: COLUMN location.costrate; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.location.costrate IS 'Standard hourly cost of the manufacturing location.';


--
-- Name: COLUMN location.availability; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.location.availability IS 'Work capacity (in hours) of the manufacturing location.';


--
-- Name: l; Type: VIEW; Schema: pr; Owner: adventureworks_user
--

CREATE VIEW pr.l AS
 SELECT location.locationid AS id,
    location.locationid,
    location.name,
    location.costrate,
    location.availability,
    location.modifieddate
   FROM production.location;


ALTER TABLE pr.l OWNER TO adventureworks_user;

--
-- Name: product; Type: TABLE; Schema: production; Owner: adventureworks_user
--

CREATE TABLE production.product (
    productid integer NOT NULL,
    name public."Name" NOT NULL,
    productnumber character varying(25) NOT NULL,
    makeflag public."Flag" DEFAULT true NOT NULL,
    finishedgoodsflag public."Flag" DEFAULT true NOT NULL,
    color character varying(15),
    safetystocklevel smallint NOT NULL,
    reorderpoint smallint NOT NULL,
    standardcost numeric NOT NULL,
    listprice numeric NOT NULL,
    size character varying(5),
    sizeunitmeasurecode character(3),
    weightunitmeasurecode character(3),
    weight numeric(8,2),
    daystomanufacture integer NOT NULL,
    productline character(2),
    class character(2),
    style character(2),
    productsubcategoryid integer,
    productmodelid integer,
    sellstartdate timestamp without time zone NOT NULL,
    sellenddate timestamp without time zone,
    discontinueddate timestamp without time zone,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_Product_Class" CHECK (((upper((class)::text) = ANY (ARRAY['L'::text, 'M'::text, 'H'::text])) OR (class IS NULL))),
    CONSTRAINT "CK_Product_DaysToManufacture" CHECK ((daystomanufacture >= 0)),
    CONSTRAINT "CK_Product_ListPrice" CHECK ((listprice >= 0.00)),
    CONSTRAINT "CK_Product_ProductLine" CHECK (((upper((productline)::text) = ANY (ARRAY['S'::text, 'T'::text, 'M'::text, 'R'::text])) OR (productline IS NULL))),
    CONSTRAINT "CK_Product_ReorderPoint" CHECK ((reorderpoint > 0)),
    CONSTRAINT "CK_Product_SafetyStockLevel" CHECK ((safetystocklevel > 0)),
    CONSTRAINT "CK_Product_SellEndDate" CHECK (((sellenddate >= sellstartdate) OR (sellenddate IS NULL))),
    CONSTRAINT "CK_Product_StandardCost" CHECK ((standardcost >= 0.00)),
    CONSTRAINT "CK_Product_Style" CHECK (((upper((style)::text) = ANY (ARRAY['W'::text, 'M'::text, 'U'::text])) OR (style IS NULL))),
    CONSTRAINT "CK_Product_Weight" CHECK ((weight > 0.00))
);


ALTER TABLE production.product OWNER TO adventureworks_user;

--
-- Name: TABLE product; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON TABLE production.product IS 'Products sold or used in the manfacturing of sold products.';


--
-- Name: COLUMN product.productid; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.product.productid IS 'Primary key for Product records.';


--
-- Name: COLUMN product.name; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.product.name IS 'Name of the product.';


--
-- Name: COLUMN product.productnumber; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.product.productnumber IS 'Unique product identification number.';


--
-- Name: COLUMN product.makeflag; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.product.makeflag IS '0 = Product is purchased, 1 = Product is manufactured in-house.';


--
-- Name: COLUMN product.finishedgoodsflag; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.product.finishedgoodsflag IS '0 = Product is not a salable item. 1 = Product is salable.';


--
-- Name: COLUMN product.color; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.product.color IS 'Product color.';


--
-- Name: COLUMN product.safetystocklevel; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.product.safetystocklevel IS 'Minimum inventory quantity.';


--
-- Name: COLUMN product.reorderpoint; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.product.reorderpoint IS 'Inventory level that triggers a purchase order or work order.';


--
-- Name: COLUMN product.standardcost; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.product.standardcost IS 'Standard cost of the product.';


--
-- Name: COLUMN product.listprice; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.product.listprice IS 'Selling price.';


--
-- Name: COLUMN product.size; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.product.size IS 'Product size.';


--
-- Name: COLUMN product.sizeunitmeasurecode; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.product.sizeunitmeasurecode IS 'Unit of measure for Size column.';


--
-- Name: COLUMN product.weightunitmeasurecode; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.product.weightunitmeasurecode IS 'Unit of measure for Weight column.';


--
-- Name: COLUMN product.weight; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.product.weight IS 'Product weight.';


--
-- Name: COLUMN product.daystomanufacture; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.product.daystomanufacture IS 'Number of days required to manufacture the product.';


--
-- Name: COLUMN product.productline; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.product.productline IS 'R = Road, M = Mountain, T = Touring, S = Standard';


--
-- Name: COLUMN product.class; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.product.class IS 'H = High, M = Medium, L = Low';


--
-- Name: COLUMN product.style; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.product.style IS 'W = Womens, M = Mens, U = Universal';


--
-- Name: COLUMN product.productsubcategoryid; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.product.productsubcategoryid IS 'Product is a member of this product subcategory. Foreign key to ProductSubCategory.ProductSubCategoryID.';


--
-- Name: COLUMN product.productmodelid; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.product.productmodelid IS 'Product is a member of this product model. Foreign key to ProductModel.ProductModelID.';


--
-- Name: COLUMN product.sellstartdate; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.product.sellstartdate IS 'Date the product was available for sale.';


--
-- Name: COLUMN product.sellenddate; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.product.sellenddate IS 'Date the product was no longer available for sale.';


--
-- Name: COLUMN product.discontinueddate; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.product.discontinueddate IS 'Date the product was discontinued.';


--
-- Name: p; Type: VIEW; Schema: pr; Owner: adventureworks_user
--

CREATE VIEW pr.p AS
 SELECT product.productid AS id,
    product.productid,
    product.name,
    product.productnumber,
    product.makeflag,
    product.finishedgoodsflag,
    product.color,
    product.safetystocklevel,
    product.reorderpoint,
    product.standardcost,
    product.listprice,
    product.size,
    product.sizeunitmeasurecode,
    product.weightunitmeasurecode,
    product.weight,
    product.daystomanufacture,
    product.productline,
    product.class,
    product.style,
    product.productsubcategoryid,
    product.productmodelid,
    product.sellstartdate,
    product.sellenddate,
    product.discontinueddate,
    product.rowguid,
    product.modifieddate
   FROM production.product;


ALTER TABLE pr.p OWNER TO adventureworks_user;

--
-- Name: productcategory; Type: TABLE; Schema: production; Owner: adventureworks_user
--

CREATE TABLE production.productcategory (
    productcategoryid integer NOT NULL,
    name public."Name" NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.productcategory OWNER TO adventureworks_user;

--
-- Name: TABLE productcategory; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON TABLE production.productcategory IS 'High-level product categorization.';


--
-- Name: COLUMN productcategory.productcategoryid; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.productcategory.productcategoryid IS 'Primary key for ProductCategory records.';


--
-- Name: COLUMN productcategory.name; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.productcategory.name IS 'Category description.';


--
-- Name: pc; Type: VIEW; Schema: pr; Owner: adventureworks_user
--

CREATE VIEW pr.pc AS
 SELECT productcategory.productcategoryid AS id,
    productcategory.productcategoryid,
    productcategory.name,
    productcategory.rowguid,
    productcategory.modifieddate
   FROM production.productcategory;


ALTER TABLE pr.pc OWNER TO adventureworks_user;

--
-- Name: productcosthistory; Type: TABLE; Schema: production; Owner: adventureworks_user
--

CREATE TABLE production.productcosthistory (
    productid integer NOT NULL,
    startdate timestamp without time zone NOT NULL,
    enddate timestamp without time zone,
    standardcost numeric NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ProductCostHistory_EndDate" CHECK (((enddate >= startdate) OR (enddate IS NULL))),
    CONSTRAINT "CK_ProductCostHistory_StandardCost" CHECK ((standardcost >= 0.00))
);


ALTER TABLE production.productcosthistory OWNER TO adventureworks_user;

--
-- Name: TABLE productcosthistory; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON TABLE production.productcosthistory IS 'Changes in the cost of a product over time.';


--
-- Name: COLUMN productcosthistory.productid; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.productcosthistory.productid IS 'Product identification number. Foreign key to Product.ProductID';


--
-- Name: COLUMN productcosthistory.startdate; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.productcosthistory.startdate IS 'Product cost start date.';


--
-- Name: COLUMN productcosthistory.enddate; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.productcosthistory.enddate IS 'Product cost end date.';


--
-- Name: COLUMN productcosthistory.standardcost; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.productcosthistory.standardcost IS 'Standard cost of the product.';


--
-- Name: pch; Type: VIEW; Schema: pr; Owner: adventureworks_user
--

CREATE VIEW pr.pch AS
 SELECT productcosthistory.productid AS id,
    productcosthistory.productid,
    productcosthistory.startdate,
    productcosthistory.enddate,
    productcosthistory.standardcost,
    productcosthistory.modifieddate
   FROM production.productcosthistory;


ALTER TABLE pr.pch OWNER TO adventureworks_user;

--
-- Name: productdescription; Type: TABLE; Schema: production; Owner: adventureworks_user
--

CREATE TABLE production.productdescription (
    productdescriptionid integer NOT NULL,
    description character varying(400) NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.productdescription OWNER TO adventureworks_user;

--
-- Name: TABLE productdescription; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON TABLE production.productdescription IS 'Product descriptions in several languages.';


--
-- Name: COLUMN productdescription.productdescriptionid; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.productdescription.productdescriptionid IS 'Primary key for ProductDescription records.';


--
-- Name: COLUMN productdescription.description; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.productdescription.description IS 'Description of the product.';


--
-- Name: pd; Type: VIEW; Schema: pr; Owner: adventureworks_user
--

CREATE VIEW pr.pd AS
 SELECT productdescription.productdescriptionid AS id,
    productdescription.productdescriptionid,
    productdescription.description,
    productdescription.rowguid,
    productdescription.modifieddate
   FROM production.productdescription;


ALTER TABLE pr.pd OWNER TO adventureworks_user;

--
-- Name: productdocument; Type: TABLE; Schema: production; Owner: adventureworks_user
--

CREATE TABLE production.productdocument (
    productid integer NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    documentnode character varying DEFAULT '/'::character varying NOT NULL
);


ALTER TABLE production.productdocument OWNER TO adventureworks_user;

--
-- Name: TABLE productdocument; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON TABLE production.productdocument IS 'Cross-reference table mapping products to related product documents.';


--
-- Name: COLUMN productdocument.productid; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.productdocument.productid IS 'Product identification number. Foreign key to Product.ProductID.';


--
-- Name: COLUMN productdocument.documentnode; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.productdocument.documentnode IS 'Document identification number. Foreign key to Document.DocumentNode.';


--
-- Name: pdoc; Type: VIEW; Schema: pr; Owner: adventureworks_user
--

CREATE VIEW pr.pdoc AS
 SELECT productdocument.productid AS id,
    productdocument.productid,
    productdocument.modifieddate,
    productdocument.documentnode
   FROM production.productdocument;


ALTER TABLE pr.pdoc OWNER TO adventureworks_user;

--
-- Name: productinventory; Type: TABLE; Schema: production; Owner: adventureworks_user
--

CREATE TABLE production.productinventory (
    productid integer NOT NULL,
    locationid smallint NOT NULL,
    shelf character varying(10) NOT NULL,
    bin smallint NOT NULL,
    quantity smallint DEFAULT 0 NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ProductInventory_Bin" CHECK (((bin >= 0) AND (bin <= 100)))
);


ALTER TABLE production.productinventory OWNER TO adventureworks_user;

--
-- Name: TABLE productinventory; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON TABLE production.productinventory IS 'Product inventory information.';


--
-- Name: COLUMN productinventory.productid; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.productinventory.productid IS 'Product identification number. Foreign key to Product.ProductID.';


--
-- Name: COLUMN productinventory.locationid; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.productinventory.locationid IS 'Inventory location identification number. Foreign key to Location.LocationID.';


--
-- Name: COLUMN productinventory.shelf; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.productinventory.shelf IS 'Storage compartment within an inventory location.';


--
-- Name: COLUMN productinventory.bin; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.productinventory.bin IS 'Storage container on a shelf in an inventory location.';


--
-- Name: COLUMN productinventory.quantity; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.productinventory.quantity IS 'Quantity of products in the inventory location.';


--
-- Name: pi; Type: VIEW; Schema: pr; Owner: adventureworks_user
--

CREATE VIEW pr.pi AS
 SELECT productinventory.productid AS id,
    productinventory.productid,
    productinventory.locationid,
    productinventory.shelf,
    productinventory.bin,
    productinventory.quantity,
    productinventory.rowguid,
    productinventory.modifieddate
   FROM production.productinventory;


ALTER TABLE pr.pi OWNER TO adventureworks_user;

--
-- Name: productlistpricehistory; Type: TABLE; Schema: production; Owner: adventureworks_user
--

CREATE TABLE production.productlistpricehistory (
    productid integer NOT NULL,
    startdate timestamp without time zone NOT NULL,
    enddate timestamp without time zone,
    listprice numeric NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ProductListPriceHistory_EndDate" CHECK (((enddate >= startdate) OR (enddate IS NULL))),
    CONSTRAINT "CK_ProductListPriceHistory_ListPrice" CHECK ((listprice > 0.00))
);


ALTER TABLE production.productlistpricehistory OWNER TO adventureworks_user;

--
-- Name: TABLE productlistpricehistory; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON TABLE production.productlistpricehistory IS 'Changes in the list price of a product over time.';


--
-- Name: COLUMN productlistpricehistory.productid; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.productlistpricehistory.productid IS 'Product identification number. Foreign key to Product.ProductID';


--
-- Name: COLUMN productlistpricehistory.startdate; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.productlistpricehistory.startdate IS 'List price start date.';


--
-- Name: COLUMN productlistpricehistory.enddate; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.productlistpricehistory.enddate IS 'List price end date';


--
-- Name: COLUMN productlistpricehistory.listprice; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.productlistpricehistory.listprice IS 'Product list price.';


--
-- Name: plph; Type: VIEW; Schema: pr; Owner: adventureworks_user
--

CREATE VIEW pr.plph AS
 SELECT productlistpricehistory.productid AS id,
    productlistpricehistory.productid,
    productlistpricehistory.startdate,
    productlistpricehistory.enddate,
    productlistpricehistory.listprice,
    productlistpricehistory.modifieddate
   FROM production.productlistpricehistory;


ALTER TABLE pr.plph OWNER TO adventureworks_user;

--
-- Name: productmodel; Type: TABLE; Schema: production; Owner: adventureworks_user
--

CREATE TABLE production.productmodel (
    productmodelid integer NOT NULL,
    name public."Name" NOT NULL,
    catalogdescription xml,
    instructions xml,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.productmodel OWNER TO adventureworks_user;

--
-- Name: TABLE productmodel; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON TABLE production.productmodel IS 'Product model classification.';


--
-- Name: COLUMN productmodel.productmodelid; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.productmodel.productmodelid IS 'Primary key for ProductModel records.';


--
-- Name: COLUMN productmodel.name; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.productmodel.name IS 'Product model description.';


--
-- Name: COLUMN productmodel.catalogdescription; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.productmodel.catalogdescription IS 'Detailed product catalog information in xml format.';


--
-- Name: COLUMN productmodel.instructions; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.productmodel.instructions IS 'Manufacturing instructions in xml format.';


--
-- Name: pm; Type: VIEW; Schema: pr; Owner: adventureworks_user
--

CREATE VIEW pr.pm AS
 SELECT productmodel.productmodelid AS id,
    productmodel.productmodelid,
    productmodel.name,
    productmodel.catalogdescription,
    productmodel.instructions,
    productmodel.rowguid,
    productmodel.modifieddate
   FROM production.productmodel;


ALTER TABLE pr.pm OWNER TO adventureworks_user;

--
-- Name: productmodelillustration; Type: TABLE; Schema: production; Owner: adventureworks_user
--

CREATE TABLE production.productmodelillustration (
    productmodelid integer NOT NULL,
    illustrationid integer NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.productmodelillustration OWNER TO adventureworks_user;

--
-- Name: TABLE productmodelillustration; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON TABLE production.productmodelillustration IS 'Cross-reference table mapping product models and illustrations.';


--
-- Name: COLUMN productmodelillustration.productmodelid; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.productmodelillustration.productmodelid IS 'Primary key. Foreign key to ProductModel.ProductModelID.';


--
-- Name: COLUMN productmodelillustration.illustrationid; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.productmodelillustration.illustrationid IS 'Primary key. Foreign key to Illustration.IllustrationID.';


--
-- Name: pmi; Type: VIEW; Schema: pr; Owner: adventureworks_user
--

CREATE VIEW pr.pmi AS
 SELECT productmodelillustration.productmodelid,
    productmodelillustration.illustrationid,
    productmodelillustration.modifieddate
   FROM production.productmodelillustration;


ALTER TABLE pr.pmi OWNER TO adventureworks_user;

--
-- Name: productmodelproductdescriptionculture; Type: TABLE; Schema: production; Owner: adventureworks_user
--

CREATE TABLE production.productmodelproductdescriptionculture (
    productmodelid integer NOT NULL,
    productdescriptionid integer NOT NULL,
    cultureid character(6) NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.productmodelproductdescriptionculture OWNER TO adventureworks_user;

--
-- Name: TABLE productmodelproductdescriptionculture; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON TABLE production.productmodelproductdescriptionculture IS 'Cross-reference table mapping product descriptions and the language the description is written in.';


--
-- Name: COLUMN productmodelproductdescriptionculture.productmodelid; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.productmodelproductdescriptionculture.productmodelid IS 'Primary key. Foreign key to ProductModel.ProductModelID.';


--
-- Name: COLUMN productmodelproductdescriptionculture.productdescriptionid; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.productmodelproductdescriptionculture.productdescriptionid IS 'Primary key. Foreign key to ProductDescription.ProductDescriptionID.';


--
-- Name: COLUMN productmodelproductdescriptionculture.cultureid; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.productmodelproductdescriptionculture.cultureid IS 'Culture identification number. Foreign key to Culture.CultureID.';


--
-- Name: pmpdc; Type: VIEW; Schema: pr; Owner: adventureworks_user
--

CREATE VIEW pr.pmpdc AS
 SELECT productmodelproductdescriptionculture.productmodelid,
    productmodelproductdescriptionculture.productdescriptionid,
    productmodelproductdescriptionculture.cultureid,
    productmodelproductdescriptionculture.modifieddate
   FROM production.productmodelproductdescriptionculture;


ALTER TABLE pr.pmpdc OWNER TO adventureworks_user;

--
-- Name: productphoto; Type: TABLE; Schema: production; Owner: adventureworks_user
--

CREATE TABLE production.productphoto (
    productphotoid integer NOT NULL,
    thumbnailphoto bytea,
    thumbnailphotofilename character varying(50),
    largephoto bytea,
    largephotofilename character varying(50),
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.productphoto OWNER TO adventureworks_user;

--
-- Name: TABLE productphoto; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON TABLE production.productphoto IS 'Product images.';


--
-- Name: COLUMN productphoto.productphotoid; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.productphoto.productphotoid IS 'Primary key for ProductPhoto records.';


--
-- Name: COLUMN productphoto.thumbnailphoto; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.productphoto.thumbnailphoto IS 'Small image of the product.';


--
-- Name: COLUMN productphoto.thumbnailphotofilename; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.productphoto.thumbnailphotofilename IS 'Small image file name.';


--
-- Name: COLUMN productphoto.largephoto; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.productphoto.largephoto IS 'Large image of the product.';


--
-- Name: COLUMN productphoto.largephotofilename; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.productphoto.largephotofilename IS 'Large image file name.';


--
-- Name: pp; Type: VIEW; Schema: pr; Owner: adventureworks_user
--

CREATE VIEW pr.pp AS
 SELECT productphoto.productphotoid AS id,
    productphoto.productphotoid,
    productphoto.thumbnailphoto,
    productphoto.thumbnailphotofilename,
    productphoto.largephoto,
    productphoto.largephotofilename,
    productphoto.modifieddate
   FROM production.productphoto;


ALTER TABLE pr.pp OWNER TO adventureworks_user;

--
-- Name: productproductphoto; Type: TABLE; Schema: production; Owner: adventureworks_user
--

CREATE TABLE production.productproductphoto (
    productid integer NOT NULL,
    productphotoid integer NOT NULL,
    "primary" public."Flag" DEFAULT false NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.productproductphoto OWNER TO adventureworks_user;

--
-- Name: TABLE productproductphoto; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON TABLE production.productproductphoto IS 'Cross-reference table mapping products and product photos.';


--
-- Name: COLUMN productproductphoto.productid; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.productproductphoto.productid IS 'Product identification number. Foreign key to Product.ProductID.';


--
-- Name: COLUMN productproductphoto.productphotoid; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.productproductphoto.productphotoid IS 'Product photo identification number. Foreign key to ProductPhoto.ProductPhotoID.';


--
-- Name: COLUMN productproductphoto."primary"; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.productproductphoto."primary" IS '0 = Photo is not the principal image. 1 = Photo is the principal image.';


--
-- Name: ppp; Type: VIEW; Schema: pr; Owner: adventureworks_user
--

CREATE VIEW pr.ppp AS
 SELECT productproductphoto.productid,
    productproductphoto.productphotoid,
    productproductphoto."primary",
    productproductphoto.modifieddate
   FROM production.productproductphoto;


ALTER TABLE pr.ppp OWNER TO adventureworks_user;

--
-- Name: productreview; Type: TABLE; Schema: production; Owner: adventureworks_user
--

CREATE TABLE production.productreview (
    productreviewid integer NOT NULL,
    productid integer NOT NULL,
    reviewername public."Name" NOT NULL,
    reviewdate timestamp without time zone DEFAULT now() NOT NULL,
    emailaddress character varying(50) NOT NULL,
    rating integer NOT NULL,
    comments character varying(3850),
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ProductReview_Rating" CHECK (((rating >= 1) AND (rating <= 5)))
);


ALTER TABLE production.productreview OWNER TO adventureworks_user;

--
-- Name: TABLE productreview; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON TABLE production.productreview IS 'Customer reviews of products they have purchased.';


--
-- Name: COLUMN productreview.productreviewid; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.productreview.productreviewid IS 'Primary key for ProductReview records.';


--
-- Name: COLUMN productreview.productid; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.productreview.productid IS 'Product identification number. Foreign key to Product.ProductID.';


--
-- Name: COLUMN productreview.reviewername; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.productreview.reviewername IS 'Name of the reviewer.';


--
-- Name: COLUMN productreview.reviewdate; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.productreview.reviewdate IS 'Date review was submitted.';


--
-- Name: COLUMN productreview.emailaddress; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.productreview.emailaddress IS 'Reviewer''s e-mail address.';


--
-- Name: COLUMN productreview.rating; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.productreview.rating IS 'Product rating given by the reviewer. Scale is 1 to 5 with 5 as the highest rating.';


--
-- Name: COLUMN productreview.comments; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.productreview.comments IS 'Reviewer''s comments';


--
-- Name: pr; Type: VIEW; Schema: pr; Owner: adventureworks_user
--

CREATE VIEW pr.pr AS
 SELECT productreview.productreviewid AS id,
    productreview.productreviewid,
    productreview.productid,
    productreview.reviewername,
    productreview.reviewdate,
    productreview.emailaddress,
    productreview.rating,
    productreview.comments,
    productreview.modifieddate
   FROM production.productreview;


ALTER TABLE pr.pr OWNER TO adventureworks_user;

--
-- Name: productsubcategory; Type: TABLE; Schema: production; Owner: adventureworks_user
--

CREATE TABLE production.productsubcategory (
    productsubcategoryid integer NOT NULL,
    productcategoryid integer NOT NULL,
    name public."Name" NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.productsubcategory OWNER TO adventureworks_user;

--
-- Name: TABLE productsubcategory; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON TABLE production.productsubcategory IS 'Product subcategories. See ProductCategory table.';


--
-- Name: COLUMN productsubcategory.productsubcategoryid; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.productsubcategory.productsubcategoryid IS 'Primary key for ProductSubcategory records.';


--
-- Name: COLUMN productsubcategory.productcategoryid; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.productsubcategory.productcategoryid IS 'Product category identification number. Foreign key to ProductCategory.ProductCategoryID.';


--
-- Name: COLUMN productsubcategory.name; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.productsubcategory.name IS 'Subcategory description.';


--
-- Name: psc; Type: VIEW; Schema: pr; Owner: adventureworks_user
--

CREATE VIEW pr.psc AS
 SELECT productsubcategory.productsubcategoryid AS id,
    productsubcategory.productsubcategoryid,
    productsubcategory.productcategoryid,
    productsubcategory.name,
    productsubcategory.rowguid,
    productsubcategory.modifieddate
   FROM production.productsubcategory;


ALTER TABLE pr.psc OWNER TO adventureworks_user;

--
-- Name: scrapreason; Type: TABLE; Schema: production; Owner: adventureworks_user
--

CREATE TABLE production.scrapreason (
    scrapreasonid integer NOT NULL,
    name public."Name" NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.scrapreason OWNER TO adventureworks_user;

--
-- Name: TABLE scrapreason; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON TABLE production.scrapreason IS 'Manufacturing failure reasons lookup table.';


--
-- Name: COLUMN scrapreason.scrapreasonid; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.scrapreason.scrapreasonid IS 'Primary key for ScrapReason records.';


--
-- Name: COLUMN scrapreason.name; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.scrapreason.name IS 'Failure description.';


--
-- Name: sr; Type: VIEW; Schema: pr; Owner: adventureworks_user
--

CREATE VIEW pr.sr AS
 SELECT scrapreason.scrapreasonid AS id,
    scrapreason.scrapreasonid,
    scrapreason.name,
    scrapreason.modifieddate
   FROM production.scrapreason;


ALTER TABLE pr.sr OWNER TO adventureworks_user;

--
-- Name: transactionhistory; Type: TABLE; Schema: production; Owner: adventureworks_user
--

CREATE TABLE production.transactionhistory (
    transactionid integer NOT NULL,
    productid integer NOT NULL,
    referenceorderid integer NOT NULL,
    referenceorderlineid integer DEFAULT 0 NOT NULL,
    transactiondate timestamp without time zone DEFAULT now() NOT NULL,
    transactiontype character(1) NOT NULL,
    quantity integer NOT NULL,
    actualcost numeric NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_TransactionHistory_TransactionType" CHECK ((upper((transactiontype)::text) = ANY (ARRAY['W'::text, 'S'::text, 'P'::text])))
);


ALTER TABLE production.transactionhistory OWNER TO adventureworks_user;

--
-- Name: TABLE transactionhistory; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON TABLE production.transactionhistory IS 'Record of each purchase order, sales order, or work order transaction year to date.';


--
-- Name: COLUMN transactionhistory.transactionid; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.transactionhistory.transactionid IS 'Primary key for TransactionHistory records.';


--
-- Name: COLUMN transactionhistory.productid; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.transactionhistory.productid IS 'Product identification number. Foreign key to Product.ProductID.';


--
-- Name: COLUMN transactionhistory.referenceorderid; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.transactionhistory.referenceorderid IS 'Purchase order, sales order, or work order identification number.';


--
-- Name: COLUMN transactionhistory.referenceorderlineid; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.transactionhistory.referenceorderlineid IS 'Line number associated with the purchase order, sales order, or work order.';


--
-- Name: COLUMN transactionhistory.transactiondate; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.transactionhistory.transactiondate IS 'Date and time of the transaction.';


--
-- Name: COLUMN transactionhistory.transactiontype; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.transactionhistory.transactiontype IS 'W = WorkOrder, S = SalesOrder, P = PurchaseOrder';


--
-- Name: COLUMN transactionhistory.quantity; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.transactionhistory.quantity IS 'Product quantity.';


--
-- Name: COLUMN transactionhistory.actualcost; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.transactionhistory.actualcost IS 'Product cost.';


--
-- Name: th; Type: VIEW; Schema: pr; Owner: adventureworks_user
--

CREATE VIEW pr.th AS
 SELECT transactionhistory.transactionid AS id,
    transactionhistory.transactionid,
    transactionhistory.productid,
    transactionhistory.referenceorderid,
    transactionhistory.referenceorderlineid,
    transactionhistory.transactiondate,
    transactionhistory.transactiontype,
    transactionhistory.quantity,
    transactionhistory.actualcost,
    transactionhistory.modifieddate
   FROM production.transactionhistory;


ALTER TABLE pr.th OWNER TO adventureworks_user;

--
-- Name: transactionhistoryarchive; Type: TABLE; Schema: production; Owner: adventureworks_user
--

CREATE TABLE production.transactionhistoryarchive (
    transactionid integer NOT NULL,
    productid integer NOT NULL,
    referenceorderid integer NOT NULL,
    referenceorderlineid integer DEFAULT 0 NOT NULL,
    transactiondate timestamp without time zone DEFAULT now() NOT NULL,
    transactiontype character(1) NOT NULL,
    quantity integer NOT NULL,
    actualcost numeric NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_TransactionHistoryArchive_TransactionType" CHECK ((upper((transactiontype)::text) = ANY (ARRAY['W'::text, 'S'::text, 'P'::text])))
);


ALTER TABLE production.transactionhistoryarchive OWNER TO adventureworks_user;

--
-- Name: TABLE transactionhistoryarchive; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON TABLE production.transactionhistoryarchive IS 'Transactions for previous years.';


--
-- Name: COLUMN transactionhistoryarchive.transactionid; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.transactionhistoryarchive.transactionid IS 'Primary key for TransactionHistoryArchive records.';


--
-- Name: COLUMN transactionhistoryarchive.productid; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.transactionhistoryarchive.productid IS 'Product identification number. Foreign key to Product.ProductID.';


--
-- Name: COLUMN transactionhistoryarchive.referenceorderid; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.transactionhistoryarchive.referenceorderid IS 'Purchase order, sales order, or work order identification number.';


--
-- Name: COLUMN transactionhistoryarchive.referenceorderlineid; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.transactionhistoryarchive.referenceorderlineid IS 'Line number associated with the purchase order, sales order, or work order.';


--
-- Name: COLUMN transactionhistoryarchive.transactiondate; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.transactionhistoryarchive.transactiondate IS 'Date and time of the transaction.';


--
-- Name: COLUMN transactionhistoryarchive.transactiontype; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.transactionhistoryarchive.transactiontype IS 'W = Work Order, S = Sales Order, P = Purchase Order';


--
-- Name: COLUMN transactionhistoryarchive.quantity; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.transactionhistoryarchive.quantity IS 'Product quantity.';


--
-- Name: COLUMN transactionhistoryarchive.actualcost; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.transactionhistoryarchive.actualcost IS 'Product cost.';


--
-- Name: tha; Type: VIEW; Schema: pr; Owner: adventureworks_user
--

CREATE VIEW pr.tha AS
 SELECT transactionhistoryarchive.transactionid AS id,
    transactionhistoryarchive.transactionid,
    transactionhistoryarchive.productid,
    transactionhistoryarchive.referenceorderid,
    transactionhistoryarchive.referenceorderlineid,
    transactionhistoryarchive.transactiondate,
    transactionhistoryarchive.transactiontype,
    transactionhistoryarchive.quantity,
    transactionhistoryarchive.actualcost,
    transactionhistoryarchive.modifieddate
   FROM production.transactionhistoryarchive;


ALTER TABLE pr.tha OWNER TO adventureworks_user;

--
-- Name: unitmeasure; Type: TABLE; Schema: production; Owner: adventureworks_user
--

CREATE TABLE production.unitmeasure (
    unitmeasurecode character(3) NOT NULL,
    name public."Name" NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE production.unitmeasure OWNER TO adventureworks_user;

--
-- Name: TABLE unitmeasure; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON TABLE production.unitmeasure IS 'Unit of measure lookup table.';


--
-- Name: COLUMN unitmeasure.unitmeasurecode; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.unitmeasure.unitmeasurecode IS 'Primary key.';


--
-- Name: COLUMN unitmeasure.name; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.unitmeasure.name IS 'Unit of measure description.';


--
-- Name: um; Type: VIEW; Schema: pr; Owner: adventureworks_user
--

CREATE VIEW pr.um AS
 SELECT unitmeasure.unitmeasurecode AS id,
    unitmeasure.unitmeasurecode,
    unitmeasure.name,
    unitmeasure.modifieddate
   FROM production.unitmeasure;


ALTER TABLE pr.um OWNER TO adventureworks_user;

--
-- Name: workorder; Type: TABLE; Schema: production; Owner: adventureworks_user
--

CREATE TABLE production.workorder (
    workorderid integer NOT NULL,
    productid integer NOT NULL,
    orderqty integer NOT NULL,
    scrappedqty smallint NOT NULL,
    startdate timestamp without time zone NOT NULL,
    enddate timestamp without time zone,
    duedate timestamp without time zone NOT NULL,
    scrapreasonid smallint,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_WorkOrder_EndDate" CHECK (((enddate >= startdate) OR (enddate IS NULL))),
    CONSTRAINT "CK_WorkOrder_OrderQty" CHECK ((orderqty > 0)),
    CONSTRAINT "CK_WorkOrder_ScrappedQty" CHECK ((scrappedqty >= 0))
);


ALTER TABLE production.workorder OWNER TO adventureworks_user;

--
-- Name: TABLE workorder; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON TABLE production.workorder IS 'Manufacturing work orders.';


--
-- Name: COLUMN workorder.workorderid; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.workorder.workorderid IS 'Primary key for WorkOrder records.';


--
-- Name: COLUMN workorder.productid; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.workorder.productid IS 'Product identification number. Foreign key to Product.ProductID.';


--
-- Name: COLUMN workorder.orderqty; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.workorder.orderqty IS 'Product quantity to build.';


--
-- Name: COLUMN workorder.scrappedqty; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.workorder.scrappedqty IS 'Quantity that failed inspection.';


--
-- Name: COLUMN workorder.startdate; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.workorder.startdate IS 'Work order start date.';


--
-- Name: COLUMN workorder.enddate; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.workorder.enddate IS 'Work order end date.';


--
-- Name: COLUMN workorder.duedate; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.workorder.duedate IS 'Work order due date.';


--
-- Name: COLUMN workorder.scrapreasonid; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.workorder.scrapreasonid IS 'Reason for inspection failure.';


--
-- Name: w; Type: VIEW; Schema: pr; Owner: adventureworks_user
--

CREATE VIEW pr.w AS
 SELECT workorder.workorderid AS id,
    workorder.workorderid,
    workorder.productid,
    workorder.orderqty,
    workorder.scrappedqty,
    workorder.startdate,
    workorder.enddate,
    workorder.duedate,
    workorder.scrapreasonid,
    workorder.modifieddate
   FROM production.workorder;


ALTER TABLE pr.w OWNER TO adventureworks_user;

--
-- Name: workorderrouting; Type: TABLE; Schema: production; Owner: adventureworks_user
--

CREATE TABLE production.workorderrouting (
    workorderid integer NOT NULL,
    productid integer NOT NULL,
    operationsequence smallint NOT NULL,
    locationid smallint NOT NULL,
    scheduledstartdate timestamp without time zone NOT NULL,
    scheduledenddate timestamp without time zone NOT NULL,
    actualstartdate timestamp without time zone,
    actualenddate timestamp without time zone,
    actualresourcehrs numeric(9,4),
    plannedcost numeric NOT NULL,
    actualcost numeric,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_WorkOrderRouting_ActualCost" CHECK ((actualcost > 0.00)),
    CONSTRAINT "CK_WorkOrderRouting_ActualEndDate" CHECK (((actualenddate >= actualstartdate) OR (actualenddate IS NULL) OR (actualstartdate IS NULL))),
    CONSTRAINT "CK_WorkOrderRouting_ActualResourceHrs" CHECK ((actualresourcehrs >= 0.0000)),
    CONSTRAINT "CK_WorkOrderRouting_PlannedCost" CHECK ((plannedcost > 0.00)),
    CONSTRAINT "CK_WorkOrderRouting_ScheduledEndDate" CHECK ((scheduledenddate >= scheduledstartdate))
);


ALTER TABLE production.workorderrouting OWNER TO adventureworks_user;

--
-- Name: TABLE workorderrouting; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON TABLE production.workorderrouting IS 'Work order details.';


--
-- Name: COLUMN workorderrouting.workorderid; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.workorderrouting.workorderid IS 'Primary key. Foreign key to WorkOrder.WorkOrderID.';


--
-- Name: COLUMN workorderrouting.productid; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.workorderrouting.productid IS 'Primary key. Foreign key to Product.ProductID.';


--
-- Name: COLUMN workorderrouting.operationsequence; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.workorderrouting.operationsequence IS 'Primary key. Indicates the manufacturing process sequence.';


--
-- Name: COLUMN workorderrouting.locationid; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.workorderrouting.locationid IS 'Manufacturing location where the part is processed. Foreign key to Location.LocationID.';


--
-- Name: COLUMN workorderrouting.scheduledstartdate; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.workorderrouting.scheduledstartdate IS 'Planned manufacturing start date.';


--
-- Name: COLUMN workorderrouting.scheduledenddate; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.workorderrouting.scheduledenddate IS 'Planned manufacturing end date.';


--
-- Name: COLUMN workorderrouting.actualstartdate; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.workorderrouting.actualstartdate IS 'Actual start date.';


--
-- Name: COLUMN workorderrouting.actualenddate; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.workorderrouting.actualenddate IS 'Actual end date.';


--
-- Name: COLUMN workorderrouting.actualresourcehrs; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.workorderrouting.actualresourcehrs IS 'Number of manufacturing hours used.';


--
-- Name: COLUMN workorderrouting.plannedcost; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.workorderrouting.plannedcost IS 'Estimated manufacturing cost.';


--
-- Name: COLUMN workorderrouting.actualcost; Type: COMMENT; Schema: production; Owner: adventureworks_user
--

COMMENT ON COLUMN production.workorderrouting.actualcost IS 'Actual manufacturing cost.';


--
-- Name: wr; Type: VIEW; Schema: pr; Owner: adventureworks_user
--

CREATE VIEW pr.wr AS
 SELECT workorderrouting.workorderid AS id,
    workorderrouting.workorderid,
    workorderrouting.productid,
    workorderrouting.operationsequence,
    workorderrouting.locationid,
    workorderrouting.scheduledstartdate,
    workorderrouting.scheduledenddate,
    workorderrouting.actualstartdate,
    workorderrouting.actualenddate,
    workorderrouting.actualresourcehrs,
    workorderrouting.plannedcost,
    workorderrouting.actualcost,
    workorderrouting.modifieddate
   FROM production.workorderrouting;


ALTER TABLE pr.wr OWNER TO adventureworks_user;

--
-- Name: billofmaterials_billofmaterialsid_seq; Type: SEQUENCE; Schema: production; Owner: adventureworks_user
--

CREATE SEQUENCE production.billofmaterials_billofmaterialsid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE production.billofmaterials_billofmaterialsid_seq OWNER TO adventureworks_user;

--
-- Name: billofmaterials_billofmaterialsid_seq; Type: SEQUENCE OWNED BY; Schema: production; Owner: adventureworks_user
--

ALTER SEQUENCE production.billofmaterials_billofmaterialsid_seq OWNED BY production.billofmaterials.billofmaterialsid;


--
-- Name: illustration_illustrationid_seq; Type: SEQUENCE; Schema: production; Owner: adventureworks_user
--

CREATE SEQUENCE production.illustration_illustrationid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE production.illustration_illustrationid_seq OWNER TO adventureworks_user;

--
-- Name: illustration_illustrationid_seq; Type: SEQUENCE OWNED BY; Schema: production; Owner: adventureworks_user
--

ALTER SEQUENCE production.illustration_illustrationid_seq OWNED BY production.illustration.illustrationid;


--
-- Name: location_locationid_seq; Type: SEQUENCE; Schema: production; Owner: adventureworks_user
--

CREATE SEQUENCE production.location_locationid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE production.location_locationid_seq OWNER TO adventureworks_user;

--
-- Name: location_locationid_seq; Type: SEQUENCE OWNED BY; Schema: production; Owner: adventureworks_user
--

ALTER SEQUENCE production.location_locationid_seq OWNED BY production.location.locationid;


--
-- Name: product_productid_seq; Type: SEQUENCE; Schema: production; Owner: adventureworks_user
--

CREATE SEQUENCE production.product_productid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE production.product_productid_seq OWNER TO adventureworks_user;

--
-- Name: product_productid_seq; Type: SEQUENCE OWNED BY; Schema: production; Owner: adventureworks_user
--

ALTER SEQUENCE production.product_productid_seq OWNED BY production.product.productid;


--
-- Name: productcategory_productcategoryid_seq; Type: SEQUENCE; Schema: production; Owner: adventureworks_user
--

CREATE SEQUENCE production.productcategory_productcategoryid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE production.productcategory_productcategoryid_seq OWNER TO adventureworks_user;

--
-- Name: productcategory_productcategoryid_seq; Type: SEQUENCE OWNED BY; Schema: production; Owner: adventureworks_user
--

ALTER SEQUENCE production.productcategory_productcategoryid_seq OWNED BY production.productcategory.productcategoryid;


--
-- Name: productdescription_productdescriptionid_seq; Type: SEQUENCE; Schema: production; Owner: adventureworks_user
--

CREATE SEQUENCE production.productdescription_productdescriptionid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE production.productdescription_productdescriptionid_seq OWNER TO adventureworks_user;

--
-- Name: productdescription_productdescriptionid_seq; Type: SEQUENCE OWNED BY; Schema: production; Owner: adventureworks_user
--

ALTER SEQUENCE production.productdescription_productdescriptionid_seq OWNED BY production.productdescription.productdescriptionid;


--
-- Name: productmodel_productmodelid_seq; Type: SEQUENCE; Schema: production; Owner: adventureworks_user
--

CREATE SEQUENCE production.productmodel_productmodelid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE production.productmodel_productmodelid_seq OWNER TO adventureworks_user;

--
-- Name: productmodel_productmodelid_seq; Type: SEQUENCE OWNED BY; Schema: production; Owner: adventureworks_user
--

ALTER SEQUENCE production.productmodel_productmodelid_seq OWNED BY production.productmodel.productmodelid;


--
-- Name: productphoto_productphotoid_seq; Type: SEQUENCE; Schema: production; Owner: adventureworks_user
--

CREATE SEQUENCE production.productphoto_productphotoid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE production.productphoto_productphotoid_seq OWNER TO adventureworks_user;

--
-- Name: productphoto_productphotoid_seq; Type: SEQUENCE OWNED BY; Schema: production; Owner: adventureworks_user
--

ALTER SEQUENCE production.productphoto_productphotoid_seq OWNED BY production.productphoto.productphotoid;


--
-- Name: productreview_productreviewid_seq; Type: SEQUENCE; Schema: production; Owner: adventureworks_user
--

CREATE SEQUENCE production.productreview_productreviewid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE production.productreview_productreviewid_seq OWNER TO adventureworks_user;

--
-- Name: productreview_productreviewid_seq; Type: SEQUENCE OWNED BY; Schema: production; Owner: adventureworks_user
--

ALTER SEQUENCE production.productreview_productreviewid_seq OWNED BY production.productreview.productreviewid;


--
-- Name: productsubcategory_productsubcategoryid_seq; Type: SEQUENCE; Schema: production; Owner: adventureworks_user
--

CREATE SEQUENCE production.productsubcategory_productsubcategoryid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE production.productsubcategory_productsubcategoryid_seq OWNER TO adventureworks_user;

--
-- Name: productsubcategory_productsubcategoryid_seq; Type: SEQUENCE OWNED BY; Schema: production; Owner: adventureworks_user
--

ALTER SEQUENCE production.productsubcategory_productsubcategoryid_seq OWNED BY production.productsubcategory.productsubcategoryid;


--
-- Name: scrapreason_scrapreasonid_seq; Type: SEQUENCE; Schema: production; Owner: adventureworks_user
--

CREATE SEQUENCE production.scrapreason_scrapreasonid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE production.scrapreason_scrapreasonid_seq OWNER TO adventureworks_user;

--
-- Name: scrapreason_scrapreasonid_seq; Type: SEQUENCE OWNED BY; Schema: production; Owner: adventureworks_user
--

ALTER SEQUENCE production.scrapreason_scrapreasonid_seq OWNED BY production.scrapreason.scrapreasonid;


--
-- Name: transactionhistory_transactionid_seq; Type: SEQUENCE; Schema: production; Owner: adventureworks_user
--

CREATE SEQUENCE production.transactionhistory_transactionid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE production.transactionhistory_transactionid_seq OWNER TO adventureworks_user;

--
-- Name: transactionhistory_transactionid_seq; Type: SEQUENCE OWNED BY; Schema: production; Owner: adventureworks_user
--

ALTER SEQUENCE production.transactionhistory_transactionid_seq OWNED BY production.transactionhistory.transactionid;


--
-- Name: vproductanddescription; Type: MATERIALIZED VIEW; Schema: production; Owner: adventureworks_user
--

CREATE MATERIALIZED VIEW production.vproductanddescription AS
 SELECT p.productid,
    p.name,
    pm.name AS productmodel,
    pmx.cultureid,
    pd.description
   FROM (((production.product p
     JOIN production.productmodel pm ON ((p.productmodelid = pm.productmodelid)))
     JOIN production.productmodelproductdescriptionculture pmx ON ((pm.productmodelid = pmx.productmodelid)))
     JOIN production.productdescription pd ON ((pmx.productdescriptionid = pd.productdescriptionid)))
  WITH NO DATA;


ALTER TABLE production.vproductanddescription OWNER TO adventureworks_user;

--
-- Name: vproductmodelcatalogdescription; Type: VIEW; Schema: production; Owner: adventureworks_user
--

CREATE VIEW production.vproductmodelcatalogdescription AS
 SELECT productmodel.productmodelid,
    productmodel.name,
    ((xpath('/p1:ProductDescription/p1:Summary/html:p/text()'::text, productmodel.catalogdescription, '{{p1,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription},{html,http://www.w3.org/1999/xhtml}}'::text[]))[1])::character varying AS "Summary",
    ((xpath('/p1:ProductDescription/p1:Manufacturer/p1:Name/text()'::text, productmodel.catalogdescription, '{{p1,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription}}'::text[]))[1])::character varying AS manufacturer,
    ((xpath('/p1:ProductDescription/p1:Manufacturer/p1:Copyright/text()'::text, productmodel.catalogdescription, '{{p1,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription}}'::text[]))[1])::character varying(30) AS copyright,
    ((xpath('/p1:ProductDescription/p1:Manufacturer/p1:ProductURL/text()'::text, productmodel.catalogdescription, '{{p1,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription}}'::text[]))[1])::character varying(256) AS producturl,
    ((xpath('/p1:ProductDescription/p1:Features/wm:Warranty/wm:WarrantyPeriod/text()'::text, productmodel.catalogdescription, '{{p1,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription},{wm,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain}}'::text[]))[1])::character varying(256) AS warrantyperiod,
    ((xpath('/p1:ProductDescription/p1:Features/wm:Warranty/wm:Description/text()'::text, productmodel.catalogdescription, '{{p1,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription},{wm,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain}}'::text[]))[1])::character varying(256) AS warrantydescription,
    ((xpath('/p1:ProductDescription/p1:Features/wm:Maintenance/wm:NoOfYears/text()'::text, productmodel.catalogdescription, '{{p1,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription},{wm,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain}}'::text[]))[1])::character varying(256) AS noofyears,
    ((xpath('/p1:ProductDescription/p1:Features/wm:Maintenance/wm:Description/text()'::text, productmodel.catalogdescription, '{{p1,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription},{wm,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain}}'::text[]))[1])::character varying(256) AS maintenancedescription,
    ((xpath('/p1:ProductDescription/p1:Features/wf:wheel/text()'::text, productmodel.catalogdescription, '{{p1,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription},{wf,http://www.adventure-works.com/schemas/OtherFeatures}}'::text[]))[1])::character varying(256) AS wheel,
    ((xpath('/p1:ProductDescription/p1:Features/wf:saddle/text()'::text, productmodel.catalogdescription, '{{p1,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription},{wf,http://www.adventure-works.com/schemas/OtherFeatures}}'::text[]))[1])::character varying(256) AS saddle,
    ((xpath('/p1:ProductDescription/p1:Features/wf:pedal/text()'::text, productmodel.catalogdescription, '{{p1,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription},{wf,http://www.adventure-works.com/schemas/OtherFeatures}}'::text[]))[1])::character varying(256) AS pedal,
    ((xpath('/p1:ProductDescription/p1:Features/wf:BikeFrame/text()'::text, productmodel.catalogdescription, '{{p1,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription},{wf,http://www.adventure-works.com/schemas/OtherFeatures}}'::text[]))[1])::character varying AS bikeframe,
    ((xpath('/p1:ProductDescription/p1:Features/wf:crankset/text()'::text, productmodel.catalogdescription, '{{p1,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription},{wf,http://www.adventure-works.com/schemas/OtherFeatures}}'::text[]))[1])::character varying(256) AS crankset,
    ((xpath('/p1:ProductDescription/p1:Picture/p1:Angle/text()'::text, productmodel.catalogdescription, '{{p1,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription}}'::text[]))[1])::character varying(256) AS pictureangle,
    ((xpath('/p1:ProductDescription/p1:Picture/p1:Size/text()'::text, productmodel.catalogdescription, '{{p1,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription}}'::text[]))[1])::character varying(256) AS picturesize,
    ((xpath('/p1:ProductDescription/p1:Picture/p1:ProductPhotoID/text()'::text, productmodel.catalogdescription, '{{p1,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription}}'::text[]))[1])::character varying(256) AS productphotoid,
    ((xpath('/p1:ProductDescription/p1:Specifications/Material/text()'::text, productmodel.catalogdescription, '{{p1,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription}}'::text[]))[1])::character varying(256) AS material,
    ((xpath('/p1:ProductDescription/p1:Specifications/Color/text()'::text, productmodel.catalogdescription, '{{p1,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription}}'::text[]))[1])::character varying(256) AS color,
    ((xpath('/p1:ProductDescription/p1:Specifications/ProductLine/text()'::text, productmodel.catalogdescription, '{{p1,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription}}'::text[]))[1])::character varying(256) AS productline,
    ((xpath('/p1:ProductDescription/p1:Specifications/Style/text()'::text, productmodel.catalogdescription, '{{p1,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription}}'::text[]))[1])::character varying(256) AS style,
    ((xpath('/p1:ProductDescription/p1:Specifications/RiderExperience/text()'::text, productmodel.catalogdescription, '{{p1,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription}}'::text[]))[1])::character varying(1024) AS riderexperience,
    productmodel.rowguid,
    productmodel.modifieddate
   FROM production.productmodel
  WHERE (productmodel.catalogdescription IS NOT NULL);


ALTER TABLE production.vproductmodelcatalogdescription OWNER TO adventureworks_user;

--
-- Name: vproductmodelinstructions; Type: VIEW; Schema: production; Owner: adventureworks_user
--

CREATE VIEW production.vproductmodelinstructions AS
 SELECT pm.productmodelid,
    pm.name,
    ((xpath('/ns:root/text()'::text, pm.instructions, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelManuInstructions}}'::text[]))[1])::character varying AS instructions,
    (((xpath('@LocationID'::text, pm.mfginstructions))[1])::character varying)::integer AS "LocationID",
    (((xpath('@SetupHours'::text, pm.mfginstructions))[1])::character varying)::numeric(9,4) AS "SetupHours",
    (((xpath('@MachineHours'::text, pm.mfginstructions))[1])::character varying)::numeric(9,4) AS "MachineHours",
    (((xpath('@LaborHours'::text, pm.mfginstructions))[1])::character varying)::numeric(9,4) AS "LaborHours",
    (((xpath('@LotSize'::text, pm.mfginstructions))[1])::character varying)::integer AS "LotSize",
    ((xpath('/step/text()'::text, pm.step))[1])::character varying(1024) AS "Step",
    pm.rowguid,
    pm.modifieddate
   FROM ( SELECT locations.productmodelid,
            locations.name,
            locations.rowguid,
            locations.modifieddate,
            locations.instructions,
            locations.mfginstructions,
            unnest(xpath('step'::text, locations.mfginstructions)) AS step
           FROM ( SELECT productmodel.productmodelid,
                    productmodel.name,
                    productmodel.rowguid,
                    productmodel.modifieddate,
                    productmodel.instructions,
                    unnest(xpath('/ns:root/ns:Location'::text, productmodel.instructions, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelManuInstructions}}'::text[])) AS mfginstructions
                   FROM production.productmodel) locations) pm;


ALTER TABLE production.vproductmodelinstructions OWNER TO adventureworks_user;

--
-- Name: workorder_workorderid_seq; Type: SEQUENCE; Schema: production; Owner: adventureworks_user
--

CREATE SEQUENCE production.workorder_workorderid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE production.workorder_workorderid_seq OWNER TO adventureworks_user;

--
-- Name: workorder_workorderid_seq; Type: SEQUENCE OWNED BY; Schema: production; Owner: adventureworks_user
--

ALTER SEQUENCE production.workorder_workorderid_seq OWNED BY production.workorder.workorderid;


--
-- Name: purchaseorderdetail; Type: TABLE; Schema: purchasing; Owner: adventureworks_user
--

CREATE TABLE purchasing.purchaseorderdetail (
    purchaseorderid integer NOT NULL,
    purchaseorderdetailid integer NOT NULL,
    duedate timestamp without time zone NOT NULL,
    orderqty smallint NOT NULL,
    productid integer NOT NULL,
    unitprice numeric NOT NULL,
    receivedqty numeric(8,2) NOT NULL,
    rejectedqty numeric(8,2) NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_PurchaseOrderDetail_OrderQty" CHECK ((orderqty > 0)),
    CONSTRAINT "CK_PurchaseOrderDetail_ReceivedQty" CHECK ((receivedqty >= 0.00)),
    CONSTRAINT "CK_PurchaseOrderDetail_RejectedQty" CHECK ((rejectedqty >= 0.00)),
    CONSTRAINT "CK_PurchaseOrderDetail_UnitPrice" CHECK ((unitprice >= 0.00))
);


ALTER TABLE purchasing.purchaseorderdetail OWNER TO adventureworks_user;

--
-- Name: TABLE purchaseorderdetail; Type: COMMENT; Schema: purchasing; Owner: adventureworks_user
--

COMMENT ON TABLE purchasing.purchaseorderdetail IS 'Individual products associated with a specific purchase order. See PurchaseOrderHeader.';


--
-- Name: COLUMN purchaseorderdetail.purchaseorderid; Type: COMMENT; Schema: purchasing; Owner: adventureworks_user
--

COMMENT ON COLUMN purchasing.purchaseorderdetail.purchaseorderid IS 'Primary key. Foreign key to PurchaseOrderHeader.PurchaseOrderID.';


--
-- Name: COLUMN purchaseorderdetail.purchaseorderdetailid; Type: COMMENT; Schema: purchasing; Owner: adventureworks_user
--

COMMENT ON COLUMN purchasing.purchaseorderdetail.purchaseorderdetailid IS 'Primary key. One line number per purchased product.';


--
-- Name: COLUMN purchaseorderdetail.duedate; Type: COMMENT; Schema: purchasing; Owner: adventureworks_user
--

COMMENT ON COLUMN purchasing.purchaseorderdetail.duedate IS 'Date the product is expected to be received.';


--
-- Name: COLUMN purchaseorderdetail.orderqty; Type: COMMENT; Schema: purchasing; Owner: adventureworks_user
--

COMMENT ON COLUMN purchasing.purchaseorderdetail.orderqty IS 'Quantity ordered.';


--
-- Name: COLUMN purchaseorderdetail.productid; Type: COMMENT; Schema: purchasing; Owner: adventureworks_user
--

COMMENT ON COLUMN purchasing.purchaseorderdetail.productid IS 'Product identification number. Foreign key to Product.ProductID.';


--
-- Name: COLUMN purchaseorderdetail.unitprice; Type: COMMENT; Schema: purchasing; Owner: adventureworks_user
--

COMMENT ON COLUMN purchasing.purchaseorderdetail.unitprice IS 'Vendor''s selling price of a single product.';


--
-- Name: COLUMN purchaseorderdetail.receivedqty; Type: COMMENT; Schema: purchasing; Owner: adventureworks_user
--

COMMENT ON COLUMN purchasing.purchaseorderdetail.receivedqty IS 'Quantity actually received from the vendor.';


--
-- Name: COLUMN purchaseorderdetail.rejectedqty; Type: COMMENT; Schema: purchasing; Owner: adventureworks_user
--

COMMENT ON COLUMN purchasing.purchaseorderdetail.rejectedqty IS 'Quantity rejected during inspection.';


--
-- Name: pod; Type: VIEW; Schema: pu; Owner: adventureworks_user
--

CREATE VIEW pu.pod AS
 SELECT purchaseorderdetail.purchaseorderdetailid AS id,
    purchaseorderdetail.purchaseorderid,
    purchaseorderdetail.purchaseorderdetailid,
    purchaseorderdetail.duedate,
    purchaseorderdetail.orderqty,
    purchaseorderdetail.productid,
    purchaseorderdetail.unitprice,
    purchaseorderdetail.receivedqty,
    purchaseorderdetail.rejectedqty,
    purchaseorderdetail.modifieddate
   FROM purchasing.purchaseorderdetail;


ALTER TABLE pu.pod OWNER TO adventureworks_user;

--
-- Name: purchaseorderheader; Type: TABLE; Schema: purchasing; Owner: adventureworks_user
--

CREATE TABLE purchasing.purchaseorderheader (
    purchaseorderid integer NOT NULL,
    revisionnumber smallint DEFAULT 0 NOT NULL,
    status smallint DEFAULT 1 NOT NULL,
    employeeid integer NOT NULL,
    vendorid integer NOT NULL,
    shipmethodid integer NOT NULL,
    orderdate timestamp without time zone DEFAULT now() NOT NULL,
    shipdate timestamp without time zone,
    subtotal numeric DEFAULT 0.00 NOT NULL,
    taxamt numeric DEFAULT 0.00 NOT NULL,
    freight numeric DEFAULT 0.00 NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_PurchaseOrderHeader_Freight" CHECK ((freight >= 0.00)),
    CONSTRAINT "CK_PurchaseOrderHeader_ShipDate" CHECK (((shipdate >= orderdate) OR (shipdate IS NULL))),
    CONSTRAINT "CK_PurchaseOrderHeader_Status" CHECK (((status >= 1) AND (status <= 4))),
    CONSTRAINT "CK_PurchaseOrderHeader_SubTotal" CHECK ((subtotal >= 0.00)),
    CONSTRAINT "CK_PurchaseOrderHeader_TaxAmt" CHECK ((taxamt >= 0.00))
);


ALTER TABLE purchasing.purchaseorderheader OWNER TO adventureworks_user;

--
-- Name: TABLE purchaseorderheader; Type: COMMENT; Schema: purchasing; Owner: adventureworks_user
--

COMMENT ON TABLE purchasing.purchaseorderheader IS 'General purchase order information. See PurchaseOrderDetail.';


--
-- Name: COLUMN purchaseorderheader.purchaseorderid; Type: COMMENT; Schema: purchasing; Owner: adventureworks_user
--

COMMENT ON COLUMN purchasing.purchaseorderheader.purchaseorderid IS 'Primary key.';


--
-- Name: COLUMN purchaseorderheader.revisionnumber; Type: COMMENT; Schema: purchasing; Owner: adventureworks_user
--

COMMENT ON COLUMN purchasing.purchaseorderheader.revisionnumber IS 'Incremental number to track changes to the purchase order over time.';


--
-- Name: COLUMN purchaseorderheader.status; Type: COMMENT; Schema: purchasing; Owner: adventureworks_user
--

COMMENT ON COLUMN purchasing.purchaseorderheader.status IS 'Order current status. 1 = Pending; 2 = Approved; 3 = Rejected; 4 = Complete';


--
-- Name: COLUMN purchaseorderheader.employeeid; Type: COMMENT; Schema: purchasing; Owner: adventureworks_user
--

COMMENT ON COLUMN purchasing.purchaseorderheader.employeeid IS 'Employee who created the purchase order. Foreign key to Employee.BusinessEntityID.';


--
-- Name: COLUMN purchaseorderheader.vendorid; Type: COMMENT; Schema: purchasing; Owner: adventureworks_user
--

COMMENT ON COLUMN purchasing.purchaseorderheader.vendorid IS 'Vendor with whom the purchase order is placed. Foreign key to Vendor.BusinessEntityID.';


--
-- Name: COLUMN purchaseorderheader.shipmethodid; Type: COMMENT; Schema: purchasing; Owner: adventureworks_user
--

COMMENT ON COLUMN purchasing.purchaseorderheader.shipmethodid IS 'Shipping method. Foreign key to ShipMethod.ShipMethodID.';


--
-- Name: COLUMN purchaseorderheader.orderdate; Type: COMMENT; Schema: purchasing; Owner: adventureworks_user
--

COMMENT ON COLUMN purchasing.purchaseorderheader.orderdate IS 'Purchase order creation date.';


--
-- Name: COLUMN purchaseorderheader.shipdate; Type: COMMENT; Schema: purchasing; Owner: adventureworks_user
--

COMMENT ON COLUMN purchasing.purchaseorderheader.shipdate IS 'Estimated shipment date from the vendor.';


--
-- Name: COLUMN purchaseorderheader.subtotal; Type: COMMENT; Schema: purchasing; Owner: adventureworks_user
--

COMMENT ON COLUMN purchasing.purchaseorderheader.subtotal IS 'Purchase order subtotal. Computed as SUM(PurchaseOrderDetail.LineTotal)for the appropriate PurchaseOrderID.';


--
-- Name: COLUMN purchaseorderheader.taxamt; Type: COMMENT; Schema: purchasing; Owner: adventureworks_user
--

COMMENT ON COLUMN purchasing.purchaseorderheader.taxamt IS 'Tax amount.';


--
-- Name: COLUMN purchaseorderheader.freight; Type: COMMENT; Schema: purchasing; Owner: adventureworks_user
--

COMMENT ON COLUMN purchasing.purchaseorderheader.freight IS 'Shipping cost.';


--
-- Name: poh; Type: VIEW; Schema: pu; Owner: adventureworks_user
--

CREATE VIEW pu.poh AS
 SELECT purchaseorderheader.purchaseorderid AS id,
    purchaseorderheader.purchaseorderid,
    purchaseorderheader.revisionnumber,
    purchaseorderheader.status,
    purchaseorderheader.employeeid,
    purchaseorderheader.vendorid,
    purchaseorderheader.shipmethodid,
    purchaseorderheader.orderdate,
    purchaseorderheader.shipdate,
    purchaseorderheader.subtotal,
    purchaseorderheader.taxamt,
    purchaseorderheader.freight,
    purchaseorderheader.modifieddate
   FROM purchasing.purchaseorderheader;


ALTER TABLE pu.poh OWNER TO adventureworks_user;

--
-- Name: productvendor; Type: TABLE; Schema: purchasing; Owner: adventureworks_user
--

CREATE TABLE purchasing.productvendor (
    productid integer NOT NULL,
    businessentityid integer NOT NULL,
    averageleadtime integer NOT NULL,
    standardprice numeric NOT NULL,
    lastreceiptcost numeric,
    lastreceiptdate timestamp without time zone,
    minorderqty integer NOT NULL,
    maxorderqty integer NOT NULL,
    onorderqty integer,
    unitmeasurecode character(3) NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ProductVendor_AverageLeadTime" CHECK ((averageleadtime >= 1)),
    CONSTRAINT "CK_ProductVendor_LastReceiptCost" CHECK ((lastreceiptcost > 0.00)),
    CONSTRAINT "CK_ProductVendor_MaxOrderQty" CHECK ((maxorderqty >= 1)),
    CONSTRAINT "CK_ProductVendor_MinOrderQty" CHECK ((minorderqty >= 1)),
    CONSTRAINT "CK_ProductVendor_OnOrderQty" CHECK ((onorderqty >= 0)),
    CONSTRAINT "CK_ProductVendor_StandardPrice" CHECK ((standardprice > 0.00))
);


ALTER TABLE purchasing.productvendor OWNER TO adventureworks_user;

--
-- Name: TABLE productvendor; Type: COMMENT; Schema: purchasing; Owner: adventureworks_user
--

COMMENT ON TABLE purchasing.productvendor IS 'Cross-reference table mapping vendors with the products they supply.';


--
-- Name: COLUMN productvendor.productid; Type: COMMENT; Schema: purchasing; Owner: adventureworks_user
--

COMMENT ON COLUMN purchasing.productvendor.productid IS 'Primary key. Foreign key to Product.ProductID.';


--
-- Name: COLUMN productvendor.businessentityid; Type: COMMENT; Schema: purchasing; Owner: adventureworks_user
--

COMMENT ON COLUMN purchasing.productvendor.businessentityid IS 'Primary key. Foreign key to Vendor.BusinessEntityID.';


--
-- Name: COLUMN productvendor.averageleadtime; Type: COMMENT; Schema: purchasing; Owner: adventureworks_user
--

COMMENT ON COLUMN purchasing.productvendor.averageleadtime IS 'The average span of time (in days) between placing an order with the vendor and receiving the purchased product.';


--
-- Name: COLUMN productvendor.standardprice; Type: COMMENT; Schema: purchasing; Owner: adventureworks_user
--

COMMENT ON COLUMN purchasing.productvendor.standardprice IS 'The vendor''s usual selling price.';


--
-- Name: COLUMN productvendor.lastreceiptcost; Type: COMMENT; Schema: purchasing; Owner: adventureworks_user
--

COMMENT ON COLUMN purchasing.productvendor.lastreceiptcost IS 'The selling price when last purchased.';


--
-- Name: COLUMN productvendor.lastreceiptdate; Type: COMMENT; Schema: purchasing; Owner: adventureworks_user
--

COMMENT ON COLUMN purchasing.productvendor.lastreceiptdate IS 'Date the product was last received by the vendor.';


--
-- Name: COLUMN productvendor.minorderqty; Type: COMMENT; Schema: purchasing; Owner: adventureworks_user
--

COMMENT ON COLUMN purchasing.productvendor.minorderqty IS 'The maximum quantity that should be ordered.';


--
-- Name: COLUMN productvendor.maxorderqty; Type: COMMENT; Schema: purchasing; Owner: adventureworks_user
--

COMMENT ON COLUMN purchasing.productvendor.maxorderqty IS 'The minimum quantity that should be ordered.';


--
-- Name: COLUMN productvendor.onorderqty; Type: COMMENT; Schema: purchasing; Owner: adventureworks_user
--

COMMENT ON COLUMN purchasing.productvendor.onorderqty IS 'The quantity currently on order.';


--
-- Name: COLUMN productvendor.unitmeasurecode; Type: COMMENT; Schema: purchasing; Owner: adventureworks_user
--

COMMENT ON COLUMN purchasing.productvendor.unitmeasurecode IS 'The product''s unit of measure.';


--
-- Name: pv; Type: VIEW; Schema: pu; Owner: adventureworks_user
--

CREATE VIEW pu.pv AS
 SELECT productvendor.productid AS id,
    productvendor.productid,
    productvendor.businessentityid,
    productvendor.averageleadtime,
    productvendor.standardprice,
    productvendor.lastreceiptcost,
    productvendor.lastreceiptdate,
    productvendor.minorderqty,
    productvendor.maxorderqty,
    productvendor.onorderqty,
    productvendor.unitmeasurecode,
    productvendor.modifieddate
   FROM purchasing.productvendor;


ALTER TABLE pu.pv OWNER TO adventureworks_user;

--
-- Name: shipmethod; Type: TABLE; Schema: purchasing; Owner: adventureworks_user
--

CREATE TABLE purchasing.shipmethod (
    shipmethodid integer NOT NULL,
    name public."Name" NOT NULL,
    shipbase numeric DEFAULT 0.00 NOT NULL,
    shiprate numeric DEFAULT 0.00 NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ShipMethod_ShipBase" CHECK ((shipbase > 0.00)),
    CONSTRAINT "CK_ShipMethod_ShipRate" CHECK ((shiprate > 0.00))
);


ALTER TABLE purchasing.shipmethod OWNER TO adventureworks_user;

--
-- Name: TABLE shipmethod; Type: COMMENT; Schema: purchasing; Owner: adventureworks_user
--

COMMENT ON TABLE purchasing.shipmethod IS 'Shipping company lookup table.';


--
-- Name: COLUMN shipmethod.shipmethodid; Type: COMMENT; Schema: purchasing; Owner: adventureworks_user
--

COMMENT ON COLUMN purchasing.shipmethod.shipmethodid IS 'Primary key for ShipMethod records.';


--
-- Name: COLUMN shipmethod.name; Type: COMMENT; Schema: purchasing; Owner: adventureworks_user
--

COMMENT ON COLUMN purchasing.shipmethod.name IS 'Shipping company name.';


--
-- Name: COLUMN shipmethod.shipbase; Type: COMMENT; Schema: purchasing; Owner: adventureworks_user
--

COMMENT ON COLUMN purchasing.shipmethod.shipbase IS 'Minimum shipping charge.';


--
-- Name: COLUMN shipmethod.shiprate; Type: COMMENT; Schema: purchasing; Owner: adventureworks_user
--

COMMENT ON COLUMN purchasing.shipmethod.shiprate IS 'Shipping charge per pound.';


--
-- Name: sm; Type: VIEW; Schema: pu; Owner: adventureworks_user
--

CREATE VIEW pu.sm AS
 SELECT shipmethod.shipmethodid AS id,
    shipmethod.shipmethodid,
    shipmethod.name,
    shipmethod.shipbase,
    shipmethod.shiprate,
    shipmethod.rowguid,
    shipmethod.modifieddate
   FROM purchasing.shipmethod;


ALTER TABLE pu.sm OWNER TO adventureworks_user;

--
-- Name: vendor; Type: TABLE; Schema: purchasing; Owner: adventureworks_user
--

CREATE TABLE purchasing.vendor (
    businessentityid integer NOT NULL,
    accountnumber public."AccountNumber" NOT NULL,
    name public."Name" NOT NULL,
    creditrating smallint NOT NULL,
    preferredvendorstatus public."Flag" DEFAULT true NOT NULL,
    activeflag public."Flag" DEFAULT true NOT NULL,
    purchasingwebserviceurl character varying(1024),
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_Vendor_CreditRating" CHECK (((creditrating >= 1) AND (creditrating <= 5)))
);


ALTER TABLE purchasing.vendor OWNER TO adventureworks_user;

--
-- Name: TABLE vendor; Type: COMMENT; Schema: purchasing; Owner: adventureworks_user
--

COMMENT ON TABLE purchasing.vendor IS 'Companies from whom Adventure Works Cycles purchases parts or other goods.';


--
-- Name: COLUMN vendor.businessentityid; Type: COMMENT; Schema: purchasing; Owner: adventureworks_user
--

COMMENT ON COLUMN purchasing.vendor.businessentityid IS 'Primary key for Vendor records.  Foreign key to BusinessEntity.BusinessEntityID';


--
-- Name: COLUMN vendor.accountnumber; Type: COMMENT; Schema: purchasing; Owner: adventureworks_user
--

COMMENT ON COLUMN purchasing.vendor.accountnumber IS 'Vendor account (identification) number.';


--
-- Name: COLUMN vendor.name; Type: COMMENT; Schema: purchasing; Owner: adventureworks_user
--

COMMENT ON COLUMN purchasing.vendor.name IS 'Company name.';


--
-- Name: COLUMN vendor.creditrating; Type: COMMENT; Schema: purchasing; Owner: adventureworks_user
--

COMMENT ON COLUMN purchasing.vendor.creditrating IS '1 = Superior, 2 = Excellent, 3 = Above average, 4 = Average, 5 = Below average';


--
-- Name: COLUMN vendor.preferredvendorstatus; Type: COMMENT; Schema: purchasing; Owner: adventureworks_user
--

COMMENT ON COLUMN purchasing.vendor.preferredvendorstatus IS '0 = Do not use if another vendor is available. 1 = Preferred over other vendors supplying the same product.';


--
-- Name: COLUMN vendor.activeflag; Type: COMMENT; Schema: purchasing; Owner: adventureworks_user
--

COMMENT ON COLUMN purchasing.vendor.activeflag IS '0 = Vendor no longer used. 1 = Vendor is actively used.';


--
-- Name: COLUMN vendor.purchasingwebserviceurl; Type: COMMENT; Schema: purchasing; Owner: adventureworks_user
--

COMMENT ON COLUMN purchasing.vendor.purchasingwebserviceurl IS 'Vendor URL.';


--
-- Name: v; Type: VIEW; Schema: pu; Owner: adventureworks_user
--

CREATE VIEW pu.v AS
 SELECT vendor.businessentityid AS id,
    vendor.businessentityid,
    vendor.accountnumber,
    vendor.name,
    vendor.creditrating,
    vendor.preferredvendorstatus,
    vendor.activeflag,
    vendor.purchasingwebserviceurl,
    vendor.modifieddate
   FROM purchasing.vendor;


ALTER TABLE pu.v OWNER TO adventureworks_user;

--
-- Name: purchaseorderdetail_purchaseorderdetailid_seq; Type: SEQUENCE; Schema: purchasing; Owner: adventureworks_user
--

CREATE SEQUENCE purchasing.purchaseorderdetail_purchaseorderdetailid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE purchasing.purchaseorderdetail_purchaseorderdetailid_seq OWNER TO adventureworks_user;

--
-- Name: purchaseorderdetail_purchaseorderdetailid_seq; Type: SEQUENCE OWNED BY; Schema: purchasing; Owner: adventureworks_user
--

ALTER SEQUENCE purchasing.purchaseorderdetail_purchaseorderdetailid_seq OWNED BY purchasing.purchaseorderdetail.purchaseorderdetailid;


--
-- Name: purchaseorderheader_purchaseorderid_seq; Type: SEQUENCE; Schema: purchasing; Owner: adventureworks_user
--

CREATE SEQUENCE purchasing.purchaseorderheader_purchaseorderid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE purchasing.purchaseorderheader_purchaseorderid_seq OWNER TO adventureworks_user;

--
-- Name: purchaseorderheader_purchaseorderid_seq; Type: SEQUENCE OWNED BY; Schema: purchasing; Owner: adventureworks_user
--

ALTER SEQUENCE purchasing.purchaseorderheader_purchaseorderid_seq OWNED BY purchasing.purchaseorderheader.purchaseorderid;


--
-- Name: shipmethod_shipmethodid_seq; Type: SEQUENCE; Schema: purchasing; Owner: adventureworks_user
--

CREATE SEQUENCE purchasing.shipmethod_shipmethodid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE purchasing.shipmethod_shipmethodid_seq OWNER TO adventureworks_user;

--
-- Name: shipmethod_shipmethodid_seq; Type: SEQUENCE OWNED BY; Schema: purchasing; Owner: adventureworks_user
--

ALTER SEQUENCE purchasing.shipmethod_shipmethodid_seq OWNED BY purchasing.shipmethod.shipmethodid;


--
-- Name: vvendorwithaddresses; Type: VIEW; Schema: purchasing; Owner: adventureworks_user
--

CREATE VIEW purchasing.vvendorwithaddresses AS
 SELECT v.businessentityid,
    v.name,
    at.name AS addresstype,
    a.addressline1,
    a.addressline2,
    a.city,
    sp.name AS stateprovincename,
    a.postalcode,
    cr.name AS countryregionname
   FROM (((((purchasing.vendor v
     JOIN person.businessentityaddress bea ON ((bea.businessentityid = v.businessentityid)))
     JOIN person.address a ON ((a.addressid = bea.addressid)))
     JOIN person.stateprovince sp ON ((sp.stateprovinceid = a.stateprovinceid)))
     JOIN person.countryregion cr ON (((cr.countryregioncode)::text = (sp.countryregioncode)::text)))
     JOIN person.addresstype at ON ((at.addresstypeid = bea.addresstypeid)));


ALTER TABLE purchasing.vvendorwithaddresses OWNER TO adventureworks_user;

--
-- Name: vvendorwithcontacts; Type: VIEW; Schema: purchasing; Owner: adventureworks_user
--

CREATE VIEW purchasing.vvendorwithcontacts AS
 SELECT v.businessentityid,
    v.name,
    ct.name AS contacttype,
    p.title,
    p.firstname,
    p.middlename,
    p.lastname,
    p.suffix,
    pp.phonenumber,
    pnt.name AS phonenumbertype,
    ea.emailaddress,
    p.emailpromotion
   FROM ((((((purchasing.vendor v
     JOIN person.businessentitycontact bec ON ((bec.businessentityid = v.businessentityid)))
     JOIN person.contacttype ct ON ((ct.contacttypeid = bec.contacttypeid)))
     JOIN person.person p ON ((p.businessentityid = bec.personid)))
     LEFT JOIN person.emailaddress ea ON ((ea.businessentityid = p.businessentityid)))
     LEFT JOIN person.personphone pp ON ((pp.businessentityid = p.businessentityid)))
     LEFT JOIN person.phonenumbertype pnt ON ((pnt.phonenumbertypeid = pp.phonenumbertypeid)));


ALTER TABLE purchasing.vvendorwithcontacts OWNER TO adventureworks_user;

--
-- Name: customer; Type: TABLE; Schema: sales; Owner: adventureworks_user
--

CREATE TABLE sales.customer (
    customerid integer NOT NULL,
    personid integer,
    storeid integer,
    territoryid integer,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE sales.customer OWNER TO adventureworks_user;

--
-- Name: TABLE customer; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON TABLE sales.customer IS 'Current customer information. Also see the Person and Store tables.';


--
-- Name: COLUMN customer.customerid; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.customer.customerid IS 'Primary key.';


--
-- Name: COLUMN customer.personid; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.customer.personid IS 'Foreign key to Person.BusinessEntityID';


--
-- Name: COLUMN customer.storeid; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.customer.storeid IS 'Foreign key to Store.BusinessEntityID';


--
-- Name: COLUMN customer.territoryid; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.customer.territoryid IS 'ID of the territory in which the customer is located. Foreign key to SalesTerritory.SalesTerritoryID.';


--
-- Name: c; Type: VIEW; Schema: sa; Owner: adventureworks_user
--

CREATE VIEW sa.c AS
 SELECT customer.customerid AS id,
    customer.customerid,
    customer.personid,
    customer.storeid,
    customer.territoryid,
    customer.rowguid,
    customer.modifieddate
   FROM sales.customer;


ALTER TABLE sa.c OWNER TO adventureworks_user;

--
-- Name: creditcard; Type: TABLE; Schema: sales; Owner: adventureworks_user
--

CREATE TABLE sales.creditcard (
    creditcardid integer NOT NULL,
    cardtype character varying(50) NOT NULL,
    cardnumber character varying(25) NOT NULL,
    expmonth smallint NOT NULL,
    expyear smallint NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE sales.creditcard OWNER TO adventureworks_user;

--
-- Name: TABLE creditcard; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON TABLE sales.creditcard IS 'Customer credit card information.';


--
-- Name: COLUMN creditcard.creditcardid; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.creditcard.creditcardid IS 'Primary key for CreditCard records.';


--
-- Name: COLUMN creditcard.cardtype; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.creditcard.cardtype IS 'Credit card name.';


--
-- Name: COLUMN creditcard.cardnumber; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.creditcard.cardnumber IS 'Credit card number.';


--
-- Name: COLUMN creditcard.expmonth; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.creditcard.expmonth IS 'Credit card expiration month.';


--
-- Name: COLUMN creditcard.expyear; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.creditcard.expyear IS 'Credit card expiration year.';


--
-- Name: cc; Type: VIEW; Schema: sa; Owner: adventureworks_user
--

CREATE VIEW sa.cc AS
 SELECT creditcard.creditcardid AS id,
    creditcard.creditcardid,
    creditcard.cardtype,
    creditcard.cardnumber,
    creditcard.expmonth,
    creditcard.expyear,
    creditcard.modifieddate
   FROM sales.creditcard;


ALTER TABLE sa.cc OWNER TO adventureworks_user;

--
-- Name: currencyrate; Type: TABLE; Schema: sales; Owner: adventureworks_user
--

CREATE TABLE sales.currencyrate (
    currencyrateid integer NOT NULL,
    currencyratedate timestamp without time zone NOT NULL,
    fromcurrencycode character(3) NOT NULL,
    tocurrencycode character(3) NOT NULL,
    averagerate numeric NOT NULL,
    endofdayrate numeric NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE sales.currencyrate OWNER TO adventureworks_user;

--
-- Name: TABLE currencyrate; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON TABLE sales.currencyrate IS 'Currency exchange rates.';


--
-- Name: COLUMN currencyrate.currencyrateid; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.currencyrate.currencyrateid IS 'Primary key for CurrencyRate records.';


--
-- Name: COLUMN currencyrate.currencyratedate; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.currencyrate.currencyratedate IS 'Date and time the exchange rate was obtained.';


--
-- Name: COLUMN currencyrate.fromcurrencycode; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.currencyrate.fromcurrencycode IS 'Exchange rate was converted from this currency code.';


--
-- Name: COLUMN currencyrate.tocurrencycode; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.currencyrate.tocurrencycode IS 'Exchange rate was converted to this currency code.';


--
-- Name: COLUMN currencyrate.averagerate; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.currencyrate.averagerate IS 'Average exchange rate for the day.';


--
-- Name: COLUMN currencyrate.endofdayrate; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.currencyrate.endofdayrate IS 'Final exchange rate for the day.';


--
-- Name: cr; Type: VIEW; Schema: sa; Owner: adventureworks_user
--

CREATE VIEW sa.cr AS
 SELECT currencyrate.currencyrateid,
    currencyrate.currencyratedate,
    currencyrate.fromcurrencycode,
    currencyrate.tocurrencycode,
    currencyrate.averagerate,
    currencyrate.endofdayrate,
    currencyrate.modifieddate
   FROM sales.currencyrate;


ALTER TABLE sa.cr OWNER TO adventureworks_user;

--
-- Name: countryregioncurrency; Type: TABLE; Schema: sales; Owner: adventureworks_user
--

CREATE TABLE sales.countryregioncurrency (
    countryregioncode character varying(3) NOT NULL,
    currencycode character(3) NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE sales.countryregioncurrency OWNER TO adventureworks_user;

--
-- Name: TABLE countryregioncurrency; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON TABLE sales.countryregioncurrency IS 'Cross-reference table mapping ISO currency codes to a country or region.';


--
-- Name: COLUMN countryregioncurrency.countryregioncode; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.countryregioncurrency.countryregioncode IS 'ISO code for countries and regions. Foreign key to CountryRegion.CountryRegionCode.';


--
-- Name: COLUMN countryregioncurrency.currencycode; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.countryregioncurrency.currencycode IS 'ISO standard currency code. Foreign key to Currency.CurrencyCode.';


--
-- Name: crc; Type: VIEW; Schema: sa; Owner: adventureworks_user
--

CREATE VIEW sa.crc AS
 SELECT countryregioncurrency.countryregioncode,
    countryregioncurrency.currencycode,
    countryregioncurrency.modifieddate
   FROM sales.countryregioncurrency;


ALTER TABLE sa.crc OWNER TO adventureworks_user;

--
-- Name: currency; Type: TABLE; Schema: sales; Owner: adventureworks_user
--

CREATE TABLE sales.currency (
    currencycode character(3) NOT NULL,
    name public."Name" NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE sales.currency OWNER TO adventureworks_user;

--
-- Name: TABLE currency; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON TABLE sales.currency IS 'Lookup table containing standard ISO currencies.';


--
-- Name: COLUMN currency.currencycode; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.currency.currencycode IS 'The ISO code for the Currency.';


--
-- Name: COLUMN currency.name; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.currency.name IS 'Currency name.';


--
-- Name: cu; Type: VIEW; Schema: sa; Owner: adventureworks_user
--

CREATE VIEW sa.cu AS
 SELECT currency.currencycode AS id,
    currency.currencycode,
    currency.name,
    currency.modifieddate
   FROM sales.currency;


ALTER TABLE sa.cu OWNER TO adventureworks_user;

--
-- Name: personcreditcard; Type: TABLE; Schema: sales; Owner: adventureworks_user
--

CREATE TABLE sales.personcreditcard (
    businessentityid integer NOT NULL,
    creditcardid integer NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE sales.personcreditcard OWNER TO adventureworks_user;

--
-- Name: TABLE personcreditcard; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON TABLE sales.personcreditcard IS 'Cross-reference table mapping people to their credit card information in the CreditCard table.';


--
-- Name: COLUMN personcreditcard.businessentityid; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.personcreditcard.businessentityid IS 'Business entity identification number. Foreign key to Person.BusinessEntityID.';


--
-- Name: COLUMN personcreditcard.creditcardid; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.personcreditcard.creditcardid IS 'Credit card identification number. Foreign key to CreditCard.CreditCardID.';


--
-- Name: pcc; Type: VIEW; Schema: sa; Owner: adventureworks_user
--

CREATE VIEW sa.pcc AS
 SELECT personcreditcard.businessentityid AS id,
    personcreditcard.businessentityid,
    personcreditcard.creditcardid,
    personcreditcard.modifieddate
   FROM sales.personcreditcard;


ALTER TABLE sa.pcc OWNER TO adventureworks_user;

--
-- Name: store; Type: TABLE; Schema: sales; Owner: adventureworks_user
--

CREATE TABLE sales.store (
    businessentityid integer NOT NULL,
    name public."Name" NOT NULL,
    salespersonid integer,
    demographics xml,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE sales.store OWNER TO adventureworks_user;

--
-- Name: TABLE store; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON TABLE sales.store IS 'Customers (resellers) of Adventure Works products.';


--
-- Name: COLUMN store.businessentityid; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.store.businessentityid IS 'Primary key. Foreign key to Customer.BusinessEntityID.';


--
-- Name: COLUMN store.name; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.store.name IS 'Name of the store.';


--
-- Name: COLUMN store.salespersonid; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.store.salespersonid IS 'ID of the sales person assigned to the customer. Foreign key to SalesPerson.BusinessEntityID.';


--
-- Name: COLUMN store.demographics; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.store.demographics IS 'Demographic informationg about the store such as the number of employees, annual sales and store type.';


--
-- Name: s; Type: VIEW; Schema: sa; Owner: adventureworks_user
--

CREATE VIEW sa.s AS
 SELECT store.businessentityid AS id,
    store.businessentityid,
    store.name,
    store.salespersonid,
    store.demographics,
    store.rowguid,
    store.modifieddate
   FROM sales.store;


ALTER TABLE sa.s OWNER TO adventureworks_user;

--
-- Name: shoppingcartitem; Type: TABLE; Schema: sales; Owner: adventureworks_user
--

CREATE TABLE sales.shoppingcartitem (
    shoppingcartitemid integer NOT NULL,
    shoppingcartid character varying(50) NOT NULL,
    quantity integer DEFAULT 1 NOT NULL,
    productid integer NOT NULL,
    datecreated timestamp without time zone DEFAULT now() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ShoppingCartItem_Quantity" CHECK ((quantity >= 1))
);


ALTER TABLE sales.shoppingcartitem OWNER TO adventureworks_user;

--
-- Name: TABLE shoppingcartitem; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON TABLE sales.shoppingcartitem IS 'Contains online customer orders until the order is submitted or cancelled.';


--
-- Name: COLUMN shoppingcartitem.shoppingcartitemid; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.shoppingcartitem.shoppingcartitemid IS 'Primary key for ShoppingCartItem records.';


--
-- Name: COLUMN shoppingcartitem.shoppingcartid; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.shoppingcartitem.shoppingcartid IS 'Shopping cart identification number.';


--
-- Name: COLUMN shoppingcartitem.quantity; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.shoppingcartitem.quantity IS 'Product quantity ordered.';


--
-- Name: COLUMN shoppingcartitem.productid; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.shoppingcartitem.productid IS 'Product ordered. Foreign key to Product.ProductID.';


--
-- Name: COLUMN shoppingcartitem.datecreated; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.shoppingcartitem.datecreated IS 'Date the time the record was created.';


--
-- Name: sci; Type: VIEW; Schema: sa; Owner: adventureworks_user
--

CREATE VIEW sa.sci AS
 SELECT shoppingcartitem.shoppingcartitemid AS id,
    shoppingcartitem.shoppingcartitemid,
    shoppingcartitem.shoppingcartid,
    shoppingcartitem.quantity,
    shoppingcartitem.productid,
    shoppingcartitem.datecreated,
    shoppingcartitem.modifieddate
   FROM sales.shoppingcartitem;


ALTER TABLE sa.sci OWNER TO adventureworks_user;

--
-- Name: specialoffer; Type: TABLE; Schema: sales; Owner: adventureworks_user
--

CREATE TABLE sales.specialoffer (
    specialofferid integer NOT NULL,
    description character varying(255) NOT NULL,
    discountpct numeric DEFAULT 0.00 NOT NULL,
    type character varying(50) NOT NULL,
    category character varying(50) NOT NULL,
    startdate timestamp without time zone NOT NULL,
    enddate timestamp without time zone NOT NULL,
    minqty integer DEFAULT 0 NOT NULL,
    maxqty integer,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SpecialOffer_DiscountPct" CHECK ((discountpct >= 0.00)),
    CONSTRAINT "CK_SpecialOffer_EndDate" CHECK ((enddate >= startdate)),
    CONSTRAINT "CK_SpecialOffer_MaxQty" CHECK ((maxqty >= 0)),
    CONSTRAINT "CK_SpecialOffer_MinQty" CHECK ((minqty >= 0))
);


ALTER TABLE sales.specialoffer OWNER TO adventureworks_user;

--
-- Name: TABLE specialoffer; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON TABLE sales.specialoffer IS 'Sale discounts lookup table.';


--
-- Name: COLUMN specialoffer.specialofferid; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.specialoffer.specialofferid IS 'Primary key for SpecialOffer records.';


--
-- Name: COLUMN specialoffer.description; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.specialoffer.description IS 'Discount description.';


--
-- Name: COLUMN specialoffer.discountpct; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.specialoffer.discountpct IS 'Discount precentage.';


--
-- Name: COLUMN specialoffer.type; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.specialoffer.type IS 'Discount type category.';


--
-- Name: COLUMN specialoffer.category; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.specialoffer.category IS 'Group the discount applies to such as Reseller or Customer.';


--
-- Name: COLUMN specialoffer.startdate; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.specialoffer.startdate IS 'Discount start date.';


--
-- Name: COLUMN specialoffer.enddate; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.specialoffer.enddate IS 'Discount end date.';


--
-- Name: COLUMN specialoffer.minqty; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.specialoffer.minqty IS 'Minimum discount percent allowed.';


--
-- Name: COLUMN specialoffer.maxqty; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.specialoffer.maxqty IS 'Maximum discount percent allowed.';


--
-- Name: so; Type: VIEW; Schema: sa; Owner: adventureworks_user
--

CREATE VIEW sa.so AS
 SELECT specialoffer.specialofferid AS id,
    specialoffer.specialofferid,
    specialoffer.description,
    specialoffer.discountpct,
    specialoffer.type,
    specialoffer.category,
    specialoffer.startdate,
    specialoffer.enddate,
    specialoffer.minqty,
    specialoffer.maxqty,
    specialoffer.rowguid,
    specialoffer.modifieddate
   FROM sales.specialoffer;


ALTER TABLE sa.so OWNER TO adventureworks_user;

--
-- Name: salesorderdetail; Type: TABLE; Schema: sales; Owner: adventureworks_user
--

CREATE TABLE sales.salesorderdetail (
    salesorderid integer NOT NULL,
    salesorderdetailid integer NOT NULL,
    carriertrackingnumber character varying(25),
    orderqty smallint NOT NULL,
    productid integer NOT NULL,
    specialofferid integer NOT NULL,
    unitprice numeric NOT NULL,
    unitpricediscount numeric DEFAULT 0.0 NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesOrderDetail_OrderQty" CHECK ((orderqty > 0)),
    CONSTRAINT "CK_SalesOrderDetail_UnitPrice" CHECK ((unitprice >= 0.00)),
    CONSTRAINT "CK_SalesOrderDetail_UnitPriceDiscount" CHECK ((unitpricediscount >= 0.00))
);


ALTER TABLE sales.salesorderdetail OWNER TO adventureworks_user;

--
-- Name: TABLE salesorderdetail; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON TABLE sales.salesorderdetail IS 'Individual products associated with a specific sales order. See SalesOrderHeader.';


--
-- Name: COLUMN salesorderdetail.salesorderid; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesorderdetail.salesorderid IS 'Primary key. Foreign key to SalesOrderHeader.SalesOrderID.';


--
-- Name: COLUMN salesorderdetail.salesorderdetailid; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesorderdetail.salesorderdetailid IS 'Primary key. One incremental unique number per product sold.';


--
-- Name: COLUMN salesorderdetail.carriertrackingnumber; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesorderdetail.carriertrackingnumber IS 'Shipment tracking number supplied by the shipper.';


--
-- Name: COLUMN salesorderdetail.orderqty; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesorderdetail.orderqty IS 'Quantity ordered per product.';


--
-- Name: COLUMN salesorderdetail.productid; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesorderdetail.productid IS 'Product sold to customer. Foreign key to Product.ProductID.';


--
-- Name: COLUMN salesorderdetail.specialofferid; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesorderdetail.specialofferid IS 'Promotional code. Foreign key to SpecialOffer.SpecialOfferID.';


--
-- Name: COLUMN salesorderdetail.unitprice; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesorderdetail.unitprice IS 'Selling price of a single product.';


--
-- Name: COLUMN salesorderdetail.unitpricediscount; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesorderdetail.unitpricediscount IS 'Discount amount.';


--
-- Name: sod; Type: VIEW; Schema: sa; Owner: adventureworks_user
--

CREATE VIEW sa.sod AS
 SELECT salesorderdetail.salesorderdetailid AS id,
    salesorderdetail.salesorderid,
    salesorderdetail.salesorderdetailid,
    salesorderdetail.carriertrackingnumber,
    salesorderdetail.orderqty,
    salesorderdetail.productid,
    salesorderdetail.specialofferid,
    salesorderdetail.unitprice,
    salesorderdetail.unitpricediscount,
    salesorderdetail.rowguid,
    salesorderdetail.modifieddate
   FROM sales.salesorderdetail;


ALTER TABLE sa.sod OWNER TO adventureworks_user;

--
-- Name: salesorderheader; Type: TABLE; Schema: sales; Owner: adventureworks_user
--

CREATE TABLE sales.salesorderheader (
    salesorderid integer NOT NULL,
    revisionnumber smallint DEFAULT 0 NOT NULL,
    orderdate timestamp without time zone DEFAULT now() NOT NULL,
    duedate timestamp without time zone NOT NULL,
    shipdate timestamp without time zone,
    status smallint DEFAULT 1 NOT NULL,
    onlineorderflag public."Flag" DEFAULT true NOT NULL,
    purchaseordernumber public."OrderNumber",
    accountnumber public."AccountNumber",
    customerid integer NOT NULL,
    salespersonid integer,
    territoryid integer,
    billtoaddressid integer NOT NULL,
    shiptoaddressid integer NOT NULL,
    shipmethodid integer NOT NULL,
    creditcardid integer,
    creditcardapprovalcode character varying(15),
    currencyrateid integer,
    subtotal numeric DEFAULT 0.00 NOT NULL,
    taxamt numeric DEFAULT 0.00 NOT NULL,
    freight numeric DEFAULT 0.00 NOT NULL,
    totaldue numeric,
    comment character varying(128),
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesOrderHeader_DueDate" CHECK ((duedate >= orderdate)),
    CONSTRAINT "CK_SalesOrderHeader_Freight" CHECK ((freight >= 0.00)),
    CONSTRAINT "CK_SalesOrderHeader_ShipDate" CHECK (((shipdate >= orderdate) OR (shipdate IS NULL))),
    CONSTRAINT "CK_SalesOrderHeader_Status" CHECK (((status >= 0) AND (status <= 8))),
    CONSTRAINT "CK_SalesOrderHeader_SubTotal" CHECK ((subtotal >= 0.00)),
    CONSTRAINT "CK_SalesOrderHeader_TaxAmt" CHECK ((taxamt >= 0.00))
);


ALTER TABLE sales.salesorderheader OWNER TO adventureworks_user;

--
-- Name: TABLE salesorderheader; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON TABLE sales.salesorderheader IS 'General sales order information.';


--
-- Name: COLUMN salesorderheader.salesorderid; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesorderheader.salesorderid IS 'Primary key.';


--
-- Name: COLUMN salesorderheader.revisionnumber; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesorderheader.revisionnumber IS 'Incremental number to track changes to the sales order over time.';


--
-- Name: COLUMN salesorderheader.orderdate; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesorderheader.orderdate IS 'Dates the sales order was created.';


--
-- Name: COLUMN salesorderheader.duedate; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesorderheader.duedate IS 'Date the order is due to the customer.';


--
-- Name: COLUMN salesorderheader.shipdate; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesorderheader.shipdate IS 'Date the order was shipped to the customer.';


--
-- Name: COLUMN salesorderheader.status; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesorderheader.status IS 'Order current status. 1 = In process; 2 = Approved; 3 = Backordered; 4 = Rejected; 5 = Shipped; 6 = Cancelled';


--
-- Name: COLUMN salesorderheader.onlineorderflag; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesorderheader.onlineorderflag IS '0 = Order placed by sales person. 1 = Order placed online by customer.';


--
-- Name: COLUMN salesorderheader.purchaseordernumber; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesorderheader.purchaseordernumber IS 'Customer purchase order number reference.';


--
-- Name: COLUMN salesorderheader.accountnumber; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesorderheader.accountnumber IS 'Financial accounting number reference.';


--
-- Name: COLUMN salesorderheader.customerid; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesorderheader.customerid IS 'Customer identification number. Foreign key to Customer.BusinessEntityID.';


--
-- Name: COLUMN salesorderheader.salespersonid; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesorderheader.salespersonid IS 'Sales person who created the sales order. Foreign key to SalesPerson.BusinessEntityID.';


--
-- Name: COLUMN salesorderheader.territoryid; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesorderheader.territoryid IS 'Territory in which the sale was made. Foreign key to SalesTerritory.SalesTerritoryID.';


--
-- Name: COLUMN salesorderheader.billtoaddressid; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesorderheader.billtoaddressid IS 'Customer billing address. Foreign key to Address.AddressID.';


--
-- Name: COLUMN salesorderheader.shiptoaddressid; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesorderheader.shiptoaddressid IS 'Customer shipping address. Foreign key to Address.AddressID.';


--
-- Name: COLUMN salesorderheader.shipmethodid; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesorderheader.shipmethodid IS 'Shipping method. Foreign key to ShipMethod.ShipMethodID.';


--
-- Name: COLUMN salesorderheader.creditcardid; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesorderheader.creditcardid IS 'Credit card identification number. Foreign key to CreditCard.CreditCardID.';


--
-- Name: COLUMN salesorderheader.creditcardapprovalcode; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesorderheader.creditcardapprovalcode IS 'Approval code provided by the credit card company.';


--
-- Name: COLUMN salesorderheader.currencyrateid; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesorderheader.currencyrateid IS 'Currency exchange rate used. Foreign key to CurrencyRate.CurrencyRateID.';


--
-- Name: COLUMN salesorderheader.subtotal; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesorderheader.subtotal IS 'Sales subtotal. Computed as SUM(SalesOrderDetail.LineTotal)for the appropriate SalesOrderID.';


--
-- Name: COLUMN salesorderheader.taxamt; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesorderheader.taxamt IS 'Tax amount.';


--
-- Name: COLUMN salesorderheader.freight; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesorderheader.freight IS 'Shipping cost.';


--
-- Name: COLUMN salesorderheader.totaldue; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesorderheader.totaldue IS 'Total due from customer. Computed as Subtotal + TaxAmt + Freight.';


--
-- Name: COLUMN salesorderheader.comment; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesorderheader.comment IS 'Sales representative comments.';


--
-- Name: soh; Type: VIEW; Schema: sa; Owner: adventureworks_user
--

CREATE VIEW sa.soh AS
 SELECT salesorderheader.salesorderid AS id,
    salesorderheader.salesorderid,
    salesorderheader.revisionnumber,
    salesorderheader.orderdate,
    salesorderheader.duedate,
    salesorderheader.shipdate,
    salesorderheader.status,
    salesorderheader.onlineorderflag,
    salesorderheader.purchaseordernumber,
    salesorderheader.accountnumber,
    salesorderheader.customerid,
    salesorderheader.salespersonid,
    salesorderheader.territoryid,
    salesorderheader.billtoaddressid,
    salesorderheader.shiptoaddressid,
    salesorderheader.shipmethodid,
    salesorderheader.creditcardid,
    salesorderheader.creditcardapprovalcode,
    salesorderheader.currencyrateid,
    salesorderheader.subtotal,
    salesorderheader.taxamt,
    salesorderheader.freight,
    salesorderheader.totaldue,
    salesorderheader.comment,
    salesorderheader.rowguid,
    salesorderheader.modifieddate
   FROM sales.salesorderheader;


ALTER TABLE sa.soh OWNER TO adventureworks_user;

--
-- Name: salesorderheadersalesreason; Type: TABLE; Schema: sales; Owner: adventureworks_user
--

CREATE TABLE sales.salesorderheadersalesreason (
    salesorderid integer NOT NULL,
    salesreasonid integer NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE sales.salesorderheadersalesreason OWNER TO adventureworks_user;

--
-- Name: TABLE salesorderheadersalesreason; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON TABLE sales.salesorderheadersalesreason IS 'Cross-reference table mapping sales orders to sales reason codes.';


--
-- Name: COLUMN salesorderheadersalesreason.salesorderid; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesorderheadersalesreason.salesorderid IS 'Primary key. Foreign key to SalesOrderHeader.SalesOrderID.';


--
-- Name: COLUMN salesorderheadersalesreason.salesreasonid; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesorderheadersalesreason.salesreasonid IS 'Primary key. Foreign key to SalesReason.SalesReasonID.';


--
-- Name: sohsr; Type: VIEW; Schema: sa; Owner: adventureworks_user
--

CREATE VIEW sa.sohsr AS
 SELECT salesorderheadersalesreason.salesorderid,
    salesorderheadersalesreason.salesreasonid,
    salesorderheadersalesreason.modifieddate
   FROM sales.salesorderheadersalesreason;


ALTER TABLE sa.sohsr OWNER TO adventureworks_user;

--
-- Name: specialofferproduct; Type: TABLE; Schema: sales; Owner: adventureworks_user
--

CREATE TABLE sales.specialofferproduct (
    specialofferid integer NOT NULL,
    productid integer NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE sales.specialofferproduct OWNER TO adventureworks_user;

--
-- Name: TABLE specialofferproduct; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON TABLE sales.specialofferproduct IS 'Cross-reference table mapping products to special offer discounts.';


--
-- Name: COLUMN specialofferproduct.specialofferid; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.specialofferproduct.specialofferid IS 'Primary key for SpecialOfferProduct records.';


--
-- Name: COLUMN specialofferproduct.productid; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.specialofferproduct.productid IS 'Product identification number. Foreign key to Product.ProductID.';


--
-- Name: sop; Type: VIEW; Schema: sa; Owner: adventureworks_user
--

CREATE VIEW sa.sop AS
 SELECT specialofferproduct.specialofferid AS id,
    specialofferproduct.specialofferid,
    specialofferproduct.productid,
    specialofferproduct.rowguid,
    specialofferproduct.modifieddate
   FROM sales.specialofferproduct;


ALTER TABLE sa.sop OWNER TO adventureworks_user;

--
-- Name: salesperson; Type: TABLE; Schema: sales; Owner: adventureworks_user
--

CREATE TABLE sales.salesperson (
    businessentityid integer NOT NULL,
    territoryid integer,
    salesquota numeric,
    bonus numeric DEFAULT 0.00 NOT NULL,
    commissionpct numeric DEFAULT 0.00 NOT NULL,
    salesytd numeric DEFAULT 0.00 NOT NULL,
    saleslastyear numeric DEFAULT 0.00 NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesPerson_Bonus" CHECK ((bonus >= 0.00)),
    CONSTRAINT "CK_SalesPerson_CommissionPct" CHECK ((commissionpct >= 0.00)),
    CONSTRAINT "CK_SalesPerson_SalesLastYear" CHECK ((saleslastyear >= 0.00)),
    CONSTRAINT "CK_SalesPerson_SalesQuota" CHECK ((salesquota > 0.00)),
    CONSTRAINT "CK_SalesPerson_SalesYTD" CHECK ((salesytd >= 0.00))
);


ALTER TABLE sales.salesperson OWNER TO adventureworks_user;

--
-- Name: TABLE salesperson; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON TABLE sales.salesperson IS 'Sales representative current information.';


--
-- Name: COLUMN salesperson.businessentityid; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesperson.businessentityid IS 'Primary key for SalesPerson records. Foreign key to Employee.BusinessEntityID';


--
-- Name: COLUMN salesperson.territoryid; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesperson.territoryid IS 'Territory currently assigned to. Foreign key to SalesTerritory.SalesTerritoryID.';


--
-- Name: COLUMN salesperson.salesquota; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesperson.salesquota IS 'Projected yearly sales.';


--
-- Name: COLUMN salesperson.bonus; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesperson.bonus IS 'Bonus due if quota is met.';


--
-- Name: COLUMN salesperson.commissionpct; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesperson.commissionpct IS 'Commision percent received per sale.';


--
-- Name: COLUMN salesperson.salesytd; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesperson.salesytd IS 'Sales total year to date.';


--
-- Name: COLUMN salesperson.saleslastyear; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesperson.saleslastyear IS 'Sales total of previous year.';


--
-- Name: sp; Type: VIEW; Schema: sa; Owner: adventureworks_user
--

CREATE VIEW sa.sp AS
 SELECT salesperson.businessentityid AS id,
    salesperson.businessentityid,
    salesperson.territoryid,
    salesperson.salesquota,
    salesperson.bonus,
    salesperson.commissionpct,
    salesperson.salesytd,
    salesperson.saleslastyear,
    salesperson.rowguid,
    salesperson.modifieddate
   FROM sales.salesperson;


ALTER TABLE sa.sp OWNER TO adventureworks_user;

--
-- Name: salespersonquotahistory; Type: TABLE; Schema: sales; Owner: adventureworks_user
--

CREATE TABLE sales.salespersonquotahistory (
    businessentityid integer NOT NULL,
    quotadate timestamp without time zone NOT NULL,
    salesquota numeric NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesPersonQuotaHistory_SalesQuota" CHECK ((salesquota > 0.00))
);


ALTER TABLE sales.salespersonquotahistory OWNER TO adventureworks_user;

--
-- Name: TABLE salespersonquotahistory; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON TABLE sales.salespersonquotahistory IS 'Sales performance tracking.';


--
-- Name: COLUMN salespersonquotahistory.businessentityid; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salespersonquotahistory.businessentityid IS 'Sales person identification number. Foreign key to SalesPerson.BusinessEntityID.';


--
-- Name: COLUMN salespersonquotahistory.quotadate; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salespersonquotahistory.quotadate IS 'Sales quota date.';


--
-- Name: COLUMN salespersonquotahistory.salesquota; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salespersonquotahistory.salesquota IS 'Sales quota amount.';


--
-- Name: spqh; Type: VIEW; Schema: sa; Owner: adventureworks_user
--

CREATE VIEW sa.spqh AS
 SELECT salespersonquotahistory.businessentityid AS id,
    salespersonquotahistory.businessentityid,
    salespersonquotahistory.quotadate,
    salespersonquotahistory.salesquota,
    salespersonquotahistory.rowguid,
    salespersonquotahistory.modifieddate
   FROM sales.salespersonquotahistory;


ALTER TABLE sa.spqh OWNER TO adventureworks_user;

--
-- Name: salesreason; Type: TABLE; Schema: sales; Owner: adventureworks_user
--

CREATE TABLE sales.salesreason (
    salesreasonid integer NOT NULL,
    name public."Name" NOT NULL,
    reasontype public."Name" NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE sales.salesreason OWNER TO adventureworks_user;

--
-- Name: TABLE salesreason; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON TABLE sales.salesreason IS 'Lookup table of customer purchase reasons.';


--
-- Name: COLUMN salesreason.salesreasonid; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesreason.salesreasonid IS 'Primary key for SalesReason records.';


--
-- Name: COLUMN salesreason.name; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesreason.name IS 'Sales reason description.';


--
-- Name: COLUMN salesreason.reasontype; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesreason.reasontype IS 'Category the sales reason belongs to.';


--
-- Name: sr; Type: VIEW; Schema: sa; Owner: adventureworks_user
--

CREATE VIEW sa.sr AS
 SELECT salesreason.salesreasonid AS id,
    salesreason.salesreasonid,
    salesreason.name,
    salesreason.reasontype,
    salesreason.modifieddate
   FROM sales.salesreason;


ALTER TABLE sa.sr OWNER TO adventureworks_user;

--
-- Name: salesterritory; Type: TABLE; Schema: sales; Owner: adventureworks_user
--

CREATE TABLE sales.salesterritory (
    territoryid integer NOT NULL,
    name public."Name" NOT NULL,
    countryregioncode character varying(3) NOT NULL,
    "group" character varying(50) NOT NULL,
    salesytd numeric DEFAULT 0.00 NOT NULL,
    saleslastyear numeric DEFAULT 0.00 NOT NULL,
    costytd numeric DEFAULT 0.00 NOT NULL,
    costlastyear numeric DEFAULT 0.00 NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesTerritory_CostLastYear" CHECK ((costlastyear >= 0.00)),
    CONSTRAINT "CK_SalesTerritory_CostYTD" CHECK ((costytd >= 0.00)),
    CONSTRAINT "CK_SalesTerritory_SalesLastYear" CHECK ((saleslastyear >= 0.00)),
    CONSTRAINT "CK_SalesTerritory_SalesYTD" CHECK ((salesytd >= 0.00))
);


ALTER TABLE sales.salesterritory OWNER TO adventureworks_user;

--
-- Name: TABLE salesterritory; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON TABLE sales.salesterritory IS 'Sales territory lookup table.';


--
-- Name: COLUMN salesterritory.territoryid; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesterritory.territoryid IS 'Primary key for SalesTerritory records.';


--
-- Name: COLUMN salesterritory.name; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesterritory.name IS 'Sales territory description';


--
-- Name: COLUMN salesterritory.countryregioncode; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesterritory.countryregioncode IS 'ISO standard country or region code. Foreign key to CountryRegion.CountryRegionCode.';


--
-- Name: COLUMN salesterritory."group"; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesterritory."group" IS 'Geographic area to which the sales territory belong.';


--
-- Name: COLUMN salesterritory.salesytd; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesterritory.salesytd IS 'Sales in the territory year to date.';


--
-- Name: COLUMN salesterritory.saleslastyear; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesterritory.saleslastyear IS 'Sales in the territory the previous year.';


--
-- Name: COLUMN salesterritory.costytd; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesterritory.costytd IS 'Business costs in the territory year to date.';


--
-- Name: COLUMN salesterritory.costlastyear; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesterritory.costlastyear IS 'Business costs in the territory the previous year.';


--
-- Name: st; Type: VIEW; Schema: sa; Owner: adventureworks_user
--

CREATE VIEW sa.st AS
 SELECT salesterritory.territoryid AS id,
    salesterritory.territoryid,
    salesterritory.name,
    salesterritory.countryregioncode,
    salesterritory."group",
    salesterritory.salesytd,
    salesterritory.saleslastyear,
    salesterritory.costytd,
    salesterritory.costlastyear,
    salesterritory.rowguid,
    salesterritory.modifieddate
   FROM sales.salesterritory;


ALTER TABLE sa.st OWNER TO adventureworks_user;

--
-- Name: salesterritoryhistory; Type: TABLE; Schema: sales; Owner: adventureworks_user
--

CREATE TABLE sales.salesterritoryhistory (
    businessentityid integer NOT NULL,
    territoryid integer NOT NULL,
    startdate timestamp without time zone NOT NULL,
    enddate timestamp without time zone,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesTerritoryHistory_EndDate" CHECK (((enddate >= startdate) OR (enddate IS NULL)))
);


ALTER TABLE sales.salesterritoryhistory OWNER TO adventureworks_user;

--
-- Name: TABLE salesterritoryhistory; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON TABLE sales.salesterritoryhistory IS 'Sales representative transfers to other sales territories.';


--
-- Name: COLUMN salesterritoryhistory.businessentityid; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesterritoryhistory.businessentityid IS 'Primary key. The sales rep.  Foreign key to SalesPerson.BusinessEntityID.';


--
-- Name: COLUMN salesterritoryhistory.territoryid; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesterritoryhistory.territoryid IS 'Primary key. Territory identification number. Foreign key to SalesTerritory.SalesTerritoryID.';


--
-- Name: COLUMN salesterritoryhistory.startdate; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesterritoryhistory.startdate IS 'Primary key. Date the sales representive started work in the territory.';


--
-- Name: COLUMN salesterritoryhistory.enddate; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salesterritoryhistory.enddate IS 'Date the sales representative left work in the territory.';


--
-- Name: sth; Type: VIEW; Schema: sa; Owner: adventureworks_user
--

CREATE VIEW sa.sth AS
 SELECT salesterritoryhistory.territoryid AS id,
    salesterritoryhistory.businessentityid,
    salesterritoryhistory.territoryid,
    salesterritoryhistory.startdate,
    salesterritoryhistory.enddate,
    salesterritoryhistory.rowguid,
    salesterritoryhistory.modifieddate
   FROM sales.salesterritoryhistory;


ALTER TABLE sa.sth OWNER TO adventureworks_user;

--
-- Name: salestaxrate; Type: TABLE; Schema: sales; Owner: adventureworks_user
--

CREATE TABLE sales.salestaxrate (
    salestaxrateid integer NOT NULL,
    stateprovinceid integer NOT NULL,
    taxtype smallint NOT NULL,
    taxrate numeric DEFAULT 0.00 NOT NULL,
    name public."Name" NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesTaxRate_TaxType" CHECK (((taxtype >= 1) AND (taxtype <= 3)))
);


ALTER TABLE sales.salestaxrate OWNER TO adventureworks_user;

--
-- Name: TABLE salestaxrate; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON TABLE sales.salestaxrate IS 'Tax rate lookup table.';


--
-- Name: COLUMN salestaxrate.salestaxrateid; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salestaxrate.salestaxrateid IS 'Primary key for SalesTaxRate records.';


--
-- Name: COLUMN salestaxrate.stateprovinceid; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salestaxrate.stateprovinceid IS 'State, province, or country/region the sales tax applies to.';


--
-- Name: COLUMN salestaxrate.taxtype; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salestaxrate.taxtype IS '1 = Tax applied to retail transactions, 2 = Tax applied to wholesale transactions, 3 = Tax applied to all sales (retail and wholesale) transactions.';


--
-- Name: COLUMN salestaxrate.taxrate; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salestaxrate.taxrate IS 'Tax rate amount.';


--
-- Name: COLUMN salestaxrate.name; Type: COMMENT; Schema: sales; Owner: adventureworks_user
--

COMMENT ON COLUMN sales.salestaxrate.name IS 'Tax rate description.';


--
-- Name: tr; Type: VIEW; Schema: sa; Owner: adventureworks_user
--

CREATE VIEW sa.tr AS
 SELECT salestaxrate.salestaxrateid AS id,
    salestaxrate.salestaxrateid,
    salestaxrate.stateprovinceid,
    salestaxrate.taxtype,
    salestaxrate.taxrate,
    salestaxrate.name,
    salestaxrate.rowguid,
    salestaxrate.modifieddate
   FROM sales.salestaxrate;


ALTER TABLE sa.tr OWNER TO adventureworks_user;

--
-- Name: creditcard_creditcardid_seq; Type: SEQUENCE; Schema: sales; Owner: adventureworks_user
--

CREATE SEQUENCE sales.creditcard_creditcardid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sales.creditcard_creditcardid_seq OWNER TO adventureworks_user;

--
-- Name: creditcard_creditcardid_seq; Type: SEQUENCE OWNED BY; Schema: sales; Owner: adventureworks_user
--

ALTER SEQUENCE sales.creditcard_creditcardid_seq OWNED BY sales.creditcard.creditcardid;


--
-- Name: currencyrate_currencyrateid_seq; Type: SEQUENCE; Schema: sales; Owner: adventureworks_user
--

CREATE SEQUENCE sales.currencyrate_currencyrateid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sales.currencyrate_currencyrateid_seq OWNER TO adventureworks_user;

--
-- Name: currencyrate_currencyrateid_seq; Type: SEQUENCE OWNED BY; Schema: sales; Owner: adventureworks_user
--

ALTER SEQUENCE sales.currencyrate_currencyrateid_seq OWNED BY sales.currencyrate.currencyrateid;


--
-- Name: customer_customerid_seq; Type: SEQUENCE; Schema: sales; Owner: adventureworks_user
--

CREATE SEQUENCE sales.customer_customerid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sales.customer_customerid_seq OWNER TO adventureworks_user;

--
-- Name: customer_customerid_seq; Type: SEQUENCE OWNED BY; Schema: sales; Owner: adventureworks_user
--

ALTER SEQUENCE sales.customer_customerid_seq OWNED BY sales.customer.customerid;


--
-- Name: salesorderdetail_salesorderdetailid_seq; Type: SEQUENCE; Schema: sales; Owner: adventureworks_user
--

CREATE SEQUENCE sales.salesorderdetail_salesorderdetailid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sales.salesorderdetail_salesorderdetailid_seq OWNER TO adventureworks_user;

--
-- Name: salesorderdetail_salesorderdetailid_seq; Type: SEQUENCE OWNED BY; Schema: sales; Owner: adventureworks_user
--

ALTER SEQUENCE sales.salesorderdetail_salesorderdetailid_seq OWNED BY sales.salesorderdetail.salesorderdetailid;


--
-- Name: salesorderheader_salesorderid_seq; Type: SEQUENCE; Schema: sales; Owner: adventureworks_user
--

CREATE SEQUENCE sales.salesorderheader_salesorderid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sales.salesorderheader_salesorderid_seq OWNER TO adventureworks_user;

--
-- Name: salesorderheader_salesorderid_seq; Type: SEQUENCE OWNED BY; Schema: sales; Owner: adventureworks_user
--

ALTER SEQUENCE sales.salesorderheader_salesorderid_seq OWNED BY sales.salesorderheader.salesorderid;


--
-- Name: salesreason_salesreasonid_seq; Type: SEQUENCE; Schema: sales; Owner: adventureworks_user
--

CREATE SEQUENCE sales.salesreason_salesreasonid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sales.salesreason_salesreasonid_seq OWNER TO adventureworks_user;

--
-- Name: salesreason_salesreasonid_seq; Type: SEQUENCE OWNED BY; Schema: sales; Owner: adventureworks_user
--

ALTER SEQUENCE sales.salesreason_salesreasonid_seq OWNED BY sales.salesreason.salesreasonid;


--
-- Name: salestaxrate_salestaxrateid_seq; Type: SEQUENCE; Schema: sales; Owner: adventureworks_user
--

CREATE SEQUENCE sales.salestaxrate_salestaxrateid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sales.salestaxrate_salestaxrateid_seq OWNER TO adventureworks_user;

--
-- Name: salestaxrate_salestaxrateid_seq; Type: SEQUENCE OWNED BY; Schema: sales; Owner: adventureworks_user
--

ALTER SEQUENCE sales.salestaxrate_salestaxrateid_seq OWNED BY sales.salestaxrate.salestaxrateid;


--
-- Name: salesterritory_territoryid_seq; Type: SEQUENCE; Schema: sales; Owner: adventureworks_user
--

CREATE SEQUENCE sales.salesterritory_territoryid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sales.salesterritory_territoryid_seq OWNER TO adventureworks_user;

--
-- Name: salesterritory_territoryid_seq; Type: SEQUENCE OWNED BY; Schema: sales; Owner: adventureworks_user
--

ALTER SEQUENCE sales.salesterritory_territoryid_seq OWNED BY sales.salesterritory.territoryid;


--
-- Name: shoppingcartitem_shoppingcartitemid_seq; Type: SEQUENCE; Schema: sales; Owner: adventureworks_user
--

CREATE SEQUENCE sales.shoppingcartitem_shoppingcartitemid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sales.shoppingcartitem_shoppingcartitemid_seq OWNER TO adventureworks_user;

--
-- Name: shoppingcartitem_shoppingcartitemid_seq; Type: SEQUENCE OWNED BY; Schema: sales; Owner: adventureworks_user
--

ALTER SEQUENCE sales.shoppingcartitem_shoppingcartitemid_seq OWNED BY sales.shoppingcartitem.shoppingcartitemid;


--
-- Name: specialoffer_specialofferid_seq; Type: SEQUENCE; Schema: sales; Owner: adventureworks_user
--

CREATE SEQUENCE sales.specialoffer_specialofferid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sales.specialoffer_specialofferid_seq OWNER TO adventureworks_user;

--
-- Name: specialoffer_specialofferid_seq; Type: SEQUENCE OWNED BY; Schema: sales; Owner: adventureworks_user
--

ALTER SEQUENCE sales.specialoffer_specialofferid_seq OWNED BY sales.specialoffer.specialofferid;


--
-- Name: vindividualcustomer; Type: VIEW; Schema: sales; Owner: adventureworks_user
--

CREATE VIEW sales.vindividualcustomer AS
 SELECT p.businessentityid,
    p.title,
    p.firstname,
    p.middlename,
    p.lastname,
    p.suffix,
    pp.phonenumber,
    pnt.name AS phonenumbertype,
    ea.emailaddress,
    p.emailpromotion,
    at.name AS addresstype,
    a.addressline1,
    a.addressline2,
    a.city,
    sp.name AS stateprovincename,
    a.postalcode,
    cr.name AS countryregionname,
    p.demographics
   FROM (((((((((person.person p
     JOIN person.businessentityaddress bea ON ((bea.businessentityid = p.businessentityid)))
     JOIN person.address a ON ((a.addressid = bea.addressid)))
     JOIN person.stateprovince sp ON ((sp.stateprovinceid = a.stateprovinceid)))
     JOIN person.countryregion cr ON (((cr.countryregioncode)::text = (sp.countryregioncode)::text)))
     JOIN person.addresstype at ON ((at.addresstypeid = bea.addresstypeid)))
     JOIN sales.customer c ON ((c.personid = p.businessentityid)))
     LEFT JOIN person.emailaddress ea ON ((ea.businessentityid = p.businessentityid)))
     LEFT JOIN person.personphone pp ON ((pp.businessentityid = p.businessentityid)))
     LEFT JOIN person.phonenumbertype pnt ON ((pnt.phonenumbertypeid = pp.phonenumbertypeid)))
  WHERE (c.storeid IS NULL);


ALTER TABLE sales.vindividualcustomer OWNER TO adventureworks_user;

--
-- Name: vpersondemographics; Type: VIEW; Schema: sales; Owner: adventureworks_user
--

CREATE VIEW sales.vpersondemographics AS
 SELECT person.businessentityid,
    (((xpath('n:TotalPurchaseYTD/text()'::text, person.demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying)::money AS totalpurchaseytd,
    (((xpath('n:DateFirstPurchase/text()'::text, person.demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying)::date AS datefirstpurchase,
    (((xpath('n:BirthDate/text()'::text, person.demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying)::date AS birthdate,
    ((xpath('n:MaritalStatus/text()'::text, person.demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying(1) AS maritalstatus,
    ((xpath('n:YearlyIncome/text()'::text, person.demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying(30) AS yearlyincome,
    ((xpath('n:Gender/text()'::text, person.demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying(1) AS gender,
    (((xpath('n:TotalChildren/text()'::text, person.demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying)::integer AS totalchildren,
    (((xpath('n:NumberChildrenAtHome/text()'::text, person.demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying)::integer AS numberchildrenathome,
    ((xpath('n:Education/text()'::text, person.demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying(30) AS education,
    ((xpath('n:Occupation/text()'::text, person.demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying(30) AS occupation,
    (((xpath('n:HomeOwnerFlag/text()'::text, person.demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying)::boolean AS homeownerflag,
    (((xpath('n:NumberCarsOwned/text()'::text, person.demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying)::integer AS numbercarsowned
   FROM person.person
  WHERE (person.demographics IS NOT NULL);


ALTER TABLE sales.vpersondemographics OWNER TO adventureworks_user;

--
-- Name: vsalesperson; Type: VIEW; Schema: sales; Owner: adventureworks_user
--

CREATE VIEW sales.vsalesperson AS
 SELECT s.businessentityid,
    p.title,
    p.firstname,
    p.middlename,
    p.lastname,
    p.suffix,
    e.jobtitle,
    pp.phonenumber,
    pnt.name AS phonenumbertype,
    ea.emailaddress,
    p.emailpromotion,
    a.addressline1,
    a.addressline2,
    a.city,
    sp.name AS stateprovincename,
    a.postalcode,
    cr.name AS countryregionname,
    st.name AS territoryname,
    st."group" AS territorygroup,
    s.salesquota,
    s.salesytd,
    s.saleslastyear
   FROM ((((((((((sales.salesperson s
     JOIN humanresources.employee e ON ((e.businessentityid = s.businessentityid)))
     JOIN person.person p ON ((p.businessentityid = s.businessentityid)))
     JOIN person.businessentityaddress bea ON ((bea.businessentityid = s.businessentityid)))
     JOIN person.address a ON ((a.addressid = bea.addressid)))
     JOIN person.stateprovince sp ON ((sp.stateprovinceid = a.stateprovinceid)))
     JOIN person.countryregion cr ON (((cr.countryregioncode)::text = (sp.countryregioncode)::text)))
     LEFT JOIN sales.salesterritory st ON ((st.territoryid = s.territoryid)))
     LEFT JOIN person.emailaddress ea ON ((ea.businessentityid = p.businessentityid)))
     LEFT JOIN person.personphone pp ON ((pp.businessentityid = p.businessentityid)))
     LEFT JOIN person.phonenumbertype pnt ON ((pnt.phonenumbertypeid = pp.phonenumbertypeid)));


ALTER TABLE sales.vsalesperson OWNER TO adventureworks_user;

--
-- Name: vsalespersonsalesbyfiscalyears; Type: VIEW; Schema: sales; Owner: adventureworks_user
--

CREATE VIEW sales.vsalespersonsalesbyfiscalyears AS
 SELECT salestotal."SalesPersonID",
    salestotal."FullName",
    salestotal."JobTitle",
    salestotal."SalesTerritory",
    salestotal."2012",
    salestotal."2013",
    salestotal."2014"
   FROM public.crosstab('SELECT
    SalesPersonID
    ,FullName
    ,JobTitle
    ,SalesTerritory
    ,FiscalYear
    ,SalesTotal
FROM Sales.vSalesPersonSalesByFiscalYearsData
ORDER BY 2,4'::text, 'SELECT unnest(''{2012,2013,2014}''::text[])'::text) salestotal("SalesPersonID" integer, "FullName" text, "JobTitle" text, "SalesTerritory" text, "2012" numeric(12,4), "2013" numeric(12,4), "2014" numeric(12,4));


ALTER TABLE sales.vsalespersonsalesbyfiscalyears OWNER TO adventureworks_user;

--
-- Name: vsalespersonsalesbyfiscalyearsdata; Type: VIEW; Schema: sales; Owner: adventureworks_user
--

CREATE VIEW sales.vsalespersonsalesbyfiscalyearsdata AS
 SELECT granular.salespersonid,
    granular.fullname,
    granular.jobtitle,
    granular.salesterritory,
    sum(granular.subtotal) AS salestotal,
    granular.fiscalyear
   FROM ( SELECT soh.salespersonid,
            ((((p.firstname)::text || ' '::text) || COALESCE(((p.middlename)::text || ' '::text), ''::text)) || (p.lastname)::text) AS fullname,
            e.jobtitle,
            st.name AS salesterritory,
            soh.subtotal,
            date_part('year'::text, (soh.orderdate + '6 mons'::interval)) AS fiscalyear
           FROM ((((sales.salesperson sp
             JOIN sales.salesorderheader soh ON ((sp.businessentityid = soh.salespersonid)))
             JOIN sales.salesterritory st ON ((sp.territoryid = st.territoryid)))
             JOIN humanresources.employee e ON ((soh.salespersonid = e.businessentityid)))
             JOIN person.person p ON ((p.businessentityid = sp.businessentityid)))) granular
  GROUP BY granular.salespersonid, granular.fullname, granular.jobtitle, granular.salesterritory, granular.fiscalyear;


ALTER TABLE sales.vsalespersonsalesbyfiscalyearsdata OWNER TO adventureworks_user;

--
-- Name: vstorewithaddresses; Type: VIEW; Schema: sales; Owner: adventureworks_user
--

CREATE VIEW sales.vstorewithaddresses AS
 SELECT s.businessentityid,
    s.name,
    at.name AS addresstype,
    a.addressline1,
    a.addressline2,
    a.city,
    sp.name AS stateprovincename,
    a.postalcode,
    cr.name AS countryregionname
   FROM (((((sales.store s
     JOIN person.businessentityaddress bea ON ((bea.businessentityid = s.businessentityid)))
     JOIN person.address a ON ((a.addressid = bea.addressid)))
     JOIN person.stateprovince sp ON ((sp.stateprovinceid = a.stateprovinceid)))
     JOIN person.countryregion cr ON (((cr.countryregioncode)::text = (sp.countryregioncode)::text)))
     JOIN person.addresstype at ON ((at.addresstypeid = bea.addresstypeid)));


ALTER TABLE sales.vstorewithaddresses OWNER TO adventureworks_user;

--
-- Name: vstorewithcontacts; Type: VIEW; Schema: sales; Owner: adventureworks_user
--

CREATE VIEW sales.vstorewithcontacts AS
 SELECT s.businessentityid,
    s.name,
    ct.name AS contacttype,
    p.title,
    p.firstname,
    p.middlename,
    p.lastname,
    p.suffix,
    pp.phonenumber,
    pnt.name AS phonenumbertype,
    ea.emailaddress,
    p.emailpromotion
   FROM ((((((sales.store s
     JOIN person.businessentitycontact bec ON ((bec.businessentityid = s.businessentityid)))
     JOIN person.contacttype ct ON ((ct.contacttypeid = bec.contacttypeid)))
     JOIN person.person p ON ((p.businessentityid = bec.personid)))
     LEFT JOIN person.emailaddress ea ON ((ea.businessentityid = p.businessentityid)))
     LEFT JOIN person.personphone pp ON ((pp.businessentityid = p.businessentityid)))
     LEFT JOIN person.phonenumbertype pnt ON ((pnt.phonenumbertypeid = pp.phonenumbertypeid)));


ALTER TABLE sales.vstorewithcontacts OWNER TO adventureworks_user;

--
-- Name: vstorewithdemographics; Type: VIEW; Schema: sales; Owner: adventureworks_user
--

CREATE VIEW sales.vstorewithdemographics AS
 SELECT store.businessentityid,
    store.name,
    ((unnest(xpath('/ns:StoreSurvey/ns:AnnualSales/text()'::text, store.demographics, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey}}'::text[])))::character varying)::money AS "AnnualSales",
    ((unnest(xpath('/ns:StoreSurvey/ns:AnnualRevenue/text()'::text, store.demographics, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey}}'::text[])))::character varying)::money AS "AnnualRevenue",
    (unnest(xpath('/ns:StoreSurvey/ns:BankName/text()'::text, store.demographics, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey}}'::text[])))::character varying(50) AS "BankName",
    (unnest(xpath('/ns:StoreSurvey/ns:BusinessType/text()'::text, store.demographics, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey}}'::text[])))::character varying(5) AS "BusinessType",
    ((unnest(xpath('/ns:StoreSurvey/ns:YearOpened/text()'::text, store.demographics, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey}}'::text[])))::character varying)::integer AS "YearOpened",
    (unnest(xpath('/ns:StoreSurvey/ns:Specialty/text()'::text, store.demographics, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey}}'::text[])))::character varying(50) AS "Specialty",
    ((unnest(xpath('/ns:StoreSurvey/ns:SquareFeet/text()'::text, store.demographics, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey}}'::text[])))::character varying)::integer AS "SquareFeet",
    (unnest(xpath('/ns:StoreSurvey/ns:Brands/text()'::text, store.demographics, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey}}'::text[])))::character varying(30) AS "Brands",
    (unnest(xpath('/ns:StoreSurvey/ns:Internet/text()'::text, store.demographics, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey}}'::text[])))::character varying(30) AS "Internet",
    ((unnest(xpath('/ns:StoreSurvey/ns:NumberEmployees/text()'::text, store.demographics, '{{ns,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey}}'::text[])))::character varying)::integer AS "NumberEmployees"
   FROM sales.store;


ALTER TABLE sales.vstorewithdemographics OWNER TO adventureworks_user;

--
-- Name: department departmentid; Type: DEFAULT; Schema: humanresources; Owner: adventureworks_user
--

ALTER TABLE ONLY humanresources.department ALTER COLUMN departmentid SET DEFAULT nextval('humanresources.department_departmentid_seq'::regclass);


--
-- Name: jobcandidate jobcandidateid; Type: DEFAULT; Schema: humanresources; Owner: adventureworks_user
--

ALTER TABLE ONLY humanresources.jobcandidate ALTER COLUMN jobcandidateid SET DEFAULT nextval('humanresources.jobcandidate_jobcandidateid_seq'::regclass);


--
-- Name: shift shiftid; Type: DEFAULT; Schema: humanresources; Owner: adventureworks_user
--

ALTER TABLE ONLY humanresources.shift ALTER COLUMN shiftid SET DEFAULT nextval('humanresources.shift_shiftid_seq'::regclass);


--
-- Name: address addressid; Type: DEFAULT; Schema: person; Owner: adventureworks_user
--

ALTER TABLE ONLY person.address ALTER COLUMN addressid SET DEFAULT nextval('person.address_addressid_seq'::regclass);


--
-- Name: addresstype addresstypeid; Type: DEFAULT; Schema: person; Owner: adventureworks_user
--

ALTER TABLE ONLY person.addresstype ALTER COLUMN addresstypeid SET DEFAULT nextval('person.addresstype_addresstypeid_seq'::regclass);


--
-- Name: businessentity businessentityid; Type: DEFAULT; Schema: person; Owner: adventureworks_user
--

ALTER TABLE ONLY person.businessentity ALTER COLUMN businessentityid SET DEFAULT nextval('person.businessentity_businessentityid_seq'::regclass);


--
-- Name: contacttype contacttypeid; Type: DEFAULT; Schema: person; Owner: adventureworks_user
--

ALTER TABLE ONLY person.contacttype ALTER COLUMN contacttypeid SET DEFAULT nextval('person.contacttype_contacttypeid_seq'::regclass);


--
-- Name: emailaddress emailaddressid; Type: DEFAULT; Schema: person; Owner: adventureworks_user
--

ALTER TABLE ONLY person.emailaddress ALTER COLUMN emailaddressid SET DEFAULT nextval('person.emailaddress_emailaddressid_seq'::regclass);


--
-- Name: phonenumbertype phonenumbertypeid; Type: DEFAULT; Schema: person; Owner: adventureworks_user
--

ALTER TABLE ONLY person.phonenumbertype ALTER COLUMN phonenumbertypeid SET DEFAULT nextval('person.phonenumbertype_phonenumbertypeid_seq'::regclass);


--
-- Name: stateprovince stateprovinceid; Type: DEFAULT; Schema: person; Owner: adventureworks_user
--

ALTER TABLE ONLY person.stateprovince ALTER COLUMN stateprovinceid SET DEFAULT nextval('person.stateprovince_stateprovinceid_seq'::regclass);


--
-- Name: billofmaterials billofmaterialsid; Type: DEFAULT; Schema: production; Owner: adventureworks_user
--

ALTER TABLE ONLY production.billofmaterials ALTER COLUMN billofmaterialsid SET DEFAULT nextval('production.billofmaterials_billofmaterialsid_seq'::regclass);


--
-- Name: illustration illustrationid; Type: DEFAULT; Schema: production; Owner: adventureworks_user
--

ALTER TABLE ONLY production.illustration ALTER COLUMN illustrationid SET DEFAULT nextval('production.illustration_illustrationid_seq'::regclass);


--
-- Name: location locationid; Type: DEFAULT; Schema: production; Owner: adventureworks_user
--

ALTER TABLE ONLY production.location ALTER COLUMN locationid SET DEFAULT nextval('production.location_locationid_seq'::regclass);


--
-- Name: product productid; Type: DEFAULT; Schema: production; Owner: adventureworks_user
--

ALTER TABLE ONLY production.product ALTER COLUMN productid SET DEFAULT nextval('production.product_productid_seq'::regclass);


--
-- Name: productcategory productcategoryid; Type: DEFAULT; Schema: production; Owner: adventureworks_user
--

ALTER TABLE ONLY production.productcategory ALTER COLUMN productcategoryid SET DEFAULT nextval('production.productcategory_productcategoryid_seq'::regclass);


--
-- Name: productdescription productdescriptionid; Type: DEFAULT; Schema: production; Owner: adventureworks_user
--

ALTER TABLE ONLY production.productdescription ALTER COLUMN productdescriptionid SET DEFAULT nextval('production.productdescription_productdescriptionid_seq'::regclass);


--
-- Name: productmodel productmodelid; Type: DEFAULT; Schema: production; Owner: adventureworks_user
--

ALTER TABLE ONLY production.productmodel ALTER COLUMN productmodelid SET DEFAULT nextval('production.productmodel_productmodelid_seq'::regclass);


--
-- Name: productphoto productphotoid; Type: DEFAULT; Schema: production; Owner: adventureworks_user
--

ALTER TABLE ONLY production.productphoto ALTER COLUMN productphotoid SET DEFAULT nextval('production.productphoto_productphotoid_seq'::regclass);


--
-- Name: productreview productreviewid; Type: DEFAULT; Schema: production; Owner: adventureworks_user
--

ALTER TABLE ONLY production.productreview ALTER COLUMN productreviewid SET DEFAULT nextval('production.productreview_productreviewid_seq'::regclass);


--
-- Name: productsubcategory productsubcategoryid; Type: DEFAULT; Schema: production; Owner: adventureworks_user
--

ALTER TABLE ONLY production.productsubcategory ALTER COLUMN productsubcategoryid SET DEFAULT nextval('production.productsubcategory_productsubcategoryid_seq'::regclass);


--
-- Name: scrapreason scrapreasonid; Type: DEFAULT; Schema: production; Owner: adventureworks_user
--

ALTER TABLE ONLY production.scrapreason ALTER COLUMN scrapreasonid SET DEFAULT nextval('production.scrapreason_scrapreasonid_seq'::regclass);


--
-- Name: transactionhistory transactionid; Type: DEFAULT; Schema: production; Owner: adventureworks_user
--

ALTER TABLE ONLY production.transactionhistory ALTER COLUMN transactionid SET DEFAULT nextval('production.transactionhistory_transactionid_seq'::regclass);


--
-- Name: workorder workorderid; Type: DEFAULT; Schema: production; Owner: adventureworks_user
--

ALTER TABLE ONLY production.workorder ALTER COLUMN workorderid SET DEFAULT nextval('production.workorder_workorderid_seq'::regclass);


--
-- Name: purchaseorderdetail purchaseorderdetailid; Type: DEFAULT; Schema: purchasing; Owner: adventureworks_user
--

ALTER TABLE ONLY purchasing.purchaseorderdetail ALTER COLUMN purchaseorderdetailid SET DEFAULT nextval('purchasing.purchaseorderdetail_purchaseorderdetailid_seq'::regclass);


--
-- Name: purchaseorderheader purchaseorderid; Type: DEFAULT; Schema: purchasing; Owner: adventureworks_user
--

ALTER TABLE ONLY purchasing.purchaseorderheader ALTER COLUMN purchaseorderid SET DEFAULT nextval('purchasing.purchaseorderheader_purchaseorderid_seq'::regclass);


--
-- Name: shipmethod shipmethodid; Type: DEFAULT; Schema: purchasing; Owner: adventureworks_user
--

ALTER TABLE ONLY purchasing.shipmethod ALTER COLUMN shipmethodid SET DEFAULT nextval('purchasing.shipmethod_shipmethodid_seq'::regclass);


--
-- Name: creditcard creditcardid; Type: DEFAULT; Schema: sales; Owner: adventureworks_user
--

ALTER TABLE ONLY sales.creditcard ALTER COLUMN creditcardid SET DEFAULT nextval('sales.creditcard_creditcardid_seq'::regclass);


--
-- Name: currencyrate currencyrateid; Type: DEFAULT; Schema: sales; Owner: adventureworks_user
--

ALTER TABLE ONLY sales.currencyrate ALTER COLUMN currencyrateid SET DEFAULT nextval('sales.currencyrate_currencyrateid_seq'::regclass);


--
-- Name: customer customerid; Type: DEFAULT; Schema: sales; Owner: adventureworks_user
--

ALTER TABLE ONLY sales.customer ALTER COLUMN customerid SET DEFAULT nextval('sales.customer_customerid_seq'::regclass);


--
-- Name: salesorderdetail salesorderdetailid; Type: DEFAULT; Schema: sales; Owner: adventureworks_user
--

ALTER TABLE ONLY sales.salesorderdetail ALTER COLUMN salesorderdetailid SET DEFAULT nextval('sales.salesorderdetail_salesorderdetailid_seq'::regclass);


--
-- Name: salesorderheader salesorderid; Type: DEFAULT; Schema: sales; Owner: adventureworks_user
--

ALTER TABLE ONLY sales.salesorderheader ALTER COLUMN salesorderid SET DEFAULT nextval('sales.salesorderheader_salesorderid_seq'::regclass);


--
-- Name: salesreason salesreasonid; Type: DEFAULT; Schema: sales; Owner: adventureworks_user
--

ALTER TABLE ONLY sales.salesreason ALTER COLUMN salesreasonid SET DEFAULT nextval('sales.salesreason_salesreasonid_seq'::regclass);


--
-- Name: salestaxrate salestaxrateid; Type: DEFAULT; Schema: sales; Owner: adventureworks_user
--

ALTER TABLE ONLY sales.salestaxrate ALTER COLUMN salestaxrateid SET DEFAULT nextval('sales.salestaxrate_salestaxrateid_seq'::regclass);


--
-- Name: salesterritory territoryid; Type: DEFAULT; Schema: sales; Owner: adventureworks_user
--

ALTER TABLE ONLY sales.salesterritory ALTER COLUMN territoryid SET DEFAULT nextval('sales.salesterritory_territoryid_seq'::regclass);


--
-- Name: shoppingcartitem shoppingcartitemid; Type: DEFAULT; Schema: sales; Owner: adventureworks_user
--

ALTER TABLE ONLY sales.shoppingcartitem ALTER COLUMN shoppingcartitemid SET DEFAULT nextval('sales.shoppingcartitem_shoppingcartitemid_seq'::regclass);


--
-- Name: specialoffer specialofferid; Type: DEFAULT; Schema: sales; Owner: adventureworks_user
--

ALTER TABLE ONLY sales.specialoffer ALTER COLUMN specialofferid SET DEFAULT nextval('sales.specialoffer_specialofferid_seq'::regclass);


--
