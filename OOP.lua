------------------------------------------------------------
--------------PROGRAMACIÓN ORIENTADA A OBJETOS--------------
--------------------------POO o OPP-------------------------
------------------------------------------------------------
dofile('ext.lua')
cls()

------------------------------------------------------------
-- Estructura general de las clases usando tablas

Clase ={
	var1 = v,
	var2 = w,
	.
	.
	.
	varN = z,
	metodos = function(self, argumetos)
		cuerpo de la function
	end
}

	--------------------------------------------------------
	-- La tabla modelo se conoce como metatabla
	--------------------------------------------------------

---- instanciar un objeto en la clase

Objeto = setmetatable({variables = v,w,y,z,},
	{ __index = Clase})

	--------------------------------------------------------
	-- Aconsejable crear una función para instanciar:	
	--------------------------------------------------------

function nuevo( Objeto )
	Objeto = Objeto or {}
	setmetatable(Objeto ,{ __index = Clase})
	return Objeto
end

---- Instanciar:

	--------------------------------------------------------
	-- Se puede iniciar con los valores del  modelo  (clase)
	--------------------------------------------------------

Objeto = nuevo{}

	--------------------------------------------------------
	-- Se puede iniciar con los valores propios  del  objeto
	--------------------------------------------------------

Objeto = nuevo{var1 = v_1, var2 = w_2, ..., varN = z_N}

---- Usar algun metodo de la clase

Objeto:metodo(argumetos)

---- Ejemplos

-----------------------------
Rectangulo = {
	largo = 0,
	ancho = 0,
	dimensiones = function(self, l, a)
		self.largo = l
		self.alto= a
	end,
	area = function(self)
		area = self.largo*self.alto
		return area
	end,
	perimetro = function(self)
		perimetro = 2*(self.largo+self.alto)
		return perimetro
	end
}

	--------------------------------------------------------
	-- Se puede crear una función para instanciar
	--------------------------------------------------------

function nuevo( objeto )
	objeto = objeto or {}
	setmetatable(objeto ,{ __index = Rectangulo})
	return objeto
end

figura1 = nuevo{largo = 5, alto = 10}
figura2 = nuevo{largo = 9, alto = 8}
figura3 = nuevo{largo = 3, alto = 5}
figura4 = nuevo{largo = 4, alto = 10}

	--------------------------------------------------------
	-- A continuación, algo que se puede hacer  pero  no  lo
	-- aconsejo
	--------------------------------------------------------

figura5 = nuevo()
figura5:dimensiones(3,4)

	--------------------------------------------------------
	-- Usando los métodos:
	--------------------------------------------------------

figura1:area()
		--> 50
figura2:area()
		--> 72
figura3:area()
		--> 15
figura4:area()
		--> 40
figura5:area()
		--> 12

figura1:perimetro()
		--> 30
figura2:perimetro()
		--> 34
figura3:perimetro()
		--> 16
figura4:perimetro()
		--> 28
figura5:perimetro()
		--> 14

	--------------------------------------------------------
	-- Se puede agregar un metodo nuevo a la clase sin tener
	-- la necesidad de actualizar los objetos
	-- 
	-- Se debe tener en cuenta que  la  función  del  método
	-- debe ser anonima para que funcione el paramentro self
	--		className = {
	--			...,
	--			metodo = function( self, ... )
	--				body
	--			end
	--		}
	--------------------------------------------------------

rawset (
	Rectangulo,
	'diagonal',
	function(self) 
		return ((self.largo)^2+(self.alto)^2)^0.5
	end
	)

figura5:diagonal()
		--> 5.0 ; Terna Pitagórica
-----------------------------
Persona = {
	id = id,
	nombre = nombre,
	saldo = saldo,
	transferencia = function(self, monto, destinatario)
		if monto > 0 then
			if monto <= self.saldo then
				if destinatario ~= nil then
					self.saldo = self.saldo - monto
					destinatario:Ingreso(monto)
				else
					return 'El destinatario no existe'
				end
			else
				return 'Fondos insuficientes'
			end
		else
			return 'El monto a transferir debe ser positivo'
		end
	end,
	Ingreso = function(self, monto)
		self.saldo = self.saldo + monto
	end
}

function CrearCuenta(Cliente)
	Cliente = Cliente or {}
	setmetatable(Cliente,{__index = Persona})
	return Cliente
end

Nani = CrearCuenta{id = 1, nombre = 'Nani', saldo = 1000}
Felipe = CrearCuenta{id = 2, nombre = 'Felipe', saldo = 20}
Nani:transferencia(500, Carlos)
Nani:transferencia(500, Felipe)

Nani.saldo
		--> 500
Felipe.saldo
		--> 520

	--------------------------------------------------------
	-- Nuevo método --> función anonima
	--------------------------------------------------------
rawset(
	Persona,
	'Retiro',
	function(self, monto) 
		if monto <= self.saldo then 
			self.saldo = self.saldo - monto 
		else 
			return 'Saldo insuficiente' 
		end 
	end
	)

Felipe:Retiro(400)
Felipe.saldo
		--> 120
------------------------------------------------------------