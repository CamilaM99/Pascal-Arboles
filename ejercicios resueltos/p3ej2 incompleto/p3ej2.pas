{a. Implemente un módulo que lea información de ventas de un comercio. De cada venta se lee código de producto, fecha y cantidad de unidades vendidas. 
La lectura finaliza con el código de producto 0. Un producto puede estar en más de una venta. Se pide:
i. Generar y retornar un árbol binario de búsqueda de ventas ordenado por código de producto.
ii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por código de producto. Cada nodo del árbol debe contener el código de producto 
y la cantidad total vendida.
               Nota: El módulo debe retornar los dos árboles.
b. Implemente un módulo que reciba el árbol generado en i. y un código de producto y retorne la cantidad total de unidades vendidas de ese producto.
c. Implemente un módulo que reciba el árbol generado en ii. y un código de producto y retorne la cantidad total de unidades vendidas de ese producto.
}



 program p3ej2;
 type
 venta = record 
	cod:integer;
	fecha:integer;
	cant:integer;
 end;
 
 arbolVenta = ^nodoVenta;
 nodoVenta = record 
	dato:venta;
	hi:arbolVenta;
	hd:arbolVenta;
 end;
 
 
 producto = record 
	cod: integer;
	cant:integer;
 end;
 
 arbolProducto = ^nodoProducto;
 nodoProducto = record
	dato:producto;
	hi:arbolProducto;
	hd:arbolProducto;
 end;
 
 
//i. Generar y retornar un árbol de ventas ordenado por código de producto. 
procedure generarArbolVenta (var a:arbolVenta);
 
	procedure leerVenta (var v:venta);
	begin
		v.cod:=random(10);
		writeln('   codigo ', v.cod);
		if (v.cod > 0) then begin
			v.fecha:= random(31);
			writeln('   fecha ', v.fecha);
			v.cant:= random(10);
			writeln('   cant ', v.cant);
			writeln('--------------');
		end;
	end;
		
	procedure insertarDatos (var a:arbolVenta; v:venta);
	begin
		if (a = nil) then begin
			new(a);
			a^.dato:=v;
			a^.hi:=nil;
			a^.hd:=nil;
		end
		else
		if (v.cod < a^.dato.cod) then 
			insertarDatos(a^.hi, v)
		else
			insertarDatos(a^.hd, v);
	end;
	
var v:venta;
begin
	a:=nil;
	leerVenta(v);
	while (v.cod > 0) do begin
		insertarDatos(a,v);
		leerVenta(v);
	end;
end;

//ii. Generar y retornar otro árbol de productos vendidos ordenado por código de producto.
// Cada nodo del árbol debe contener el código de producto y la cantidad total vendida.
               //Nota: El módulo debe retornar los dos árboles.
procedure generarArbolProducto(var ap: arbolProducto; a:arbolVenta); 
	
	procedure insertarDatos(var ap:arbolProducto; a:arbolVenta);
	begin
		if (ap = nil) then begin
			new(ap);
			ap^.dato.cod:= a^.dato.cod;
			ap^.dato.cant:= a^.dato.cant;
			ap^.hi:=nil;
			ap^.hd:=nil;
		end
		else 
		if (a^.dato.cod < ap^.dato.cod )then 
			generarArbolProducto(ap^.hi, a)
		else
			generarArbolProducto(ap^.hd, a);
	end;
	
	procedure recorroArbolVenta (a:arbolVenta; ap:arbolProducto);
	begin
		if (a <> nil) then begin
			recorroArbolVenta(a^.hi,ap);
			insertarDatos(ap,a);
			recorroArbolVenta(a^.hd,ap);
		end;
	end;
	
begin
	recorroArbolVenta(a,ap);
end;

//proposito debugging
procedure imprimirCod (a:arbolProducto);	
begin
	if (a <> nil) then begin
		imprimirCod(a^.hi);
		writeln(a^.dato.cod);
		imprimirCod(a^.hd);
	end;
end;
	
//programa principal
var a:arbolVenta; ap:arbolProducto;
begin
	generarArbolVenta(a);
	generarArbolProducto(ap,a);
	writeln(' ----- imprimir arbol -----');
	imprimirCod(ap);
end.
