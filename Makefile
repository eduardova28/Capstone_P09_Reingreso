# Proyecto 09 · Reingreso hospitalario — Grupo 2, UTEC
# Comando único para regenerar el análisis exploratorio:  make eda

PYTHON ?= python3
NB = notebooks/02_E2_comprension_datos.ipynb

.PHONY: eda setup clean help

help:
	@echo "make setup   instala las dependencias"
	@echo "make eda     regenera el EDA completo y las figuras"
	@echo "make clean   borra las salidas generadas"

setup:
	$(PYTHON) -m pip install -r requirements.txt

eda:
	$(PYTHON) -m nbconvert --to notebook --execute --inplace \
		--ExecutePreprocessor.timeout=600 $(NB)
	$(PYTHON) -m nbconvert --to html --output-dir reports $(NB)
	@echo ""
	@echo "EDA regenerado."
	@echo "  Notebook ejecutado : $(NB)"
	@echo "  Informe HTML       : reports/02_E2_comprension_datos.html"
	@echo "  Figuras            : reports/figures/"

clean:
	rm -rf reports/figures/*.png reports/*.html
