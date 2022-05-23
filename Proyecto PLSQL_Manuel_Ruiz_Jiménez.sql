--Base de Datos

--Drop tables de la base de datos.

DROP TABLE TIENDA CASCADE CONSTRAINTS;
DROP TABLE EMPLEADOS CASCADE CONSTRAINTS;
DROP TABLE CLIENTES CASCADE CONSTRAINTS;
DROP TABLE PRODUCTOS_SERVICIOS CASCADE CONSTRAINTS;
DROP TABLE VENTA CASCADE CONSTRAINTS;
DROP TABLE REGISTRO_PRODUCTO CASCADE CONSTRAINTS;

/*
Base de datos para gestionar tiendas de mascotas junto a sus productos y ventas a clientes.

Consta de las siguientes Tablas:
    1 clientes 
    2 empleados
    3 productos_servicios
    4 venta
    5 tienda 
    6 registro_producto

empleados trabaja en tienda

ventas es realizada por empleados 
ventas registra productos_o_servicios comprados
ventas registras clientes que compran

tienda tiene registro_producto
productos_o_servicios se registran en registro_producto

*/
--Tablas de la BBDD.

CREATE TABLE TIENDA(
    COD_TIENDA NUMBER(4) CONSTRAINT TIE_COT_PK PRIMARY KEY, --Primary key de la tabla
    CIUDAD VARCHAR2(15) NOT NULL,
    DIRECCION VARCHAR2(35) NOT NULL,
    CONSTRAINT TIE_DIR_UQ UNIQUE(DIRECCION) --aqui a�adi un unique porque es imposible que tiendas distintas esten en la misma direccion
);

CREATE TABLE EMPLEADOS(
    COD_EMPLE NUMBER(4) CONSTRAINT EMP_COE_PK PRIMARY KEY, --Primary key de la tabla
    DNI VARCHAR2(9) CONSTRAINT EMP_DNI_UQ UNIQUE , --aqui a�adi un unique porque es imposible que dos personas tengan el mismo DNI
    NOMBRE VARCHAR2(10) NOT NULL,
    APELLIDO1 VARCHAR2(10),
    APELLIDO2 VARCHAR2(10),
    FECHA_ALTA DATE NOT NULL,
    COD_TIENDA NUMBER(4) CONSTRAINT EMP_COT_FK REFERENCES TIENDA(COD_TIENDA) --Referenciamos el atributo a su respectiva tabla
);

CREATE TABLE CLIENTES(
    DNI_CLI VARCHAR2(9) CONSTRAINT CLI_DNI_PK PRIMARY KEY, --Primary key de la tabla
    NOMBRE VARCHAR2(10) NOT NULL,
    APELLIDO1 VARCHAR2(10),
    APELLIDO2 VARCHAR2(10)
);

CREATE TABLE PRODUCTOS_SERVICIOS(
    COD_PRODUC NUMBER(4) CONSTRAINT PRS_COP_PK PRIMARY KEY, --Primary key de la tabla
    NOMBRE VARCHAR2(40) NOT NULL,
    Categoria VARCHAR2(20) NOT NULL,
    DESCRIPCION VARCHAR2(40),
    PRECIO NUMBER(4,2) default 10 CONSTRAINT PRS_PRE_CH CHECK(PRECIO>0)
);

CREATE TABLE VENTA(
    COD_EMPLE NUMBER(4) CONSTRAINT VEN_COE_FK REFERENCES EMPLEADOS(COD_EMPLE),--Referenciamos el atributo a su respectiva tabla
    DNI_CLI VARCHAR2(9) CONSTRAINT VEN_DNC_FK REFERENCES CLIENTES(DNI_CLI),--Referenciamos el atributo a su respectiva tabla
    COD_PRODUC NUMBER(4) CONSTRAINT VEN_COP_FK REFERENCES PRODUCTOS_SERVICIOS(COD_PRODUC),--Referenciamos el atributo a su respectiva tabla
    CONSTRAINT VEN_PK PRIMARY KEY(COD_EMPLE,DNI_CLI,COD_PRODUC) --Primary key de la tabla
);

