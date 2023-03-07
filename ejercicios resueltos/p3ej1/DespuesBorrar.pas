program arbolesPracticaEj1;

type 
str = string[15];
	
socio = record 
	numero:integer;
	nombre:str;
	edad:integer;
end;

arbol = ^nodo;

nodo = record 
	dato:socio;
	hi:arbol;
	hd:arbol;
end;

//a.crear arbol de socios. la lectura finaliza con el socio numero 0
procedure generarArbol(var a:arbol);

	procedure LeerSocio(var s:socio);
	begin
		//s.numero:=random(10);
		writeln('------------');
		writeln('  numero ');
		//writeln('   ',s.numero);
		readln(s.numero);
		if (s.numero <> 0) then begin 
			writeln('  ingrese nombre ');
			readln(s.nombre);
			//s.edad:=random(99);
			//writeln('  edad ');
			//writeln('   ',s.edad);
			//readln(s.edad);
			writeln('-----------');
		end;
	end;

	procedure insertarDatos(var a:arbol; s:socio);
	begin
		if (a = nil) then begin
			new(a); 
			a^.dato:=s;
			a^.hi:=nil;
			a^.hd:=nil;
		end
		else 
		if(s.numero < a^.dato.numero) then 
			insertarDatos(a^.hi,s)
		else 
			insertarDatos(a^.hd,s);
	end;

var s:socio;
begin
	leerSocio(s);
	while (s.numero <> 0) do begin 
		insertarDatos(a,s);
		leerSocio(s);
	end;
end;
 
procedure informarPares (a:arbol);
begin
	if (a <> nil) then begin
		informarPares(a^.hd);
		if ((a^.dato.numero mod 2 )= 0)then 
			writeln(a^.dato.numero);
		informarPares(a^.hi)
	end;
end;

var a:arbol;
begin
	a:=nil;
	generarArbol(a); //a
	informarPares(a);
end.
