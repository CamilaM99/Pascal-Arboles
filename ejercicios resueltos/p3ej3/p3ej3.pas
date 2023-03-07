{3.	Implementar un programa que contenga:
a. Un módulo que lea información de alumnos de Taller de Programación y almacene en una estructura de datos 
sólo a aquellos alumnos que posean año de ingreso posterior al 2010. De cada alumno se lee legajo, DNI y año de ingreso. 
La estructura generada debe ser eficiente para la búsqueda por número de legajo. 
b. Un módulo que reciba la estructura generada en a. e informe el DNI y año de ingreso de aquellos alumnos cuyo legajo sea inferior a un valor ingresado como parámetro. 
c. Un módulo que reciba la estructura generada en a. e informe el DNI y 
* año de ingreso de aquellos alumnos cuyo legajo esté comprendido entre dos valores que se reciben como parámetro. 
d. Un módulo que reciba la estructura generada en a. y retorne el DNI más grande.
e. Un módulo que reciba la estructura generada en a. y retorne la cantidad de alumnos con legajo impar.
}
program p3ej3;

type 

alumno = record
	legajo:integer;
	dni:integer;
	ingreso:integer;
end;

arbol = ^nodo;

nodo = record 
	dato:alumno;
	hi:arbol;
	hd:arbol;
end;

//a. generar una estructura que contenga alumnos con año de ingreso posterior a 2010;
//La estructura generada debe ser eficiente para la búsqueda por número de legajo. 
procedure generarArbol (var a: arbol);
	
	procedure leerAlumno (var al:alumno);
	begin
		writeln('-------------------');
		write(' anio de ingreso ');
		read(al.ingreso);
		if (al.ingreso > 2010) then begin
			write(' dni ');
			read(al.dni);
			write(' legajo ');
			read(al.legajo);
		end;
	end;
	
	procedure insertarDatos (var a:arbol; al:alumno);
	begin
		if (a = nil) then begin
			new(a);
			a^.dato:=al;
			a^.hi:=nil;
			a^.hd:=nil;
		end
		else
			if (al.legajo < a^.dato.legajo) then 
				insertarDatos(a^.hi,al)
			else
				insertarDatos(a^.hd,al)
	end;
	
var al:alumno;
begin
	a:=nil;
	leerAlumno(al);
	while (al.ingreso > 2010) do begin
		insertarDatos(a,al);
		leerAlumno(al);
	end;
end;

//b. Un módulo que reciba la estructura generada en a. e informe el DNI y
// año de ingreso de aquellos alumnos cuyo legajo sea inferior a un valor ingresado como parámetro.
procedure informarMenores(a:arbol);

	procedure informar (a:arbol; legajoMax:integer);
	begin
		if (a <> nil) then begin
			if (a^.dato.legajo <= legajoMax) then begin
				informar(a^.hi,legajoMax);
				writeln('dni ', a^.dato.dni,' , ingreso ', a^.dato.ingreso);
				informar(a^.hd,legajoMax);
			end
			else
				informar(a^.hi,legajoMax);
		end;
	end;
	
var legajoMax:integer;	
begin
	writeln('	ingrese el legajo max');
	readln(legajoMax);
	writeln('  --- alumnos con legajo menor a ', legajoMax,'  --- ');
	informar(a,legajoMax);
end;

//c. Un módulo que reciba la estructura generada en a. e informe el DNI y 
// año de ingreso de aquellos alumnos cuyo legajo esté comprendido entre dos valores que se reciben como parámetro. 
procedure informarRango (a:arbol);
	procedure informar(a:arbol; inf,sup:integer);
	begin
		if (a <> nil) then begin
			if (a^.dato.legajo >= inf) and (a^.dato.legajo <= sup) then begin 
				writeln('dni ', a^.dato.dni,', ingreso ', a^.dato.ingreso);
				informar(a^.hi,inf,sup);
				informar(a^.hd,inf,sup);
			end
			else begin
				if (a^.dato.legajo < inf) then
					informar(a^.hd,inf,sup)
				else
					informar(a^.hi,inf,sup);
			end;
		end;
	
	end;
var inf,sup:integer;
begin
	writeln;
	writeln('  ingrese el limite inferior del rango ');
	readln(inf);
	writeln('  ingrese el limite superior del rango ');
	readln(sup);
	informar(a,inf,sup);
end;

//d. Un módulo que reciba la estructura generada en a. y retorne el DNI más grande.
procedure buscarDniMax(a:arbol);

	function dniMax(a:arbol):integer;
	var aux,maxI,maxD:integer;
	begin
		if (a = nil) then 
			dniMax:=-1
		else
		if (a <> nil) then begin
			maxI:= dniMax(a^.hi);
			maxD:= dniMax(a^.hd);
			if (maxI < maxD) then 
				aux:=maxD
			else
				aux:=maxI;
			if (aux < a^.dato.dni) then 
				dniMax:=a^.dato.dni
			else
				dniMax:=aux;
		end;
	end;

begin
	writeln;
	writeln('el dni maximo es ', dniMax(a));
end;

//e. Un módulo que reciba la estructura generada en a. y retorne la cantidad de alumnos con legajo impar.
procedure cantImpares (a:arbol);
	
	function buscar(a:arbol):integer;
	begin
		if (a <> nil) then
			buscar:= ((buscar(a^.hi) + buscar(a^.hd)) + (a^.dato.legajo mod 2))//no entiendo como funciona 
		else
			buscar:=0;
	end;
	
begin
	writeln;
	writeln('	la cantidad de legajos impares es ', buscar(a));
end;

//debugging
procedure imprimirOrden(a:arbol);
begin
	if (a <> nil) then begin
		imprimirOrden(a^.hi);
		writeln('legajo ', a^.dato.legajo);
		imprimirOrden(a^.hd);
	end;
end;

//programa principal
var a:arbol;
begin
	generarArbol(a);
	writeln('  --- arbol impreso en orden ---');
	imprimirOrden(a);
	writeln;
	informarMenores(a);
	informarRango(a);
	buscarDniMax(a);
	cantImpares(a);
end.



