# Proyecto 09 · Reingreso hospitalario en pacientes con diabetes

**Proyecto Integrador I — Maestría en Ciencia de Datos e Inteligencia Artificial, UTEC Posgrado**
Grupo 2 · Etapas 1 y 2 de CRISP-DM

Priorización del seguimiento posalta: estimar, al momento del alta, qué pacientes
diabéticos tienen mayor riesgo de reingresar antes de 30 días, para que el equipo
clínico asigne mejor una capacidad de seguimiento que es limitada.

---

## Regenerar el análisis exploratorio

### Linux y macOS

```bash
git clone https://github.com/eduardova28/Capstone_P09_Reingreso.git
cd Capstone_P09_Reingreso
python3 -m pip install -r requirements.txt
make eda
```

### Windows (PowerShell)

`make` no viene instalado en Windows. El equivalente es una sola línea:

```powershell
git clone https://github.com/eduardova28/Capstone_P09_Reingreso.git
cd Capstone_P09_Reingreso
python -m pip install -r requirements.txt
python -m nbconvert --to notebook --execute --inplace --ExecutePreprocessor.timeout=600 notebooks/02_E2_comprension_datos.ipynb
```

Cualquiera de las dos rutas ejecuta el notebook de la etapa 2 de punta a punta,
regenera las ocho figuras en `reports/figures/` y produce el informe HTML en
`reports/`.

Tiempo aproximado: 2 minutos. La única fuente de aleatoriedad es la muestra del
SPLOM, con semilla fija (`SEED = 42`), así que las cifras y figuras son idénticas
en cada ejecución.

Las dependencias se declaran con versión mínima, no clavada, para que pip instale
el binario que corresponde a cada versión de Python. Probado en 3.11, 3.12 y 3.13.
---

## Estructura

```
capstone-p09-reingreso/
├── data/
│   ├── diabetes_readmission.parquet   101 766 episodios × 50 variables
│   ├── ids_mapping.csv                diccionario de códigos administrativos
│   └── FUENTE.md                      procedencia y licencia
├── notebooks/
│   ├── 01_E1_comprension_negocio.ipynb    etapa 1 · 12 salidas documentales
│   └── 02_E2_comprension_datos.ipynb      etapa 2 · tareas 2.1 a 2.4
├── reports/
│   └── figures/                       generado por `make eda`
├── requirements.txt
├── Makefile
└── README.md
```

---

## Los datos

**Diabetes 130-US Hospitals for Years 1999–2008** — UCI Machine Learning
Repository, dataset 296. Publicado originalmente en Strack et al. (2014),
*Impact of HbA1c Measurement on Hospital Readmission Rates*, BioMed Research
International.

| | |
|---|---|
| Unidad de análisis | Episodio de hospitalización (una fila = un alta) |
| Registros | 101 766 episodios de 71 518 pacientes distintos |
| Variables | 50 |
| Periodo | 1999–2008 (el archivo no trae fecha por fila) |
| Variable objetivo | `readmitted` con tres niveles: `NO`, `>30`, `<30` |
| Prevalencia de `<30` | 11,16 % sobre el conjunto completo |

Los archivos se versionan dentro del repositorio: pesan 2,1 MB en total y así el
análisis no depende de ningún servicio externo. El equipo mantiene además una
copia en Google Drive, citada en la tarea 2.1 del notebook como procedencia; el
notebook la usa solo como respaldo si el archivo local no está presente.

---

## Decisiones que arrastra el análisis

- **Sujeto de predicción:** el episodio de alta, no el paciente.
- **Cohorte exploratoria:** se separan —no se borran— los 1 652 episodios cuyo
  destino de alta indica fallecimiento (códigos 11, 19, 20 y 21). El raw completo
  se conserva en `df_parquet`; `df_cohort` es la vista usada en figuras y hallazgos.
- **Faltantes:** no se imputa nada en la etapa 2. Se documenta el patrón y la
  decisión se toma en la etapa 3.
- **Atípicos:** se marcan con la regla del rango intercuartílico y se conservan.
  Ninguna fila se elimina.
- **Validación:** toda partición posterior debe agrupar por `patient_nbr`. El
  29,7 % de las filas son episodios repetidos del mismo paciente.
- **Raza:** se usa únicamente para auditoría de equidad, nunca como predictor.

---

## Los tres hallazgos

Calculados sobre `df_cohort` (100 114 episodios).

1. **`<30` es un resultado minoritario:** 11,34 % de los episodios. La exactitud
   queda descartada como métrica; la métrica primaria declarada es Recall@K.
2. **La ausencia de HbA1c no es ruido:** falta en el 83,14 % de los episodios, y
   quienes la tienen registrada reingresan 9,93 % frente a 11,63 % de quienes no.
   La especialista consultada lo interpreta como marcador de inicio temprano de
   insulina. Se modela como indicador de ausencia; no se imputa.
3. **Las hospitalizaciones previas ordenan el riesgo:** de 8,56 % sin ingresos
   previos a 31,24 % con cuatro o más, con gradiente monótono. Sostiene el
   baseline B2 declarado en la etapa 1.

---

## Limitaciones declaradas

El conjunto proviene de hospitales de Estados Unidos entre 1999 y 2008: otro
sistema sanitario y otra década. No incluye identificador de hospital ni fecha por
episodio, así que no se pueden analizar tendencias temporales ni diferencias entre
centros. Un reingreso en otra institución no quedaría registrado. Y `<30` es un
resultado observado, no evidencia de que el reingreso fuera evitable.

El proyecto se declara prototipo académico. No es transportable a otro contexto
sin revalidación.

---

## Equipo

Grupo 2 — Maestría en Ciencia de Datos e Inteligencia Artificial, UTEC Posgrado.

Criterio clínico aportado por una médica endocrinóloga en entrevista del 4 de
septiembre de 2026 (referenciada como E-01 en los entregables).
