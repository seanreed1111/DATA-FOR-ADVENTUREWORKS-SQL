
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

CREATE EXTENSION IF NOT EXISTS tablefunc WITH SCHEMA public;


CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;

CREATE DOMAIN public."AccountNumber" AS character varying(15);
CREATE DOMAIN public."Flag" AS boolean NOT NULL;
CREATE DOMAIN public."Name" AS character varying(50);
CREATE DOMAIN public."NameStyle" AS boolean NOT NULL;
CREATE DOMAIN public."OrderNumber" AS character varying(25);
CREATE DOMAIN public."Phone" AS character varying(25);SET default_tablespace = '';

CREATE TABLE department (
    departmentid integer NOT NULL,
    name public."Name" NOT NULL,
    groupname public."Name" NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


CREATE TABLE employee (
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


CREATE TABLE employeepayhistory (
    businessentityid integer NOT NULL,
    ratechangedate timestamp without time zone NOT NULL,
    rate numeric NOT NULL,
    payfrequency smallint NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_EmployeePayHistory_PayFrequency" CHECK ((payfrequency = ANY (ARRAY[1, 2]))),
    CONSTRAINT "CK_EmployeePayHistory_Rate" CHECK (((rate >= 6.50) AND (rate <= 200.00)))
);

CREATE TABLE jobcandidate (
    jobcandidateid integer NOT NULL,
    businessentityid integer,
    resume xml,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);

CREATE TABLE shift (
    shiftid integer NOT NULL,
    name public."Name" NOT NULL,
    starttime time without time zone NOT NULL,
    endtime time without time zone NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);



CREATE SEQUENCE department_departmentid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE department_departmentid_seq OWNED BY department.departmentid;

CREATE SEQUENCE jobcandidate_jobcandidateid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE jobcandidate_jobcandidateid_seq OWNED BY jobcandidate.jobcandidateid;

CREATE SEQUENCE shift_shiftid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE shift_shiftid_seq OWNED BY shift.shiftid;

CREATE TABLE address (
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

CREATE TABLE businessentityaddress (
    businessentityid integer NOT NULL,
    addressid integer NOT NULL,
    addresstypeid integer NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);

CREATE TABLE countryregion (
    countryregioncode character varying(3) NOT NULL,
    name public."Name" NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);

CREATE TABLE emailaddress (
    businessentityid integer NOT NULL,
    emailaddressid integer NOT NULL,
    emailaddress character varying(50),
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);

CREATE TABLE person (
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


CREATE TABLE personphone (
    businessentityid integer NOT NULL,
    phonenumber public."Phone" NOT NULL,
    phonenumbertypeid integer NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);

CREATE TABLE phonenumbertype (
    phonenumbertypeid integer NOT NULL,
    name public."Name" NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);

CREATE TABLE stateprovince (
    stateprovinceid integer NOT NULL,
    stateprovincecode character(3) NOT NULL,
    countryregioncode character varying(3) NOT NULL,
    isonlystateprovinceflag public."Flag" DEFAULT true NOT NULL,
    name public."Name" NOT NULL,
    territoryid integer NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);

 
CREATE TABLE addresstype (
    addresstypeid integer NOT NULL,
    name public."Name" NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


CREATE TABLE businessentity (
    businessentityid integer NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);




CREATE TABLE businessentitycontact (
    businessentityid integer NOT NULL,
    personid integer NOT NULL,
    contacttypeid integer NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);

CREATE TABLE contacttype (
    contacttypeid integer NOT NULL,
    name public."Name" NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


CREATE TABLE password (
    businessentityid integer NOT NULL,
    passwordhash character varying(128) NOT NULL,
    passwordsalt character varying(10) NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);CREATE VIEW pa AS
 SELECT password.businessentityid AS id,
    password.businessentityid,
    password.passwordhash,
    password.passwordsalt,
    password.rowguid,
    password.modifieddate
   FROM password;



CREATE VIEW pnt AS
 SELECT phonenumbertyphonenumbertypeid AS id,
    phonenumbertyphonenumbertypeid,
    phonenumbertyname,
    phonenumbertymodifieddate
   FROM phonenumbertype;



CREATE VIEW pp AS
 SELECT personphone.businessentityid AS id,
    personphone.businessentityid,
    personphone.phonenumber,
    personphone.phonenumbertypeid,
    personphone.modifieddate
   FROM personphone;



CREATE VIEW sp AS
 SELECT stateprovince.stateprovinceid AS id,
    stateprovince.stateprovinceid,
    stateprovince.stateprovincecode,
    stateprovince.countryregioncode,
    stateprovince.isonlystateprovinceflag,
    stateprovince.name,
    stateprovince.territoryid,
    stateprovince.rowguid,
    stateprovince.modifieddate
   FROM stateprovince;



CREATE SEQUENCE address_addressid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE address_addressid_seq OWNED BY address.addressid;

CREATE SEQUENCE addresstype_addresstypeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE addresstype_addresstypeid_seq OWNED BY addresstyaddresstypeid;

CREATE SEQUENCE businessentity_businessentityid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE businessentity_businessentityid_seq OWNED BY businessentity.businessentityid;

CREATE SEQUENCE contacttype_contacttypeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE contacttype_contacttypeid_seq OWNED BY contacttycontacttypeid;

CREATE SEQUENCE emailaddress_emailaddressid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE emailaddress_emailaddressid_seq OWNED BY emailaddress.emailaddressid;

CREATE SEQUENCE phonenumbertype_phonenumbertypeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE phonenumbertype_phonenumbertypeid_seq OWNED BY phonenumbertyphonenumbertypeid;

CREATE SEQUENCE stateprovince_stateprovinceid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE stateprovince_stateprovinceid_seq OWNED BY stateprovince.stateprovinceid;

CREATE VIEW vadditionalcontactinfo AS
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
   FROM (person p
     LEFT JOIN ( SELECT businessentityid,
            unnest(xpath('/ci:AdditionalContactInfo'::text, additionalcontactinfo, '{{ci,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo}}'::text[])) AS node
           FROM person
          WHERE (additionalcontactinfo IS NOT NULL)) additional ON ((p.businessentityid = additional.businessentityid)));



CREATE MATERIALIZED VIEW vstateprovincecountryregion AS
 SELECT sp.stateprovinceid,
    sp.stateprovincecode,
    sp.isonlystateprovinceflag,
    sp.name AS stateprovincename,
    sp.territoryid,
    cr.countryregioncode,
    cr.name AS countryregionname
   FROM (stateprovince sp
     JOIN countryregion cr ON (((sp.countryregioncode)::text = (cr.countryregioncode)::text)))
  WITH NO DATA;



CREATE TABLE billofmaterials (
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

CREATE VIEW bom AS
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
   FROM billofmaterials;



CREATE TABLE culture (
    cultureid character(6) NOT NULL,
    name public."Name" NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);CREATE VIEW c AS
 SELECT culture.cultureid AS id,
    culture.cultureid,
    culture.name,
    culture.modifieddate
   FROM culture;



CREATE TABLE document (
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
);CREATE VIEW d AS
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
   FROM document;



CREATE TABLE illustration (
    illustrationid integer NOT NULL,
    diagram xml,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);CREATE VIEW i AS
 SELECT illustration.illustrationid AS id,
    illustration.illustrationid,
    illustration.diagram,
    illustration.modifieddate
   FROM illustration;



CREATE TABLE location (
    locationid integer NOT NULL,
    name public."Name" NOT NULL,
    costrate numeric DEFAULT 0.00 NOT NULL,
    availability numeric(8,2) DEFAULT 0.00 NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_Location_Availability" CHECK ((availability >= 0.00)),
    CONSTRAINT "CK_Location_CostRate" CHECK ((costrate >= 0.00))
);



CREATE VIEW l AS
 SELECT location.locationid AS id,
    location.locationid,
    location.name,
    location.costrate,
    location.availability,
    location.modifieddate
   FROM location;



CREATE TABLE product (
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

CREATE VIEW p AS
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
   FROM product;



CREATE TABLE productcategory (
    productcategoryid integer NOT NULL,
    name public."Name" NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);CREATE VIEW pc AS
 SELECT productcategory.productcategoryid AS id,
    productcategory.productcategoryid,
    productcategory.name,
    productcategory.rowguid,
    productcategory.modifieddate
   FROM productcategory;



CREATE TABLE productcosthistory (
    productid integer NOT NULL,
    startdate timestamp without time zone NOT NULL,
    enddate timestamp without time zone,
    standardcost numeric NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ProductCostHistory_EndDate" CHECK (((enddate >= startdate) OR (enddate IS NULL))),
    CONSTRAINT "CK_ProductCostHistory_StandardCost" CHECK ((standardcost >= 0.00))
);



CREATE VIEW pch AS
 SELECT productcosthistory.productid AS id,
    productcosthistory.productid,
    productcosthistory.startdate,
    productcosthistory.enddate,
    productcosthistory.standardcost,
    productcosthistory.modifieddate
   FROM productcosthistory;



CREATE TABLE productdescription (
    productdescriptionid integer NOT NULL,
    description character varying(400) NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);CREATE VIEW pd AS
 SELECT productdescription.productdescriptionid AS id,
    productdescription.productdescriptionid,
    productdescription.description,
    productdescription.rowguid,
    productdescription.modifieddate
   FROM productdescription;



CREATE TABLE productdocument (
    productid integer NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    documentnode character varying DEFAULT '/'::character varying NOT NULL
);CREATE VIEW pdoc AS
 SELECT productdocument.productid AS id,
    productdocument.productid,
    productdocument.modifieddate,
    productdocument.documentnode
   FROM productdocument;



CREATE TABLE productinventory (
    productid integer NOT NULL,
    locationid smallint NOT NULL,
    shelf character varying(10) NOT NULL,
    bin smallint NOT NULL,
    quantity smallint DEFAULT 0 NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ProductInventory_Bin" CHECK (((bin >= 0) AND (bin <= 100)))
);
CREATE VIEW pi AS
 SELECT productinventory.productid AS id,
    productinventory.productid,
    productinventory.locationid,
    productinventory.shelf,
    productinventory.bin,
    productinventory.quantity,
    productinventory.rowguid,
    productinventory.modifieddate
   FROM productinventory;



CREATE TABLE productlistpricehistory (
    productid integer NOT NULL,
    startdate timestamp without time zone NOT NULL,
    enddate timestamp without time zone,
    listprice numeric NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ProductListPriceHistory_EndDate" CHECK (((enddate >= startdate) OR (enddate IS NULL))),
    CONSTRAINT "CK_ProductListPriceHistory_ListPrice" CHECK ((listprice > 0.00))
);



CREATE VIEW plph AS
 SELECT productlistpricehistory.productid AS id,
    productlistpricehistory.productid,
    productlistpricehistory.startdate,
    productlistpricehistory.enddate,
    productlistpricehistory.listprice,
    productlistpricehistory.modifieddate
   FROM productlistpricehistory;



CREATE TABLE productmodel (
    productmodelid integer NOT NULL,
    name public."Name" NOT NULL,
    catalogdescription xml,
    instructions xml,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);



CREATE VIEW pm AS
 SELECT productmodel.productmodelid AS id,
    productmodel.productmodelid,
    productmodel.name,
    productmodel.catalogdescription,
    productmodel.instructions,
    productmodel.rowguid,
    productmodel.modifieddate
   FROM productmodel;



CREATE TABLE productmodelillustration (
    productmodelid integer NOT NULL,
    illustrationid integer NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);CREATE VIEW pmi AS
 SELECT productmodelillustration.productmodelid,
    productmodelillustration.illustrationid,
    productmodelillustration.modifieddate
   FROM productmodelillustration;



CREATE TABLE productmodelproductdescriptionculture (
    productmodelid integer NOT NULL,
    productdescriptionid integer NOT NULL,
    cultureid character(6) NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);

CREATE VIEW pmpdc AS
 SELECT productmodelproductdescriptionculture.productmodelid,
    productmodelproductdescriptionculture.productdescriptionid,
    productmodelproductdescriptionculture.cultureid,
    productmodelproductdescriptionculture.modifieddate
   FROM productmodelproductdescriptionculture;



CREATE TABLE productphoto (
    productphotoid integer NOT NULL,
    thumbnailphoto bytea,
    thumbnailphotofilename character varying(50),
    largephoto bytea,
    largephotofilename character varying(50),
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);
CREATE VIEW pp AS
 SELECT productphoto.productphotoid AS id,
    productphoto.productphotoid,
    productphoto.thumbnailphoto,
    productphoto.thumbnailphotofilename,
    productphoto.largephoto,
    productphoto.largephotofilename,
    productphoto.modifieddate
   FROM productphoto;



CREATE TABLE productproductphoto (
    productid integer NOT NULL,
    productphotoid integer NOT NULL,
    "primary" public."Flag" DEFAULT false NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);

CREATE VIEW ppp AS
 SELECT productproductphoto.productid,
    productproductphoto.productphotoid,
    productproductphoto."primary",
    productproductphoto.modifieddate
   FROM productproductphoto;



CREATE TABLE productreview (
    productreviewid integer NOT NULL,
    productid integer NOT NULL,
    reviewername public."Name" NOT NULL,
    reviewdate timestamp without time zone DEFAULT now() NOT NULL,
    emailaddress character varying(50) NOT NULL,
    rating integer NOT NULL,
    
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ProductReview_Rating" CHECK (((rating >= 1) AND (rating <= 5)))
);CREATE VIEW pr AS
 SELECT productreview.productreviewid AS id,
    productreview.productreviewid,
    productreview.productid,
    productreview.reviewername,
    productreview.reviewdate,
    productreview.emailaddress,
    productreview.rating,
    productreview.
    productreview.modifieddate
   FROM productreview;



CREATE TABLE productsubcategory (
    productsubcategoryid integer NOT NULL,
    productcategoryid integer NOT NULL,
    name public."Name" NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);

CREATE VIEW psc AS
 SELECT productsubcategory.productsubcategoryid AS id,
    productsubcategory.productsubcategoryid,
    productsubcategory.productcategoryid,
    productsubcategory.name,
    productsubcategory.rowguid,
    productsubcategory.modifieddate
   FROM productsubcategory;



CREATE TABLE scrapreason (
    scrapreasonid integer NOT NULL,
    name public."Name" NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);CREATE VIEW sr AS
 SELECT scrapreason.scrapreasonid AS id,
    scrapreason.scrapreasonid,
    scrapreason.name,
    scrapreason.modifieddate
   FROM scrapreason;



CREATE TABLE transactionhistory (
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

CREATE VIEW th AS
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
   FROM transactionhistory;



CREATE TABLE transactionhistoryarchive (
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

CREATE VIEW tha AS
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
   FROM transactionhistoryarchive;



CREATE TABLE unitmeasure (
    unitmeasurecode character(3) NOT NULL,
    name public."Name" NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);CREATE VIEW um AS
 SELECT unitmeasure.unitmeasurecode AS id,
    unitmeasure.unitmeasurecode,
    unitmeasure.name,
    unitmeasure.modifieddate
   FROM unitmeasure;



CREATE TABLE workorder (
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

CREATE VIEW w AS
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
   FROM workorder;



CREATE TABLE workorderrouting (
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


CREATE VIEW wr AS
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
   FROM workorderrouting;



CREATE SEQUENCE billofmaterials_billofmaterialsid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE billofmaterials_billofmaterialsid_seq OWNED BY billofmaterials.billofmaterialsid;

CREATE SEQUENCE illustration_illustrationid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE illustration_illustrationid_seq OWNED BY illustration.illustrationid;

CREATE SEQUENCE location_locationid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE location_locationid_seq OWNED BY location.locationid;

CREATE SEQUENCE product_productid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE product_productid_seq OWNED BY product.productid;

CREATE SEQUENCE productcategory_productcategoryid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE productcategory_productcategoryid_seq OWNED BY productcategory.productcategoryid;

CREATE SEQUENCE productdescription_productdescriptionid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE productdescription_productdescriptionid_seq OWNED BY productdescription.productdescriptionid;

CREATE SEQUENCE productmodel_productmodelid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE productmodel_productmodelid_seq OWNED BY productmodel.productmodelid;

CREATE SEQUENCE productphoto_productphotoid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE productphoto_productphotoid_seq OWNED BY productphoto.productphotoid;

CREATE SEQUENCE productreview_productreviewid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE productreview_productreviewid_seq OWNED BY productreview.productreviewid;

CREATE SEQUENCE productsubcategory_productsubcategoryid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE productsubcategory_productsubcategoryid_seq OWNED BY productsubcategory.productsubcategoryid;

CREATE SEQUENCE scrapreason_scrapreasonid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE scrapreason_scrapreasonid_seq OWNED BY scrapreason.scrapreasonid;

CREATE SEQUENCE transactionhistory_transactionid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE transactionhistory_transactionid_seq OWNED BY transactionhistory.transactionid;

CREATE MATERIALIZED VIEW vproductanddescription AS
 SELECT p.productid,
    p.name,
    pm.name AS productmodel,
    pmx.cultureid,
    pd.description
   FROM (((product p
     JOIN productmodel pm ON ((p.productmodelid = pm.productmodelid)))
     JOIN productmodelproductdescriptionculture pmx ON ((pm.productmodelid = pmx.productmodelid)))
     JOIN productdescription pd ON ((pmx.productdescriptionid = pd.productdescriptionid)))
  WITH NO DATA;



CREATE VIEW vproductmodelcatalogdescription AS
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
   FROM productmodel
  WHERE (productmodel.catalogdescription IS NOT NULL);



CREATE VIEW vproductmodelinstructions AS
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
                   FROM productmodel) locations) pm;



CREATE SEQUENCE workorder_workorderid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE workorder_workorderid_seq OWNED BY workorder.workorderid;

CREATE TABLE purchaseorderdetail (
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

CREATE VIEW pod AS
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
   FROM purchaseorderdetail;



CREATE TABLE purchaseorderheader (
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


CREATE VIEW poh AS
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
   FROM purchaseorderheader;



CREATE TABLE productvendor (
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
CREATE VIEW pv AS
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
   FROM productvendor;



CREATE TABLE shipmethod (
    shipmethodid integer NOT NULL,
    name public."Name" NOT NULL,
    shipbase numeric DEFAULT 0.00 NOT NULL,
    shiprate numeric DEFAULT 0.00 NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ShipMethod_ShipBase" CHECK ((shipbase > 0.00)),
    CONSTRAINT "CK_ShipMethod_ShipRate" CHECK ((shiprate > 0.00))
);



CREATE VIEW sm AS
 SELECT shipmethod.shipmethodid AS id,
    shipmethod.shipmethodid,
    shipmethod.name,
    shipmethod.shipbase,
    shipmethod.shiprate,
    shipmethod.rowguid,
    shipmethod.modifieddate
   FROM shipmethod;



CREATE TABLE vendor (
    businessentityid integer NOT NULL,
    accountnumber public."AccountNumber" NOT NULL,
    name public."Name" NOT NULL,
    creditrating smallint NOT NULL,
    preferredvendorstatus public."Flag" DEFAULT true NOT NULL,
    activeflag public."Flag" DEFAULT true NOT NULL,
    purchasingwebserviceurl character varying(1024),
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_Vendor_CreditRating" CHECK (((creditrating >= 1) AND (creditrating <= 5)))
);CREATE VIEW v AS
 SELECT vendor.businessentityid AS id,
    vendor.businessentityid,
    vendor.accountnumber,
    vendor.name,
    vendor.creditrating,
    vendor.preferredvendorstatus,
    vendor.activeflag,
    vendor.purchasingwebserviceurl,
    vendor.modifieddate
   FROM vendor;



CREATE SEQUENCE purchaseorderdetail_purchaseorderdetailid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE purchaseorderdetail_purchaseorderdetailid_seq OWNED BY purchaseorderdetail.purchaseorderdetailid;

CREATE SEQUENCE purchaseorderheader_purchaseorderid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE purchaseorderheader_purchaseorderid_seq OWNED BY purchaseorderheader.purchaseorderid;

CREATE SEQUENCE shipmethod_shipmethodid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE shipmethod_shipmethodid_seq OWNED BY shipmethod.shipmethodid;

CREATE VIEW vvendorwithaddresses AS
 SELECT v.businessentityid,
    v.name,
    at.name AS addresstype,
    a.addressline1,
    a.addressline2,
    a.city,
    sp.name AS stateprovincename,
    a.postalcode,
    cr.name AS countryregionname
   FROM (((((vendor v
     JOIN businessentityaddress bea ON ((bea.businessentityid = v.businessentityid)))
     JOIN address a ON ((a.addressid = bea.addressid)))
     JOIN stateprovince sp ON ((sp.stateprovinceid = a.stateprovinceid)))
     JOIN countryregion cr ON (((cr.countryregioncode)::text = (sp.countryregioncode)::text)))
     JOIN addresstype at ON ((at.addresstypeid = bea.addresstypeid)));



CREATE VIEW vvendorwithcontacts AS
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
   FROM ((((((vendor v
     JOIN businessentitycontact bec ON ((bec.businessentityid = v.businessentityid)))
     JOIN contacttype ct ON ((ct.contacttypeid = bec.contacttypeid)))
     JOIN person p ON ((p.businessentityid = bec.personid)))
     LEFT JOIN emailaddress ea ON ((ea.businessentityid = p.businessentityid)))
     LEFT JOIN personphone pp ON ((pp.businessentityid = p.businessentityid)))
     LEFT JOIN phonenumbertype pnt ON ((pnt.phonenumbertypeid = pp.phonenumbertypeid)));



CREATE TABLE customer (
    customerid integer NOT NULL,
    personid integer,
    storeid integer,
    territoryid integer,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);



CREATE VIEW c AS
 SELECT customer.customerid AS id,
    customer.customerid,
    customer.personid,
    customer.storeid,
    customer.territoryid,
    customer.rowguid,
    customer.modifieddate
   FROM customer;



CREATE TABLE creditcard (
    creditcardid integer NOT NULL,
    cardtype character varying(50) NOT NULL,
    cardnumber character varying(25) NOT NULL,
    expmonth smallint NOT NULL,
    expyear smallint NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);
CREATE VIEW cc AS
 SELECT creditcard.creditcardid AS id,
    creditcard.creditcardid,
    creditcard.cardtype,
    creditcard.cardnumber,
    creditcard.expmonth,
    creditcard.expyear,
    creditcard.modifieddate
   FROM creditcard;



CREATE TABLE currencyrate (
    currencyrateid integer NOT NULL,
    currencyratedate timestamp without time zone NOT NULL,
    fromcurrencycode character(3) NOT NULL,
    tocurrencycode character(3) NOT NULL,
    averagerate numeric NOT NULL,
    endofdayrate numeric NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);


CREATE VIEW cr AS
 SELECT currencyrate.currencyrateid,
    currencyrate.currencyratedate,
    currencyrate.fromcurrencycode,
    currencyrate.tocurrencycode,
    currencyrate.averagerate,
    currencyrate.endofdayrate,
    currencyrate.modifieddate
   FROM currencyrate;



CREATE TABLE countryregioncurrency (
    countryregioncode character varying(3) NOT NULL,
    currencycode character(3) NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);CREATE VIEW crc AS
 SELECT countryregioncurrency.countryregioncode,
    countryregioncurrency.currencycode,
    countryregioncurrency.modifieddate
   FROM countryregioncurrency;



CREATE TABLE currency (
    currencycode character(3) NOT NULL,
    name public."Name" NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);CREATE VIEW cu AS
 SELECT currency.currencycode AS id,
    currency.currencycode,
    currency.name,
    currency.modifieddate
   FROM currency;



CREATE TABLE personcreditcard (
    businessentityid integer NOT NULL,
    creditcardid integer NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);CREATE VIEW pcc AS
 SELECT personcreditcard.businessentityid AS id,
    personcreditcard.businessentityid,
    personcreditcard.creditcardid,
    personcreditcard.modifieddate
   FROM personcreditcard;



CREATE TABLE store (
    businessentityid integer NOT NULL,
    name public."Name" NOT NULL,
    salespersonid integer,
    demographics xml,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);



CREATE VIEW s AS
 SELECT store.businessentityid AS id,
    store.businessentityid,
    store.name,
    store.salespersonid,
    store.demographics,
    store.rowguid,
    store.modifieddate
   FROM store;



CREATE TABLE shoppingcartitem (
    shoppingcartitemid integer NOT NULL,
    shoppingcartid character varying(50) NOT NULL,
    quantity integer DEFAULT 1 NOT NULL,
    productid integer NOT NULL,
    datecreated timestamp without time zone DEFAULT now() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_ShoppingCartItem_Quantity" CHECK ((quantity >= 1))
);
CREATE VIEW sci AS
 SELECT shoppingcartitem.shoppingcartitemid AS id,
    shoppingcartitem.shoppingcartitemid,
    shoppingcartitem.shoppingcartid,
    shoppingcartitem.quantity,
    shoppingcartitem.productid,
    shoppingcartitem.datecreated,
    shoppingcartitem.modifieddate
   FROM shoppingcartitem;



CREATE TABLE specialoffer (
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



CREATE VIEW so AS
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
   FROM specialoffer;



CREATE TABLE salesorderdetail (
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

CREATE VIEW sod AS
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
   FROM salesorderdetail;



CREATE TABLE salesorderheader (
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
    
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesOrderHeader_DueDate" CHECK ((duedate >= orderdate)),
    CONSTRAINT "CK_SalesOrderHeader_Freight" CHECK ((freight >= 0.00)),
    CONSTRAINT "CK_SalesOrderHeader_ShipDate" CHECK (((shipdate >= orderdate) OR (shipdate IS NULL))),
    CONSTRAINT "CK_SalesOrderHeader_Status" CHECK (((status >= 0) AND (status <= 8))),
    CONSTRAINT "CK_SalesOrderHeader_SubTotal" CHECK ((subtotal >= 0.00)),
    CONSTRAINT "CK_SalesOrderHeader_TaxAmt" CHECK ((taxamt >= 0.00))
);

CREATE VIEW soh AS
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
    salesorderheader.
    salesorderheader.rowguid,
    salesorderheader.modifieddate
   FROM salesorderheader;



CREATE TABLE salesorderheadersalesreason (
    salesorderid integer NOT NULL,
    salesreasonid integer NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);CREATE VIEW sohsr AS
 SELECT salesorderheadersalesreason.salesorderid,
    salesorderheadersalesreason.salesreasonid,
    salesorderheadersalesreason.modifieddate
   FROM salesorderheadersalesreason;



CREATE TABLE specialofferproduct (
    specialofferid integer NOT NULL,
    productid integer NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);CREATE VIEW sop AS
 SELECT specialofferproduct.specialofferid AS id,
    specialofferproduct.specialofferid,
    specialofferproduct.productid,
    specialofferproduct.rowguid,
    specialofferproduct.modifieddate
   FROM specialofferproduct;



CREATE TABLE salesperson (
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
);CREATE VIEW sp AS
 SELECT salesbusinessentityid AS id,
    salesbusinessentityid,
    salesterritoryid,
    salessalesquota,
    salesbonus,
    salescommissionpct,
    salessalesytd,
    salessaleslastyear,
    salesrowguid,
    salesmodifieddate
   FROM salesperson;



CREATE TABLE salespersonquotahistory (
    businessentityid integer NOT NULL,
    quotadate timestamp without time zone NOT NULL,
    salesquota numeric NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesPersonQuotaHistory_SalesQuota" CHECK ((salesquota > 0.00))
);

CREATE VIEW spqh AS
 SELECT salespersonquotahistory.businessentityid AS id,
    salespersonquotahistory.businessentityid,
    salespersonquotahistory.quotadate,
    salespersonquotahistory.salesquota,
    salespersonquotahistory.rowguid,
    salespersonquotahistory.modifieddate
   FROM salespersonquotahistory;



CREATE TABLE salesreason (
    salesreasonid integer NOT NULL,
    name public."Name" NOT NULL,
    reasontype public."Name" NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL
);

CREATE VIEW sr AS
 SELECT salesreason.salesreasonid AS id,
    salesreason.salesreasonid,
    salesreason.name,
    salesreason.reasontype,
    salesreason.modifieddate
   FROM salesreason;



CREATE TABLE salesterritory (
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

CREATE VIEW st AS
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
   FROM salesterritory;



CREATE TABLE salesterritoryhistory (
    businessentityid integer NOT NULL,
    territoryid integer NOT NULL,
    startdate timestamp without time zone NOT NULL,
    enddate timestamp without time zone,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesTerritoryHistory_EndDate" CHECK (((enddate >= startdate) OR (enddate IS NULL)))
);



CREATE VIEW sth AS
 SELECT salesterritoryhistory.territoryid AS id,
    salesterritoryhistory.businessentityid,
    salesterritoryhistory.territoryid,
    salesterritoryhistory.startdate,
    salesterritoryhistory.enddate,
    salesterritoryhistory.rowguid,
    salesterritoryhistory.modifieddate
   FROM salesterritoryhistory;



CREATE TABLE salestaxrate (
    salestaxrateid integer NOT NULL,
    stateprovinceid integer NOT NULL,
    taxtype smallint NOT NULL,
    taxrate numeric DEFAULT 0.00 NOT NULL,
    name public."Name" NOT NULL,
    rowguid uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    modifieddate timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT "CK_SalesTaxRate_TaxType" CHECK (((taxtype >= 1) AND (taxtype <= 3)))
);
CREATE VIEW tr AS
 SELECT salestaxrate.salestaxrateid AS id,
    salestaxrate.salestaxrateid,
    salestaxrate.stateprovinceid,
    salestaxrate.taxtype,
    salestaxrate.taxrate,
    salestaxrate.name,
    salestaxrate.rowguid,
    salestaxrate.modifieddate
   FROM salestaxrate;



CREATE SEQUENCE creditcard_creditcardid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE creditcard_creditcardid_seq OWNED BY creditcard.creditcardid;

CREATE SEQUENCE currencyrate_currencyrateid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE currencyrate_currencyrateid_seq OWNED BY currencyrate.currencyrateid;

CREATE SEQUENCE customer_customerid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE customer_customerid_seq OWNED BY customer.customerid;

CREATE SEQUENCE salesorderdetail_salesorderdetailid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE salesorderdetail_salesorderdetailid_seq OWNED BY salesorderdetail.salesorderdetailid;

CREATE SEQUENCE salesorderheader_salesorderid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE salesorderheader_salesorderid_seq OWNED BY salesorderheader.salesorderid;

CREATE SEQUENCE salesreason_salesreasonid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE salesreason_salesreasonid_seq OWNED BY salesreason.salesreasonid;

CREATE SEQUENCE salestaxrate_salestaxrateid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE salestaxrate_salestaxrateid_seq OWNED BY salestaxrate.salestaxrateid;

CREATE SEQUENCE salesterritory_territoryid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE salesterritory_territoryid_seq OWNED BY salesterritory.territoryid;

CREATE SEQUENCE shoppingcartitem_shoppingcartitemid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE shoppingcartitem_shoppingcartitemid_seq OWNED BY shoppingcartitem.shoppingcartitemid;

CREATE SEQUENCE specialoffer_specialofferid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE specialoffer_specialofferid_seq OWNED BY specialoffer.specialofferid;

CREATE VIEW vindividualcustomer AS
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
   FROM (((((((((person p
     JOIN businessentityaddress bea ON ((bea.businessentityid = p.businessentityid)))
     JOIN address a ON ((a.addressid = bea.addressid)))
     JOIN stateprovince sp ON ((sp.stateprovinceid = a.stateprovinceid)))
     JOIN countryregion cr ON (((cr.countryregioncode)::text = (sp.countryregioncode)::text)))
     JOIN addresstype at ON ((at.addresstypeid = bea.addresstypeid)))
     JOIN customer c ON ((c.personid = p.businessentityid)))
     LEFT JOIN emailaddress ea ON ((ea.businessentityid = p.businessentityid)))
     LEFT JOIN personphone pp ON ((pp.businessentityid = p.businessentityid)))
     LEFT JOIN phonenumbertype pnt ON ((pnt.phonenumbertypeid = pp.phonenumbertypeid)))
  WHERE (c.storeid IS NULL);



CREATE VIEW vpersondemographics AS
 SELECT businessentityid,
    (((xpath('n:TotalPurchaseYTD/text()'::text, demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying)::money AS totalpurchaseytd,
    (((xpath('n:DateFirstPurchase/text()'::text, demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying)::date AS datefirstpurchase,
    (((xpath('n:BirthDate/text()'::text, demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying)::date AS birthdate,
    ((xpath('n:MaritalStatus/text()'::text, demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying(1) AS maritalstatus,
    ((xpath('n:YearlyIncome/text()'::text, demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying(30) AS yearlyincome,
    ((xpath('n:Gender/text()'::text, demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying(1) AS gender,
    (((xpath('n:TotalChildren/text()'::text, demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying)::integer AS totalchildren,
    (((xpath('n:NumberChildrenAtHome/text()'::text, demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying)::integer AS numberchildrenathome,
    ((xpath('n:Education/text()'::text, demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying(30) AS education,
    ((xpath('n:Occupation/text()'::text, demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying(30) AS occupation,
    (((xpath('n:HomeOwnerFlag/text()'::text, demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying)::boolean AS homeownerflag,
    (((xpath('n:NumberCarsOwned/text()'::text, demographics, '{{n,http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey}}'::text[]))[1])::character varying)::integer AS numbercarsowned
   FROM person
  WHERE (demographics IS NOT NULL);



CREATE VIEW vsalesperson AS
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
   FROM ((((((((((salesperson s
     JOIN employee e ON ((e.businessentityid = s.businessentityid)))
     JOIN person p ON ((p.businessentityid = s.businessentityid)))
     JOIN businessentityaddress bea ON ((bea.businessentityid = s.businessentityid)))
     JOIN address a ON ((a.addressid = bea.addressid)))
     JOIN stateprovince sp ON ((sp.stateprovinceid = a.stateprovinceid)))
     JOIN countryregion cr ON (((cr.countryregioncode)::text = (sp.countryregioncode)::text)))
     LEFT JOIN salesterritory st ON ((st.territoryid = s.territoryid)))
     LEFT JOIN emailaddress ea ON ((ea.businessentityid = p.businessentityid)))
     LEFT JOIN personphone pp ON ((pp.businessentityid = p.businessentityid)))
     LEFT JOIN phonenumbertype pnt ON ((pnt.phonenumbertypeid = pp.phonenumbertypeid)));



CREATE VIEW vsalespersonsalesbyfiscalyears AS
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
FROM vSalesPersonSalesByFiscalYearsData
ORDER BY 2,4'::text, 'SELECT unnest(''{2012,2013,2014}''::text[])'::text) salestotal("SalesPersonID" integer, "FullName" text, "JobTitle" text, "SalesTerritory" text, "2012" numeric(12,4), "2013" numeric(12,4), "2014" numeric(12,4));



CREATE VIEW vsalespersonsalesbyfiscalyearsdata AS
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
           FROM ((((salesperson sp
             JOIN salesorderheader soh ON ((sp.businessentityid = soh.salespersonid)))
             JOIN salesterritory st ON ((sp.territoryid = st.territoryid)))
             JOIN employee e ON ((soh.salespersonid = e.businessentityid)))
             JOIN person p ON ((p.businessentityid = sp.businessentityid)))) granular
  GROUP BY granular.salespersonid, granular.fullname, granular.jobtitle, granular.salesterritory, granular.fiscalyear;



CREATE VIEW vstorewithaddresses AS
 SELECT s.businessentityid,
    s.name,
    at.name AS addresstype,
    a.addressline1,
    a.addressline2,
    a.city,
    sp.name AS stateprovincename,
    a.postalcode,
    cr.name AS countryregionname
   FROM (((((store s
     JOIN businessentityaddress bea ON ((bea.businessentityid = s.businessentityid)))
     JOIN address a ON ((a.addressid = bea.addressid)))
     JOIN stateprovince sp ON ((sp.stateprovinceid = a.stateprovinceid)))
     JOIN countryregion cr ON (((cr.countryregioncode)::text = (sp.countryregioncode)::text)))
     JOIN addresstype at ON ((at.addresstypeid = bea.addresstypeid)));



CREATE VIEW vstorewithcontacts AS
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
   FROM ((((((store s
     JOIN businessentitycontact bec ON ((bec.businessentityid = s.businessentityid)))
     JOIN contacttype ct ON ((ct.contacttypeid = bec.contacttypeid)))
     JOIN person p ON ((p.businessentityid = bec.personid)))
     LEFT JOIN emailaddress ea ON ((ea.businessentityid = p.businessentityid)))
     LEFT JOIN personphone pp ON ((pp.businessentityid = p.businessentityid)))
     LEFT JOIN phonenumbertype pnt ON ((pnt.phonenumbertypeid = pp.phonenumbertypeid)));



CREATE VIEW vstorewithdemographics AS
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
   FROM store;



ALTER TABLE ONLY department ALTER COLUMN departmentid SET DEFAULT nextval('department_departmentid_seq'::regclass);

ALTER TABLE ONLY jobcandidate ALTER COLUMN jobcandidateid SET DEFAULT nextval('jobcandidate_jobcandidateid_seq'::regclass);

ALTER TABLE ONLY shift ALTER COLUMN shiftid SET DEFAULT nextval('shift_shiftid_seq'::regclass);

ALTER TABLE ONLY address ALTER COLUMN addressid SET DEFAULT nextval('address_addressid_seq'::regclass);

ALTER TABLE ONLY addresstype ALTER COLUMN addresstypeid SET DEFAULT nextval('addresstype_addresstypeid_seq'::regclass);

ALTER TABLE ONLY businessentity ALTER COLUMN businessentityid SET DEFAULT nextval('businessentity_businessentityid_seq'::regclass);

ALTER TABLE ONLY contacttype ALTER COLUMN contacttypeid SET DEFAULT nextval('contacttype_contacttypeid_seq'::regclass);

ALTER TABLE ONLY emailaddress ALTER COLUMN emailaddressid SET DEFAULT nextval('emailaddress_emailaddressid_seq'::regclass);

ALTER TABLE ONLY phonenumbertype ALTER COLUMN phonenumbertypeid SET DEFAULT nextval('phonenumbertype_phonenumbertypeid_seq'::regclass);

ALTER TABLE ONLY stateprovince ALTER COLUMN stateprovinceid SET DEFAULT nextval('stateprovince_stateprovinceid_seq'::regclass);

ALTER TABLE ONLY billofmaterials ALTER COLUMN billofmaterialsid SET DEFAULT nextval('billofmaterials_billofmaterialsid_seq'::regclass);

ALTER TABLE ONLY illustration ALTER COLUMN illustrationid SET DEFAULT nextval('illustration_illustrationid_seq'::regclass);

ALTER TABLE ONLY location ALTER COLUMN locationid SET DEFAULT nextval('location_locationid_seq'::regclass);

ALTER TABLE ONLY product ALTER COLUMN productid SET DEFAULT nextval('product_productid_seq'::regclass);

ALTER TABLE ONLY productcategory ALTER COLUMN productcategoryid SET DEFAULT nextval('productcategory_productcategoryid_seq'::regclass);

ALTER TABLE ONLY productdescription ALTER COLUMN productdescriptionid SET DEFAULT nextval('productdescription_productdescriptionid_seq'::regclass);

ALTER TABLE ONLY productmodel ALTER COLUMN productmodelid SET DEFAULT nextval('productmodel_productmodelid_seq'::regclass);

ALTER TABLE ONLY productphoto ALTER COLUMN productphotoid SET DEFAULT nextval('productphoto_productphotoid_seq'::regclass);

ALTER TABLE ONLY productreview ALTER COLUMN productreviewid SET DEFAULT nextval('productreview_productreviewid_seq'::regclass);

ALTER TABLE ONLY productsubcategory ALTER COLUMN productsubcategoryid SET DEFAULT nextval('productsubcategory_productsubcategoryid_seq'::regclass);

ALTER TABLE ONLY scrapreason ALTER COLUMN scrapreasonid SET DEFAULT nextval('scrapreason_scrapreasonid_seq'::regclass);

ALTER TABLE ONLY transactionhistory ALTER COLUMN transactionid SET DEFAULT nextval('transactionhistory_transactionid_seq'::regclass);

ALTER TABLE ONLY workorder ALTER COLUMN workorderid SET DEFAULT nextval('workorder_workorderid_seq'::regclass);

ALTER TABLE ONLY purchaseorderdetail ALTER COLUMN purchaseorderdetailid SET DEFAULT nextval('purchaseorderdetail_purchaseorderdetailid_seq'::regclass);

ALTER TABLE ONLY purchaseorderheader ALTER COLUMN purchaseorderid SET DEFAULT nextval('purchaseorderheader_purchaseorderid_seq'::regclass);

ALTER TABLE ONLY shipmethod ALTER COLUMN shipmethodid SET DEFAULT nextval('shipmethod_shipmethodid_seq'::regclass);

ALTER TABLE ONLY creditcard ALTER COLUMN creditcardid SET DEFAULT nextval('creditcard_creditcardid_seq'::regclass);

ALTER TABLE ONLY currencyrate ALTER COLUMN currencyrateid SET DEFAULT nextval('currencyrate_currencyrateid_seq'::regclass);

ALTER TABLE ONLY customer ALTER COLUMN customerid SET DEFAULT nextval('customer_customerid_seq'::regclass);

ALTER TABLE ONLY salesorderdetail ALTER COLUMN salesorderdetailid SET DEFAULT nextval('salesorderdetail_salesorderdetailid_seq'::regclass);

ALTER TABLE ONLY salesorderheader ALTER COLUMN salesorderid SET DEFAULT nextval('salesorderheader_salesorderid_seq'::regclass);

ALTER TABLE ONLY salesreason ALTER COLUMN salesreasonid SET DEFAULT nextval('salesreason_salesreasonid_seq'::regclass);

ALTER TABLE ONLY salestaxrate ALTER COLUMN salestaxrateid SET DEFAULT nextval('salestaxrate_salestaxrateid_seq'::regclass);

ALTER TABLE ONLY salesterritory ALTER COLUMN territoryid SET DEFAULT nextval('salesterritory_territoryid_seq'::regclass);

ALTER TABLE ONLY shoppingcartitem ALTER COLUMN shoppingcartitemid SET DEFAULT nextval('shoppingcartitem_shoppingcartitemid_seq'::regclass);

ALTER TABLE ONLY specialoffer ALTER COLUMN specialofferid SET DEFAULT nextval('specialoffer_specialofferid_seq'::regclass);



