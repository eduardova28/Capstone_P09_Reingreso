# Cómo publicar este repositorio

## 1. Crear el repositorio vacío en GitHub

En github.com → New repository:
- Nombre: `capstone-p09-reingreso`
- Visibilidad: **Público** (si es privado, hay que invitar al profesor y es un punto de falla)
- **No** marcar "Add a README" ni ".gitignore" — ya vienen en esta carpeta

## 2. Subir esta carpeta

Desde la carpeta del proyecto, en la terminal:

```bash
git init
git add .
git commit -m "E1 y E2 de CRISP-DM: comprension del negocio y de los datos"
git branch -M main
git remote add origin https://github.com/USUARIO/capstone-p09-reingreso.git
git push -u origin main
```

Reemplazar `USUARIO` por el usuario de GitHub.

## 3. Verificar antes de entregar

Simular lo que hará el profesor, en una carpeta distinta:

```bash
cd /tmp
git clone https://github.com/USUARIO/capstone-p09-reingreso.git
cd capstone-p09-reingreso
pip install -r requirements.txt
make eda
```

Si termina sin error y aparecen las ocho figuras en `reports/figures/`, el bloque 9 cierra.

## 4. Lo que va en el one-pager

- **Bloque 9 · URL:** `https://github.com/USUARIO/capstone-p09-reingreso`
- **Bloque 9 · Instrucción única:** `make eda`

## Nota sobre los datos

Los dos archivos de `data/` pesan 2,1 MB en total y se versionan con el código.
GitHub admite hasta 100 MB por archivo, así que no hace falta Git LFS ni DVC en
esta etapa. DVC entra en la sesión S03, cuando se versione la preparación de datos.
