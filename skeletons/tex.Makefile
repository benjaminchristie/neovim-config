CC = latexmk
CFLAGS = -pdf -silent

main.pdf: main.tex
	$(CC) $(CFLAGS) $<

clean:
	rm -f main.[!tex]*