CREATE TABLE REGISTRO_PRODUCTO(
    COD_TIENDA NUMBER(4) CONSTRAINT REP_COT_FK REFERENCES TIENDA(COD_TIENDA), --Referenciamos el atributo a su respectiva tabla
    COD_PRODUC NUMBER(4) CONSTRAINT REP_COP_FK REFERENCES PRODUCTOS_SERVICIOS(COD_PRODUC), --Referenciamos el atributo a su respectiva tabla
    CONSTRAINT REP_PK PRIMARY KEY(COD_PRODUC,COD_TIENDA) --Primary key de la tabla
);


--INSERT INTO de las tablas
--Tienda
INSERT INTO TIENDA values(100,'Hinojos','Dr. Lucas Bermudo, 42');
INSERT INTO TIENDA values(200,'Sevilla','C. Francisco Carrión Mejías, 15');

--EMPLEADOS

INSERT INTO EMPLEADOS values(100,'12345678H','Manuel','Ruiz','Jimenez',SYSDATE,100);
INSERT INTO EMPLEADOS values(101,'24618282P','Guille','Romero','Escribano',SYSDATE,100);
INSERT INTO EMPLEADOS values(102,'65467677L','Chema','pablo',null,SYSDATE,100);
INSERT INTO EMPLEADOS values(103,'78781788D','Adrian','Lira','Moyano',SYSDATE,100);
INSERT INTO EMPLEADOS values(104,'35478451R','Carlos','Perez','Roldan',SYSDATE,100);
INSERT INTO EMPLEADOS values(105,'96548451R','Mario','Tirado','Gallardo',SYSDATE,100);

INSERT INTO EMPLEADOS values(200,'18153548H','Alberto','Cardeno','Dominguez',SYSDATE,200);
INSERT INTO EMPLEADOS values(201,'31549175J','Daniel','Segura',null,SYSDATE,200);
INSERT INTO EMPLEADOS values(202,'13525684C','Miguel','Mondeja',null,SYSDATE,200);
INSERT INTO EMPLEADOS values(203,'35416818N','Adan',null,null,SYSDATE,200);
INSERT INTO EMPLEADOS values(204,'54341835T','Juaquin',null,null,SYSDATE,200);

--Clientes

INSERT INTO clientes values('61464715K','Pepe','Gil',null);
INSERT INTO clientes values('78616484L','Pedro','Perez',null);
INSERT INTO clientes values('67163118B','Juan',null,null);
INSERT INTO clientes values('38716875R','Maria','Rodriguez',null);
INSERT INTO clientes values('56877816Q','Sonia','Moreno',null);
INSERT INTO clientes values('71934885V','Mario','Naranjo',null);

--PRODUCTOS_SERVICIOS

INSERT INTO PRODUCTOS_SERVICIOS values(1,'Limpieza','Limpieza','Limpieza de mascotas en tienda',25.99);
INSERT INTO PRODUCTOS_SERVICIOS values(2,'Adiestramiento de perros','Adiestramiento','Adiestramiento de Perros',99.99);
INSERT INTO PRODUCTOS_SERVICIOS values(3,'Acogida de Macota','Acogida de Macota','acogida de mascotas en tienda',50.5);
INSERT INTO PRODUCTOS_SERVICIOS values(4,'pelota','Juguete','pelota para mascota',10);
INSERT INTO PRODUCTOS_SERVICIOS values(5,'comida perro','comida','5KG de comida para perro',8);
INSERT INTO PRODUCTOS_SERVICIOS values(6,'cama mascota','accesorio','cama para gatos',5);
INSERT INTO PRODUCTOS_SERVICIOS values(7,'Hueso mordedor','Juguete','hueso para morder',12);
INSERT INTO PRODUCTOS_SERVICIOS values(8,'Comida de gatos','comida','5KG de comida para gatos',9);
INSERT INTO PRODUCTOS_SERVICIOS values(9,'rascador para gatos','accesorio','rascador para gatos',20);

