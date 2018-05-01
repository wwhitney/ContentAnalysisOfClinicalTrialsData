#target: [dependency]
#<tab>recipe
ipynb:
	notedown --from markdown --to notebook ClinicalTrials.md > ClinicalTrials.ipynb
ppt:
	pandoc -s ClinicalTrials.md --to pptx --toc --reference-doc=ppt/depth.pptx -o ClinicalTrials.pptx
pdf:
	pandoc -s ClinicalTrials.md --to beamer -V theme:Copenhagen -o ClinicalTrials.pdf
doc:
	pandoc -s ClinicalTrials.md --to docx --reference-doc=style.docx -o ClinicalTrials.docx
slidy:
	pandoc -s ClinicalTrials.md --to slidy --self-contained -V theme=moon -o ClinicalTrials.html
dzslides:
	pandoc -s ClinicalTrials.md --to dzslides --self-contained -V theme=moon -o ClinicalTrials.html
s5:
	pandoc -s ClinicalTrials.md --to s5 --self-contained -V theme=moon -o ClinicalTrials.html
revealjs:
	pandoc -s ClinicalTrials.md --to revealjs --self-contained -V theme=moon -o ClinicalTrials.html
slideous:
	pandoc -s ClinicalTrials.md --to slideous --self-contained -V theme=moon -o ClinicalTrials.html
