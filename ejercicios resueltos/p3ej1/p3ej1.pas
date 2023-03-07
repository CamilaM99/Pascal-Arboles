{1.	Escribir un programa que:
a. Implemente un módulo que lea información de socios de un club y las almacene en un árbol binario de búsqueda. De cada socio se lee número de socio, nombre y edad. 
La lectura finaliza con el número de socio 0 y el árbol debe quedar ordenado por número de socio.
b. Una vez generado el árbol, realice módulos independientes que reciban el árbol como parámetro y que: 
i. Informe el número de socio más grande. Debe invocar a un módulo recursivo que retorne dicho valor.
ii. Informe los datos del socio con el número de socio más chico. Debe invocar a un módulo recursivo que retorne dicho socio.
iii. Informe el número de socio con mayor edad. Debe invocar a un módulo recursivo que retorne dicho valor.
iv. Aumente en 1 la edad de todos los socios.
v. Lea un valor entero e informe si existe o no existe un socio con ese valor. Debe invocar a un módulo recursivo que reciba el valor leído y retorne verdadero o falso.
vi. Lea un nombre e informe si existe o no existe un socio con ese nombre. Debe invocar a un módulo recursivo que reciba el nombre leído y retorne verdadero o falso.
vii. Informe la cantidad de socios. Debe invocar a un módulo recursivo que retorne dicha cantidad.
viii. Informe el promedio de edad de los socios. Debe invocar a un módulo recursivo que retorne dicho promedio.
ix. Informe, a partir de dos valores que se leen, la cantidad de socios en el árbol cuyo número de socio se encuentra entre los dos valores ingresados. 
Debe invocar a un módulo recursivo que reciba los dos valores leídos y retorne dicha cantidad.
x. Informe los números de socio en orden creciente. 
xi. Informe los números de socio pares en orden decreciente. 
}

program p3ej1;

type

str = string[10];

socio = record
	numero:integer;
	nombre:str;
	edad:integer;
end;

arbol = ^nodo;

nodo = record
	dato: socio;
	hi: arbol;
	hd:arbol;
end;

//a. Implemente un módulo que lea información de socios, La lectura finaliza con el número de socio 0 y el árbol debe quedar ordenado por número de socio.
procedure leerSocio (var s:socio);
begin
	writeln(' numero');
	readln(s.numero);
	if (s.numero <> 0) then begin
		writeln(' nombre');
		readln(s.nombre);
		writeln(' edad');
		readln(s.edad);
	end;
end;

procedure generarArbol(var a:arbol; s:socio);
begin
	if(a = nil) then begin
		new(a);
		a^.dato:=s;
		a^.hi:=nil;
		a^.hd:=nil;
	end
	else begin
	if (s.numero < a^.dato.numero) then 
		generarArbol(a^.hi,s)
	else 
		generarArbol(a^.hd,s)		
	end;
end;

//i. Informe el número de socio más grande. Debe invocar a un módulo recursivo que retorne dicho valor.
function maximo(a:arbol):integer;
begin
	if (a = nil) then 
		maximo:=-1
	else begin
	if (a^.hd = nil) then 
		maximo:=a^.dato.numero
	else 
		maximo:= maximo(a^.hd);
	end;
end;


//ii. Informe los datos del socio con el número de socio más chico. Debe invocar a un módulo recursivo que retorne dicho socio.
function minimo(a:arbol):integer; //mal, solo retorno el numero de socio cuando deberia retornar todos los datos del mismo, ojito con los enunciados!!!!
begin
	if (a = nil) then 
		minimo:=999
	else begin
	if (a^.hi = nil) then 
		minimo:=a^.dato.numero
	else 
		minimo:= minimo(a^.hi);
	end;
end;


//iii. Informe el número de socio con mayor edad. Debe invocar a un módulo recursivo que retorne dicho valor.
procedure actualizarMaximo(var maxEdad,maxNum:integer; nuevaEdad,nuevoNum:integer);
begin
	if (nuevaEdad >= maxEdad) then begin
		maxNum:=nuevoNum;
		maxedad:=nuevaEdad;
	end;
end;

procedure numeroMasEdad(a:arbol; var maxEdad,maxNum:integer );
begin
	if (a <> nil) then begin
		actualizarMaximo(maxEdad,maxNum,a^.dato.edad,a^.dato.numero);
		numeroMasEdad(a^.hi,maxEdad,maxNum);
		numeroMasEdad(a^.hd,maxEdad,maxNum);
	end;
end;

procedure informarNumeroMasEdad (a:arbol;var maxEdad,maxNum:integer);
begin
	maxEdad:=-1;
	numeroMasEdad(a,maxEdad,maxNum);
	if (maxEdad <> -1) then 
		writeln('---> el numero de socio mas viejo es ',maxNum)
	else
		writeln('---> no hay datos en el arbol');
end;

