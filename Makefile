# Proyecto 09 · Reingreso hospitalario — Grupo 2, UTEC
# Comando único para regenerar el análisis exploratorio:  make eda

.PHONY: eda setup clean help

help:
	@echo "make setup   instala las dependencias"
	@echo "make eda     regenera el EDA completo (E1 + E2) y las figuras"
	@echo "make clean   borra las salidas generadas"

setup:
	pip install -r requirements.txt

eda:
	jupyter nbconvert --to notebook --execute --inplace \
		--ExecutePreprocessor.timeout=600 \
		notebooks/02_E2_comprension_datos.ipynb
	jupyter nbconvert --to html --output-dir reports \
		notebooks/02_E2_comprension_datos.ipynb
	@echo ""
	@echo "EDA regenerado."
	@echo "  Notebook ejecutado : notebooks/02_E2_comprension_datos.ipynb"
	@echo "  Informe HTML       : reports/02_E2_comprension_datos.html"
	@echo "  Figuras            : reports/figures/"

clean:
	rm -rf reports/figures/*.png reports/*.html
