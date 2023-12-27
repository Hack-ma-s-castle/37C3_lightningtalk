all: pdf

.PHONY: html pdf ppt view server

SOURCE := 37C3_lightningtalk_håck-mas-castle.md
GENERATOR := marp
#GENERATOR := npx @marp-team/marp-cli@latest

html: $(SOURCE)
	$(GENERATOR) $<

pdf: $(SOURCE)
	$(GENERATOR) $< --pdf --allow-local-files

ppt: $(SOURCE)
	$(GENERATOR) $< --pptx

view: $(SOURCE)
	$(GENERATOR) -w $<

server: html
	$(GENERATOR) -s ./slides

gitadd: $(SOURCE)
	echo "git adding all images used in markdown source"
	rg --no-filename -N -o -e '\]\(([^)]+)\)' --replace='$$1' $< | xargs -d '\n' git add -v
	echo "git adding all css assets"
	rg --no-filename -N -o -e "url\('([^']+)'\)" --replace='$$1' $< | xargs -d '\n' git add -v
	rg --no-filename -N -o -e 'url\("([^"]+)"\)' --replace='$$1' $< | xargs -d '\n' git add -v

