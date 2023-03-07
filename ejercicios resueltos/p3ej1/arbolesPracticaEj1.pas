{Escribir un programa que:
a. Implemente un modulo que lea informacion de socios de un club y las almacene en un arbol binario de busqueda. De cada socio se lee numero de socio, 
nombre y edad. La lectura finaliza con el numero de socio 0 y el arbol debe quedar ordenado por numero de socio.
b. Una vez generado el arbol, realice modulos independientes que reciban el arbol como parametro y: 
    i. Informe el numero de socio mas grande. Debe invocar a un modulo recursivo que retorne dicho valor. 
    ii. Informe los datos del socio con el numero de socio mas chico. 
   Debe invocar a un modulo recursivo que retorne dicho socio. 
    iii. Informe el numero de socio con mayor edad. Debe invocar a un modulo recursivo que retorne dicho valor. 
    iv. Aumente en 1 la edad de todos los socios.
    v. Lea un valor entero e informe si existe o no existe un socio con ese valor. Debe invocar a un modulo recursivo que reciba el valor lei­do y
       retorne verdadero o falso.
    vi. Lea un nombre e informe si existe o no existe un socio con ese valor. Debe invocar a un modulo recursivo que reciba el nombre lei­do y 
        retorne verdadero o falso.
    vii. Informe la cantidad de socios. Debe invocar a un modulo recursivo que retorne dicha cantidad.
    viii. Informe el promedio de edad de los socios. Debe invocar al módulo recursivo del inciso vii e invocar a un módulo recursivo que retorne la suma
          de las edades de los socios.
    ix. Informe, a partir de dos valores que se leen, la cantidad de socios en el arbol cuyo numero de socio se encuentra entre 
        los dos valores ingresados. Debe invocar a un modulo recursivo que reciba los dos valores leÃ­dos y retorne dicha cantidad. 
    x. Informe los numeros de socio en orden creciente. 
    xi. Informe los numeros de socio pares en orden decreciente.
}

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
			s.edad:=random(99);
			writeln('  edad ');
			writeln('   ',s.edad);
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
 
// i. Informe el numero de socio mas grande. Debe invocar a un modulo recursivo que retorne dicho valor. 
procedure maxSocio (a:arbol);
	
	function max(a:arbol):integer;
	begin 
		if (a = nil) then 
			max:=-1
		else 
			if (a^.hd = nil) then 
				max:= a^.dato.numero
			else
				max:= max(a^.hd);
	end;
	
var maximo:integer;
begin
	maximo:=max(a);
	writeln;
	writeln('----- informar el mayor numero de socio ------');
	if (maximo = -1) then 	
		writeln('----> el arbol esta vacio')
	else
		writeln('----> el mayor numero de socio es ', maximo);
end;

//ii. Informe los datos del socio con el numero de socio mas chico. 
//Debe invocar a un modulo recursivo que retorne dicho socio. 
procedure minSocio (a:arbol);
	
	function min (a:arbol):arbol;
	begin
		if ((a = nil) or (a^.hi = nil)) then 
			min:= a
		else
			min:= min(a^.hi);
	end;
var minimo:arbol;
begin
	writeln;
	writeln('----- informar el minimo numero de socio ------');
	minimo:=min(a);
	if (minimo = nil) then 
		writeln('----> el arbol esta vacio')
	else 
		writeln('----> el socio con el numero minimo se llama ', minimo^.dato.nombre, ', tiene ',minimo^.dato.edad,' anios, numero de socio ',minimo^.dato.numero);
end;


// iii. Informe el numero de socio con mayor edad. Debe invocar a un modulo recursivo que retorne dicho valor. 
procedure maxEdad(a:arbol);
	
	procedure actualizarMaximo(var edadMax,numMax:integer; nuevaEdad,nuevoNum:integer);
	begin
		if (nuevaEdad > edadMax) then begin
			edadMax:=nuevaEdad;
			numMax:= nuevoNum;
		end			
	end;
	
	procedure recorrerArbol (a:arbol; var maxEdad,maxNum:integer);
	begin
		if (a <> nil) then begin
			recorrerArbol(a^.hi,maxEdad,maxNum);
			actualizarMaximo(maxEdad,maxNum,a^.dato.edad,a^.dato.numero);
			recorrerArbol(a^.hd,maxEdad,maxNum);			
		end;			
	end;
	
var maxEdad,maxNum:integer;	
begin
	maxEdad:=-1;
	writeln; writeln('----- Informar el numero de socio con mayor edad -----');
	recorrerArbol(a,maxEdad,maxNum);
	if (maxEdad = -1) then 
		writeln('----> el arbol esta vacio')
	else
		writeln('el numero de socio con mayor edad es ', maxNum,', tiene ',maxEdad,' anios ');
end;

//iv. Aumente en 1 la edad de todos los socios.
procedure aumentarEdad(var a:arbol);
begin 
	if (a <> nil) then begin
		a^.dato.edad:= a^.dato.edad + 1;
		aumentarEdad(a^.hi);
		aumentarEdad(a^.hd);
	end;
end;

//v. Lea un valor entero e informe si existe o no existe un socio con ese valor. Debe invocar a 
//un modulo recursivo que reciba el valor lei­do y retorne verdadero o falso.
procedure buscarSocio (a:arbol);
	
	function buscar (a:arbol; dato:integer):boolean;
	begin
		if (a = nil) then 
			buscar:=false
		else 
		if (a^.dato.numero = dato) then 
			buscar:=true
		else
			if (dato < a^.dato.numero) then	
				buscar:=buscar(a^.hi,dato)
			else 
				buscar:=buscar(a^.hd,dato)
	end;
	
