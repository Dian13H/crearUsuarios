# Scripts para crear usuarios

Tres scripts para crear usuarios de forma interactiva en GNU/Linux con funciones diferentes: 

## usuarios0.sh
Este script solicita los datos necesarios para crear el usuario, valida que la contraseña cumpla con reglas específicas para que sea una contraseña segura y configura el usuario correctamente.

## usuarios1.sh
Al igual que en el script usuarios0.sh, crea el usuario de forma interactiva y se agrega la opción de asignar cuotas con límites hard y soft al usuario.

## usuarios2.sh
Usa como base el script usuarios1.sh y agrega la opción de pedir si el usuario puede ejecutar comandos con sudo, qué comandos y se configure para que pueda realizarse.

## Requisitos

- Ejecutar el script con permisos de superusuario (`root` o `sudo`).
- Sistema operativo Linux.

---

## Descarga y uso

1. Clona el repositorio o descarga el script.
2. Haz que el script sea ejecutable:

   ```bash
   chmod +x usuarios#.sh
   ```

3. Ejecuta el script:

   ```bash
   sudo ./usuarios#.sh
   ```

4. Sigue las instrucciones en pantalla para ingresar los datos del usuario.

---

## Funcionalidades

### 1. **Solicitud de datos**
El script solicita la siguiente información:
- Nombre del usuario
- Comentario o descripción del usuario
- Nombre del grupo (si no existe, se crea automáticamente)
- Directorio home (por defecto, `/home/<nombre_usuario>`)
- Shell por defecto (por ejemplo, `/bin/bash`)

### 2. **Creación del grupo**
Si el grupo especificado no existe, el script lo crea automáticamente usando el comando `groupadd`.

### 3. **Creación del usuario**
El script utiliza el comando `useradd` para crear el usuario con los datos proporcionados.

### 4. **Validación de contraseña segura**
El script valida que la contraseña cumpla con las siguientes reglas:
- Mínimo 8 caracteres
- Al menos una letra mayúscula
- Al menos una letra minúscula
- Al menos un número
- Al menos un carácter especial (`@`, `#`, `$`, `%`, `^`, `&`, `+`, `=`)

### 5. **Asignación de contraseña**
Si la contraseña es válida, se asigna al usuario usando el comando `chpasswd`.

### 6. **Mensajes de confirmación**
El script muestra mensajes de confirmación o error en cada paso del proceso.

---

## Ejemplo de Uso

```bash
$ sudo ./crear_usuario.sh
Ingrese el nombre del usuario: DarthVader
Ingrese el comentario del usuario: The chosen one
Ingrese el nombre del grupo: Sith
Ingrese el directorio home (ej. /home/juan): /home/darthvader
Ingrese el shell por defecto (ej. /bin/bash): /bin/bash
El grupo Sith no existe, se creará el grupo
Usuario DarthVader creado
Ingrese la contraseña para el usuario DarthVader: 
Contraseña asignada al usuario DarthVader
Usuario DarthVader configurado correctamente
```

---

## Notas

- **Permisos de Superusuario**: El script debe ejecutarse con permisos de superusuario para crear usuarios y grupos.
- **Validación de Contraseña**: Si la contraseña no cumple con las reglas, el script solicitará que se ingrese nuevamente.
- **Compatibilidad**: Probado en distribuciones basadas en Debian/Ubuntu.

---

## Contribuciones

Las contribuciones son bienvenidas. Si tienes mejoras o correcciones, por favor crea un pull request o abre un issue.