--VENTA

INSERT INTO venta values(100,'78616484L',1);
INSERT INTO venta values(100,'78616484L',2);
INSERT INTO venta values(101,'67163118B',5);
INSERT INTO venta values(101,'67163118B',6);
INSERT INTO venta values(102,'78616484L',2);
INSERT INTO venta values(102,'38716875R',3);
INSERT INTO venta values(102,'38716875R',5);
INSERT INTO venta values(103,'38716875R',6);
INSERT INTO venta values(104,'56877816Q',7);
INSERT INTO venta values(105,'56877816Q',8);
INSERT INTO venta values(105,'56877816Q',9);
INSERT INTO venta values(200,'71934885V',6);
INSERT INTO venta values(201,'71934885V',4);
INSERT INTO venta values(202,'71934885V',2);
INSERT INTO venta values(203,'61464715K',1);
INSERT INTO venta values(203,'61464715K',2);
INSERT INTO venta values(203,'61464715K',9);
INSERT INTO venta values(204,'71934885V',3);
INSERT INTO venta values(204,'78616484L',7);
INSERT INTO venta values(204,'78616484L',5);

--REGISTRO_PRODUCTO

INSERT INTO registro_producto values(100,1);
INSERT INTO registro_producto values(100,2);
INSERT INTO registro_producto values(100,3);
INSERT INTO registro_producto values(100,4);
INSERT INTO registro_producto values(100,5);
INSERT INTO registro_producto values(100,6);
INSERT INTO registro_producto values(100,7);
INSERT INTO registro_producto values(100,8);
INSERT INTO registro_producto values(100,9);
INSERT INTO registro_producto values(200,1);
INSERT INTO registro_producto values(200,2);
INSERT INTO registro_producto values(200,3);
INSERT INTO registro_producto values(200,4);
INSERT INTO registro_producto values(200,5);
INSERT INTO registro_producto values(200,6);
INSERT INTO registro_producto values(200,7);
INSERT INTO registro_producto values(200,8);
INSERT INTO registro_producto values(200,9);

COMMIT;


--Procedimientos


CREATE OR REPLACE PROCEDURE Registro_Productos is
    CURSOR Categoria IS 
    SELECT p.categoria
    FROM PRODUCTOS_SERVICIOS p
    GROUP BY p.categoria;
    
    Reg_cat Categoria%ROWTYPE;

    CURSOR Productos(cat VARCHAR2) IS 
    SELECT *
    FROM PRODUCTOS_SERVICIOS
    WHERE categoria=cat;
    
    registro Productos%ROWTYPE;
    
BEGIN
    OPEN Categoria;    
    LOOP
        FETCH Categoria into Reg_cat;
        EXIT WHEN Categoria%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE ('------------------------');
        DBMS_OUTPUT.PUT_LINE ('  ' || Reg_cat.categoria);
        DBMS_OUTPUT.PUT_LINE ('------------------------');
        OPEN Productos(Reg_cat.categoria);        
        LOOP            
            FETCH Productos into registro;        
            EXIT WHEN Productos%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE ('Codigo de Producto : ' || registro.COD_PRODUC);
            DBMS_OUTPUT.PUT_LINE ('Nombre de producto: ' || registro.NOMBRE);
            DBMS_OUTPUT.PUT_LINE ('Descripcion producto: ' || registro.DESCRIPCION);
            DBMS_OUTPUT.PUT_LINE ('Precio producto: ' || registro.PRECIO || '€');
            DBMS_OUTPUT.PUT_LINE (' -------------');
            
        END LOOP;
        CLOSE Productos;
    END LOOP;
    CLOSE Categoria;
END;
/




CREATE OR REPLACE PROCEDURE Registro_Empleados is
    CURSOR Tienda_c IS 
    SELECT *
    FROM tienda t;
    
    Reg_tien Tienda_c%ROWTYPE;

    CURSOR Emple(ID_tienda number) IS 
    SELECT *
    FROM empleados e
    WHERE e.cod_tienda=ID_tienda;
    
    registro Emple%ROWTYPE;
    
