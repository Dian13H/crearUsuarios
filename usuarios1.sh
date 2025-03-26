#!/usr/bin/env bash

read -rp "Ingrese el nombre del usuario: " USERNAME
read -rp "Ingrese el comentario del usuario: " COMMENT
read -rp "Ingrese el nombre del grupo: " GROUP
read -rp "Ingrese el directorio home: " HOME_DIR
read -rp "Ingrese el shell por defecto: " SHELL

HOME_DIR=${HOME_DIR:-/home/$USERNAME}
SHELL=${SHELL:-/bin/bash}

if ! grep -q "^$GROUP:" /etc/group; then
    groupadd "$GROUP"
fi

if useradd -c "$COMMENT" -d "$HOME_DIR" -m -g "$GROUP" -s "$SHELL" "$USERNAME"; then
    echo "Usuario $USERNAME creado"
else
    echo "Error al crear el usuario $USERNAME"
    exit 1
fi

while true; do
    read -rsp "Ingrese la contraseña para el usuario $USERNAME: " PASSWORD
    echo
    if [[ ${#PASSWORD} -ge 8 ]] && \
       [[ "$PASSWORD" =~ [A-Z] ]] && \
       [[ "$PASSWORD" =~ [a-z] ]] && \
       [[ "$PASSWORD" =~ [0-9] ]] && \
       [[ "$PASSWORD" =~ [@#\$%\^\&+=] ]]; then
        break
    else
        echo "Error: la contraseña debe tener al menos 8 caracteres, una mayúscula, una minúscula, un número y un carácter especial"
    fi
done

if echo "$USERNAME:$PASSWORD" | chpasswd; then
    echo "Contraseña asignada al usuario $USERNAME"
else
    echo "Error al asignar la contraseña al usuario $USERNAME"
    exit 1
fi

read -rp "¿Asignar una cuota al usuario $USERNAME? (s/n): " CUOTA
if [[ "$CUOTA" == "s" || "$CUOTA" == "S" ]]; then
    read -rp "Ingrese el límite soft de cuota (en KB): " SOFT_QUOTA
    read -rp "Ingrese el límite hard de cuota (en KB): " HARD_QUOTA

    if setquota -u "$USERNAME" "$SOFT_QUOTA" "$HARD_QUOTA" 0 0 "$HOME_DIR"; then
        echo "Cuota asignada al usuario $USERNAME: Soft=$SOFT_QUOTA KB, Hard=$HARD_QUOTA KB"
    else
        echo "Error al asignar la cuota al usuario $USERNAME"
        exit 1
    fi
else
    echo "No se asignó cuota al usuario $USERNAME"
fi

echo "Usuario $USERNAME configurado correctamente"