//iv. Aumente en 1 la edad de todos los socios.
procedure aumentarTodos(var a:arbol);
begin
	if (a <> nil) then begin
		a^.dato.edad:= a^.dato.edad +1;
		aumentarTodos(a^.hi);
		aumentarTodos(a^.hd);
	end;		
end;

procedure verificar(a:arbol);
begin
	writeln(' edad   ');
	writeln(a^.dato.edad);
end;

//v. Lea un valor entero e informe si existe o no existe un socio con ese valor.
// Debe invocar a un módulo recursivo que reciba el valor leído y retorne verdadero o falso.
function buscar(a:arbol;dato:integer):boolean;
begin
	if (a = nil) then 
		buscar:=false
	else begin
		if (a^.dato.numero = dato) then 
			buscar:=true
		else 
		if (dato < a^.dato.numero) then
			buscar:=buscar(a^.hi,dato)
		else 
			buscar:=buscar(a^.hd,dato)
	end;
end;

//vi. Lea un nombre e informe si existe o no existe un socio con ese nombre. 
//Debe invocar a un módulo recursivo que reciba el nombre leído y retorne verdadero o falso.
function buscarNom(a:arbol; dato:str):boolean;
begin
	if (a = nil) then 
		buscarNom:=false
	else begin
		if (a^.dato.nombre = dato) then 	
			buscarNom:=true
		else
			if (dato < a^.dato.nombre )then //esto funciona por que son datos as
				buscarNom:= buscarNom(a^.hi,dato)
			else
				buscarNom:= buscarNom(a^.hd,dato)
	end;
end;

//vii. Informe la cantidad de socios. Debe invocar a un módulo recursivo que retorne dicha cantidad.
function cantTotal (a:arbol):integer; //no entiendo como funciona -------------------------------------------!
begin
	if (a <> nil) then 
		cantTotal:=cantTotal(a^.hi)+cantTotal(a^.hd)+1
	else
		cantTotal:=0;
end;

//viii. Informe el promedio de edad de los socios. Debe invocar a un módulo recursivo que retorne dicho promedio.
function sumaEdades(a:arbol):integer;
begin
	if (a <> nil) then 
		sumaEdades:=sumaEdades(a^.hi)+sumaEdades(a^.hd)+a^.dato.edad
	else
		sumaEdades:=0;
end;

//ix. Informe, a partir de dos valores que se leen, la cantidad de socios en el árbol cuyo número de socio se encuentra entre los dos valores ingresados. 
//Debe invocar a un módulo recursivo que reciba los dos valores leídos y retorne dicha cantidad.

//	QUE PASA SI INGRESO UN RANGO QUE NO EXISTE????
function cantRango(a:arbol; min,max:integer):integer;
begin
	if (a = nil) then 
		cantRango:=0
	else begin
		if (a^.dato.numero >= min) and (a^.dato.numero <= max) then 
			cantRango:=cantRango(a^.hi,min,max)+cantRango(a^.hd,min,max)+1
		else 
		if (a^.dato.numero < min) then 
			cantRango:=cantRango(a^.hd,min,max)
		else
			cantRango:=cantRango(a^.hi,min,max);
	end;
end;


//HACER MAS CHICO EL PROGRAMA PRINCIPAL !!

var  a:arbol; s:socio; var maxEdad,maxNum,num,min,max:integer; nombre:str;
begin
	a:=nil;
	leerSocio(s);
	while (s.numero <> 0) do begin
		generarArbol(a,s);
		leerSocio(s);
	end;	

	if (maximo(a) = -1)then  //i
		writeln('el arbol esta vacio')
	else
		writeln('el numero maximo es ', maximo(a));
	if (minimo(a) = 999)then //ii
		writeln('el arbol esta vacio')
	else
		writeln('el numero minimo es ', minimo(a));
	informarNumeroMasEdad(a,maxEdad,maxNum);//iii
	aumentarTodos(a); //iv
	writeln;
	writeln('ingrese el numero de socio que busca');
	readln(num);
	if (buscar(a,num)) then begin //v
		writeln;
		writeln(' el socio numero ',num,' existe');
	end
	else begin
		writeln;
		writeln(' el socio numero ',num,' NO existe');
	end;
	
	writeln;
	writeln('ingrese el nombre de socio que busca');
	readln(nombre);
	if (buscarNom(a,nombre)) then begin //vi
		writeln;
		writeln(' el socio nombre ',nombre,' existe');
	end
	else begin
		writeln;
		writeln(' el socio nombre ',nombre,' NO existe');
	end;
	writeln('la cantidad total de socios es ', cantTotal(a)); //vii
	writeln('la suma de todas las edades es ', sumaEdades(a));
	writeln('el promedio de edades es ', sumaEdades(a)/cantTotal(a):2:1);//viii
	writeln; writeln('ingrese el min del rango '); readln(min);
	writeln('ingrese el max del rango '); readln(max);
	writeln('la cant de socios dentro del rango es ', cantRango(a,min,max));//ix
end.

