# Proyecto 09 · Reingreso hospitalario en diabetes

**Capstone Project I — UTEC · Grupo 2**

## El problema

El equipo de alta hospitalaria decide qué pacientes diabéticos necesitan
seguimiento reforzado al salir del hospital. Un reingreso antes de 30 días es
costoso, penalizado por los pagadores de salud y muchas veces evitable con una
llamada o una cita temprana. Hoy esa decisión se toma por intuición y
disponibilidad.

Los datos cubren una década (1999–2008) de hospitalizaciones de pacientes
diabéticos en 130 hospitales de Estados Unidos, publicados para investigación
clínica en el repositorio UCI. El objetivo del proyecto es un modelo de riesgo
de reingreso a 30 días que, al momento del alta, ayude al equipo clínico a
priorizar a quién se le refuerza el seguimiento.

## Fuente de los datos

Diabetes 130-US Hospitals for years 1999-2008, UCI Machine Learning
Repository, dataset 296.

Cita para el informe final:

> Strack, B., DeShazo, J. P., Gennings, C., Olmo, J. L., Ventura, S.,
> Cios, K. J., & Clore, J. N. (2014). Impact of HbA1c Measurement on Hospital
> Readmission Rates: Analysis of 70,000 Clinical Database Patient Records.
> *BioMed Research International*, 2014, 781670. Diabetes 130-US Hospitals
> for Years 1999-2008 [Dataset]. UCI Machine Learning Repository.
> https://doi.org/10.24432/C5230J

## Contenido de la carpeta

| Archivo | Filas | Columnas | Descripción |
|---|---:|---:|---|
| `diabetes_readmission.parquet` | 101,766 | 50 | Episodios hospitalarios con la variable objetivo `readmitted` |
| `ids_mapping.csv` | — | — | Diccionario de códigos de `admission_type_id`, `discharge_disposition_id` y `admission_source_id` |

## Cómo cargar los datos

Requiere `pandas` y `pyarrow`:

```bash
pip install pandas pyarrow
```

```python
import pandas as pd

df = pd.read_parquet("diabetes_readmission.parquet")
ids_mapping = pd.read_csv("ids_mapping.csv")

print(df.shape)
df.head()
```

## Reglas de uso

1. Los datos son de uso exclusivamente académico dentro del curso.
2. Está prohibida su redistribución fuera del equipo.
3. Está prohibido intentar reidentificar personas.
4. El informe final debe citar la fuente original (ver sección
   "Fuente de los datos").
