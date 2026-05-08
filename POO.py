class Persona:
    def __init__(self, nombre, edad):
        self.nombre = nombre
        self.edad = edad

    def __repr__(self):
        print(f"Nombre: {self.nombre}")
        print(f"Edad: {self.edad}")

    def set_edad(self, edad):
        self.edad = edad

    def get_edad(self):
        return self.edad


# Uso de la clase
p1 = Persona("Juan", 25)

print(p1)

p1.set_edad(30)
print("Nueva edad:", p1.get_edad())