BEGIN
    DBMS_OUTPUT.PUT_LINE ('Datos de los empleados segun la tienda');
    DBMS_OUTPUT.PUT_LINE ('---------------------------------------');
    OPEN Tienda_c;    
    LOOP
        FETCH Tienda_c into Reg_tien;
        EXIT WHEN Tienda_c%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE ('------------------------');
        DBMS_OUTPUT.PUT_LINE ('Codigo de tienda : ' || Reg_tien.COD_TIENDA);
        DBMS_OUTPUT.PUT_LINE ('Localidad : ' || Reg_tien.CIUDAD);
        DBMS_OUTPUT.PUT_LINE ('------------------------');
        OPEN Emple(Reg_tien.COD_TIENDA);        
        LOOP            
            FETCH Emple into registro;        
            EXIT WHEN Emple%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE ('Codigo del empleado: ' || registro.COD_EMPLE);
            DBMS_OUTPUT.PUT_LINE ('Nombre empleado : ' || registro.NOMBRE);
            DBMS_OUTPUT.PUT_LINE ('Apellido paterno: ' || registro.APELLIDO1);
            DBMS_OUTPUT.PUT_LINE ('Apellido materno: ' || registro.APELLIDO2);
            DBMS_OUTPUT.PUT_LINE ('DNI empleado: ' || registro.DNI);
            DBMS_OUTPUT.PUT_LINE ('Fecha de alta empleado: ' || registro.FECHA_ALTA);
            DBMS_OUTPUT.PUT_LINE (' -------------');
            
        END LOOP;
        DBMS_OUTPUT.PUT_LINE (' ');
        CLOSE Emple;
    END LOOP;
    CLOSE Tienda_c;
END;
/



CREATE or REPLACE PROCEDURE Nombre_mejor_cliente is
dni_c VARCHAR2(9);
nombre VARCHAR2(20);
Begin

SELECT Mejor_Cliente into dni_c from dual;

SELECT c.nombre into nombre from clientes c where c.dni_cli=dni_c;

DBMS_OUTPUT.PUT_LINE('Nuestro Mejor Cliente es: '|| nombre || ' con DNI: ' || dni_c);
end;
/


--Funciones

CREATE OR REPLACE FUNCTION Mejor_Vendedor
RETURN NUMBER IS    
resul NUMBER;
BEGIN
SELECT p.* into resul from(SELECT cod_emple from venta GROUP BY cod_emple having COUNT(cod_emple)=(SELECT Max(COUNT(COD_EMPLE)) from venta GROUP BY cod_emple)) p where ROWNUM=1;
RETURN resul;
END;
/



CREATE OR REPLACE FUNCTION Mejor_Cliente
RETURN VARCHAR2 IS    
resul VARCHAR2(9);
BEGIN
SELECT p.* into resul from(SELECT DNI_CLI from venta GROUP BY DNI_CLI having COUNT(DNI_CLI)=(SELECT Max(COUNT(DNI_CLI)) from venta GROUP BY DNI_CLI)) p where ROWNUM=1;
RETURN resul;
END;
/

--Principal

DECLARE
Cod number;

begin

    DBMS_OUTPUT.PUT_LINE ('La empresa cuenta con dos tiendas de las cuales contamos con el siguiente equipo.');
    Registro_Empleados;
    
    DBMS_OUTPUT.PUT_LINE(' ');
    
    DBMS_OUTPUT.PUT_LINE('Las dos tiendas comparten el siguiente catalogo: ');
    Registro_Productos;
    
    DBMS_OUTPUT.PUT_LINE(' ');
    
    SELECT Mejor_Vendedor into Cod from dual;
    DBMS_OUTPUT.PUT_LINE('Nuestro mejor vendedor es el empleado con el codigo: '|| Cod);
    
    DBMS_OUTPUT.PUT_LINE(' ');
    nombre_mejor_cliente;
    
end;
/