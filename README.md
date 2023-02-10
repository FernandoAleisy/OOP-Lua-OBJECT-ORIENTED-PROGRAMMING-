# OOP-Lua-OBJECT-ORIENTED-PROGRAMMING-
---
General class structure using tables

  Class ={
    var1 = v,
    var2 = w,
    .
    .
    .
    varN = z,
    method = function(self, arguments)
      function body
    end
  }

* The model table is known as a metatable

instantiate an object in the class:

  Object = setmetatable({variables = v,w,y,z,},
    { __index = Class})

It is advisable to create a function to instantiate:

  function new( Object )
    Object = Object or {}
    setmetatable(Object ,{ __index = Class})
    return Object
  end

Instantiate:

* You can start with the values of the model (class)

  Object = new{}
  
* You can start with the eigenvalues of the object

  Object = new{var1 = v_1, var2 = w_2, ..., varN = z_N}

Use some method of the class:

  Object:method(arguments)




