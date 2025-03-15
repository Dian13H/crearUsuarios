# Scripts para crear usuarios

Tres scripts para crear usuarios de forma interactiva en GNU/Linux con funciones diferentes: 

## usuarios0.sh
Este script solicita los datos necesarios para crear el usuario, valida que la contraseña cumpla con reglas específicas para que sea una contraseña segura y configura el usuario correctamente.

## usuarios1.sh
Al igual que en el script usuarios0.sh, crea el usuario y se agrega la opción de asignar cuotas con límites hard y soft al usuario.

## usuarios2.sh
Usa como base el script usuarios1.sh y agrega la opción de pedir si el usuario puede ejecutar comandos con sudo, qué comandos y se configure para que pueda realizarse.

## Requisitos

- Ejecutar el script con permisos de superusuario (`root` o `sudo`).
- Sistema operativo Linux.

#### usuarios1.sh

- El sistema operativo debe soportar cuotas como `ext4`.

#### usuarios2.sh

- El comando `visudo` debe estar instalado para configurar el archivo `sudoers`.

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

## Funciones principales

### 1. **Solicitud de datos**
El script solicita la siguiente información:
- Nombre del usuario
- Comentario o descripción del usuario
- Nombre del grupo (si no existe, se crea automáticamente)
- Directorio home
- Shell por defecto

### 2. **Asignaciones por defecto**
Si no se ingresa el directorio home o el shell, se asignan por defecto:
- Directorio home: `/home/<nombre_usuario>`
- Shell por defecto: `/bin/bash`

### 3. **Creación del grupo**
Si el grupo especificado no existe, el script lo crea automáticamente usando el comando `groupadd`.

### 4. **Creación del usuario**
El script utiliza el comando `useradd` para crear el usuario con los datos proporcionados.

### 5. **Validación de contraseña segura**
El script valida que la contraseña cumpla con los siguientes requisitos:
- Mínimo 8 caracteres
- Al menos una letra mayúscula
- Al menos una letra minúscula
- Al menos un número
- Al menos un carácter especial (`@`, `#`, `$`, `%`, `^`, `&`, `+`, `=`)

### 6. **Asignación de contraseña**
Si la contraseña es válida, se asigna al usuario usando el comando `chpasswd`.

### 7. **Mensajes de confirmación**
El script muestra mensajes de confirmación o error en cada paso del proceso.

---

## Funciones adicionales

### 1. **Asignación de cuotas**
Permite asignar límites de cuota **soft** y **hard** en KB para el usuario.

### 2. **Configuración de permisos de sudo**
- Permite asignar permisos de `sudo` al usuario.
- Tiene opciones para permitir que el usuario pueda ejecutar todos los comandos o solo comandos específicos.

---

## Ejemplo de Uso

### usuarios0.sh

```bash
$ sudo ./usuarios0.sh
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
### usuarios1.sh

```bash
$ sudo ./usuarios1.sh
Ingrese el nombre del usuario: ObiWan
Ingrese el comentario del usuario: Jedi Master The Negotiator
Ingrese el nombre del grupo: Jedi
Ingrese el directorio home (ej. /home/luke): /home/kenobi
Ingrese el shell por defecto (ej. /bin/bash): /bin/bash
El grupo Jedi no existe, se creará el grupo
Usuario ObiWan creado
Ingrese la contraseña para el usuario ObiWan: 
Contraseña asignada al usuario ObiWan
¿Asignar una cuota de al usuario ObiWan? (s/n): s
Ingrese el límite soft de cuota (en KB): 102400
Ingrese el límite hard de cuota (en KB): 204800
Cuota asignada al usuario ObiWan: Soft=102400 KB, Hard=204800 KB
Usuario ObiWan configurado correctamente
```

### usuarios2.sh

```bash
$ sudo ./usuarios2.sh
Ingrese el nombre del usuario: Yoda
Ingrese el comentario del usuario: Jedi Master
Ingrese el nombre del grupo: Jedi
Ingrese el directorio home (ej. /home/yoda): /home/yoda
Ingrese el shell por defecto (ej. /bin/bash): /bin/bash
El grupo Jedi ya existe
Usuario Yoda creado
Ingrese la contraseña para el usuario Yoda: 
Contraseña asignada al usuario Yoda
¿Asignar una cuota de disco al usuario Yoda? (s/n): s
Ingrese el límite soft de cuota (en KB): 51200
Ingrese el límite hard de cuota (en KB): 102400
Cuota asignada al usuario Yoda: Soft=51200 KB, Hard=102400 KB
¿Permitir que el usuario Yoda ejecute comandos con sudo? (s/n): s
¿Permitir que se ejecuten todos los comandos con sudo? (s/n): n
Ingrese los comandos específicos (separados por comas, sin espacios): /usr/bin/apt,/usr/bin/systemctl
El usuario Yoda puede ejecutar los siguientes comandos con sudo: /usr/bin/apt,/usr/bin/systemctl
Permisos de sudo configurados correctamente para el usuario Yoda
Usuario Yoda configurado correctamente
```

---

## Notas

- **Permisos de Superusuario**: El script debe ejecutarse con permisos de superusuario para crear usuarios y grupos.
- **Validación de contraseña**: Si la contraseña no cumple con las reglas, el script solicitará que se ingrese nuevamente.
- **Compatibilidad**: Probado en distribuciones basadas en Debian/Ubuntu.

---

## Contribuciones

Las contribuciones son bienvenidas. Si tienes mejoras o correcciones, por favor crea un pull request o abre un issue.