var dato:integer;
begin
	writeln;
	writeln(' ----> inserte el numero de socio a buscar');
	readln(dato);
	if (buscar(a,dato)) then 
		writeln(' ----> el valor existe')
	else
		writeln(' ----> el valor No existe');
end;

//vi. Lea un nombre e informe si existe o no existe un socio con ese valor. 
//Debe invocar a un modulo recursivo que reciba el nombre lei­do y  retorne verdadero o falso.
 procedure buscarNombre (a:arbol);
	
	function buscarNombre (a:arbol; nom:str):boolean;
	begin
		if (a <> nil) then begin			
			if (nom = a^.dato.nombre) then 
				buscarNombre:=true
			else begin
				buscarNombre:=buscarNombre(a^.hd, nom);
				if (buscarNombre = false) then 
					buscarNombre:=buscarNombre(a^.hi, nom)
			end;
		end
		else
			buscarNombre:=false;
	end;

var nom:str;
begin
	writeln;
	writeln('----> inserte el nombre de socio a buscar');
	readln(nom);
	if (buscarNombre(a,nom)) then 
		writeln(' ----> el valor existe')
	else
		writeln(' ----> el valor NO existe');
end;
{
* no funciona, no se por qué
* procedure buscarNombre (a:arbol);
	
	function buscarNombre (a:arbol; nom:str):boolean;
	begin
		if (a <> nil) then begin			
			if (nom = a^.dato.nombre) then 
				buscarNombre:=true
		else begin
			buscarNombre:=buscarNombre(a^.hd, nom);
		if (buscarNombre = false) then 
				buscarNombre:=buscarNombre(a^.hi, nom);
		end;
		else
			buscarNombre:=false;
		end;
	end;

var nom:str;
begin
	writeln;
	writeln('----> inserte el nombre de socio a buscar');
	readln(nom);
	if (buscarNombre(a,nom)) then 
		writeln(' ----> el valor existe')
	else
		writeln(' ----> el valor No existe');
end;}

//vii. Informe la cantidad de socios. Debe invocar a un modulo recursivo que retorne dicha cantidad.
function contar (a:arbol):integer;
begin
	if (a = nil) then 
		contar:=0
	else
		contar:=contar(a^.hi)+contar(a^.hd)+1;
end;


// viii. Informe el promedio de edad de los socios. Debe invocar al módulo recursivo 	
//del inciso vii e invocar a un módulo recursivo que retorne la suma de las edades de los socios.
procedure promedioEdades(a:arbol);
	
	function sumarEdades (a:arbol):integer;
	begin
		if (a <> nil) then 
			sumarEdades:= sumarEdades(a^.hi) +  sumarEdades(a^.hd) + a^.dato.edad
		else
			sumarEdades:=0;
	end;

var edad, cant:integer;
begin
	edad:=sumarEdades(a);
	cant:=contar(a);
	writeln(' suma de edades  ',edad);
	if (edad > 0) then 
		writeln('-----> el promedio de las edades de los socios ', edad/cant:3:2)
	else
		writeln('----> no hay socios');
end;

//ix. Informe, a partir de dos valores que se leen, la cantidad de socios en el arbol cuyo numero de socio se encuentra entre 
//los dos valores ingresados. Debe invocar a un modulo recursivo que reciba los dos valores lei­dos y retorne dicha cantidad.
procedure buscarEnRango (a:arbol);
	
	function contarEnRango(a:arbol; min,max:integer):integer;
	begin
		if (a <> nil) then begin
			if (a^.dato.numero >= min) and (a^.dato.numero <= max) then 
				contarEnRango:= contarEnRango(a^.hi,min,max) + contarEnRango(a^.hd,min,max) +1
		else
			if (min < a^.dato.numero) then 
				contarEnRango:=contarEnRango(a^.hd,min,max)
			else 
				contarEnRango:=contarEnRango(a^.hi,min,max)
		end	
		else
			contarEnRango:=0;
	end;
	
var min,max:integer;
begin
	writeln('----> ingrese el valor minimo del rango ');
	readln(min);
	writeln('----> ingrese el valor maximo del rango ');
	readln(max);
	writeln('la cantidad de socios que existen en el rango es ', contarEnRango(a,min,max));
end;

//x. Informe los numeros de socio en orden creciente. 
procedure InformarCreciente (a:arbol);
begin
	if (a <> nil) then begin
		informarCreciente (a^.hi);
		writeln(a^.dato.numero);
		informarCreciente (a^.hd);
	end;
end;	

//  xi. Informe los numeros de socio pares en orden decreciente.
procedure informarPares (a:arbol);
begin
	if (a <> nil) then begin
		informarPares(a^.hd);
		if ((a^.dato.numero mod 2 )= 0)then 
			writeln(a^.dato.numero);
		informarPares(a^.hi)
	end;
end;

//programa principal
 var a:arbol;
 begin
	a:=nil;
	generarArbol(a); //a
	maxSocio(a);//i
	minSocio(a);//ii
	maxEdad(a);//iii
	aumentarEdad(a);//iv
    buscarSocio(a);//v
    buscarNombre(a);//vi
    writeln('---> la cantidad de socios es ', contar(a));//vii
    promedioEdades(a); //viii
    buscarEnRango(a);//ix
    writeln('---- numeros de socios impresos en orden creciente ----');
    informarCreciente(a);//x
    informarPares(a);//xi
 end.
