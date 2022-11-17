## ---- include = FALSE-------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = ""
)

options(width = 60)

## ----cit, echo=FALSE, results='asis'----------------------
thisart <- bibentry("article",
  title = "{BibTeX} and {CFF}, a potential crosswalk",
  key = "hernangomez2022",
  author = "Diego Hernangómez",
  journal = "The {cffr} package",
  year = 2022,
  volume = "Vignettes",
)
cat("  \n")
thisart

## ----bibentry, comment="#>"-------------------------------

entry <- bibentry("book",
  key = "einstein1921",
  title = "Relativity: The Special and the General Theory",
  author = person("A.", "Einstein"),
  year = 1920,
  publisher = "Henry Holt and Company",
  address = "London, United Kingdom",
  isbn = 9781587340925,
)

toBibtex(entry)

## ----echo=FALSE, results='asis'---------------------------

entry

## ----cffbibread,comment="#>"------------------------------

string <- "@book{einstein1921,
    title        = {Relativity: The Special and the General Theory},
    author       = {Einstein, A.},
    year         = 1920,
    publisher    = {Henry Holt and Company},
    address      = {London, United Kingdom},
    isbn         = 9781587340925}"

# To cff
library(cffr)
cff_format <- cff_from_bibtex(string)

cff_format

# To citation R format and bibtex
citation_format <- cff_to_bibtex(cff_format)
class(citation_format)
citation_format

toBibtex(citation_format)

## ----entry_fields1, echo=FALSE----------------------------

bibtex_field_entry <- read.csv(
  system.file("extdata/bibtex_field_entry.csv",
    package = "cffr"
  ),
  sep = ","
)

t1 <- bibtex_field_entry[, c(1:7)]

knitr::kable(t1,
  col.names = gsub("\\.", ",", names(t1)),
  align = c("l", rep("c", 6)),
  caption = "BibTeX, required fields by entry"
)

## ----entry_fields2, echo=FALSE----------------------------
t2 <- bibtex_field_entry[, c(1, 8:13)]

knitr::kable(t2,
  col.names = gsub("\\.", ",", names(t2)),
  align = c("l", rep("c", 6)),
  caption = "(cont) BibTeX, required fields by entry"
)

## ----refkeys, echo=FALSE, message=FALSE, warning=FALSE, results='asis'----
library(cffr)

# Fill with whites
l <- c(cff_schema_definitions_refs(), rep("", 4))


refkeys <- matrix(l, ncol = 5, byrow = TRUE)

knitr::kable(refkeys,
  caption = "Valid keys on CFF `definition-reference` objects"
)

## ----echo=FALSE-------------------------------------------

bib <- "@article{article-full,
    title        = {The Gnats and Gnus Document Preparation System},
    author       = {Leslie A. Aamport},
    year         = 1986,
    month        = jul,
    journal      = {{G-Animal's} Journal},
    volume       = 41,
    number       = 7,
    pages        = {73+},
    note         = {This is a full ARTICLE entry}}"

cff_from_bibtex(bib)

## ----echo=FALSE-------------------------------------------
toBibtex(cff_to_bibtex(cff_from_bibtex(bib)))

## ----echo=FALSE-------------------------------------------

bib <- "@book{book-full,
    title        = {Seminumerical Algorithms},
    author       = {Donald E. Knuth},
    year         = 1981,
    month        = 10,
    publisher    = {Addison-Wesley},
    address      = {Reading, Massachusetts},
    series       = {The Art of Computer Programming},
    volume       = 2,
    note         = {This is a full BOOK entry},
    edition      = {Second}
}"

cff_from_bibtex(bib)

## ----  echo=FALSE-----------------------------------------
toBibtex(cff_to_bibtex(cff_from_bibtex(bib)))

## ----echo=FALSE-------------------------------------------

bib <- "@inbook{inbook-full,
    title        = {Fundamental Algorithms},
    author       = {Donald E. Knuth},
    year         = 1973,
    month        = 10,
    publisher    = {Addison-Wesley},
    address      = {Reading, Massachusetts},
    series       = {The Art of Computer Programming},
    volume       = 1,
    pages        = {10--119},
    note         = {This is a full INBOOK entry},
    edition      = {Second},
    type         = {Section},
    chapter      = {1.2}
}"

cff_from_bibtex(bib)

## ----echo=FALSE-------------------------------------------
toBibtex(cff_to_bibtex(cff_from_bibtex(bib)))

## ----echo=FALSE-------------------------------------------

bib <- "@booklet{booklet-full,
    title        = {The Programming of Computer Art},
    author       = {Jill C. Knvth},
    date         = {1988-03-14},
    month        = feb,
    address      = {Stanford, California},
    note         = {This is a full BOOKLET entry},
    howpublished = {Vernier Art Center}
}"

cff_from_bibtex(bib)

## ----echo=FALSE-------------------------------------------
toBibtex(cff_to_bibtex(cff_from_bibtex(bib)))

## ----echo=FALSE-------------------------------------------

bib <- "@inproceedings{inproceedings-full,
    title        = {On Notions of Information Transfer in {VLSI} Circuits},
    author       = {Alfred V. Oaho and Jeffrey D. Ullman and Mihalis Yannakakis},
    year         = 1983,
    month        = mar,
    booktitle    = {Proc. Fifteenth Annual ACM Symposium on the Theory of Computing},
    publisher    = {Academic Press},
    address      = {Boston},
    series       = {All ACM Conferences},
    number       = 17,
    pages        = {133--139},
    editor       = {Wizard V. Oz and Mihalis Yannakakis},
    organization = {The OX Association for Computing Machinery}
}"

cff_from_bibtex(bib)

## ----echo=FALSE-------------------------------------------
toBibtex(cff_to_bibtex(cff_from_bibtex(bib)))

## ----echo=FALSE-------------------------------------------

bib <- "@incollection{incollection-full,
    title        = {Semigroups of Recurrences},
    author       = {Daniel D. Lincoll},
    year         = 1977,
    month        = sep,
    booktitle    = {High Speed Computer and Algorithm Organization},
    publisher    = {Academic Press},
    address      = {New York},
    series       = {Fast Computers},
    number       = 23,
    pages        = {179--183},
    note         = {This is a full INCOLLECTION entry},
    editor       = {David J. Lipcoll and D. H. Lawrie and A. H. Sameh},
    chapter      = 3,
    type         = {Part},
    edition      = {Third}
}"

cff_from_bibtex(bib)

## ----echo=FALSE-------------------------------------------
toBibtex(cff_to_bibtex(cff_from_bibtex(bib)))

## ----echo=FALSE-------------------------------------------

bib <- "@manual{manual-full,
  title        = {The Definitive Computer Manual},
    author       = {Larry Manmaker},
    year         = 1986,
    month        = {apr-may},
    address      = {Silicon Valley},
    note         = {This is a full MANUAL entry},
    organization = {Chips-R-Us},
    edition      = {Silver}
}"

cff_from_bibtex(bib)

## ----echo=FALSE-------------------------------------------
toBibtex(cff_to_bibtex(cff_from_bibtex(bib)))

## ----echo=FALSE-------------------------------------------

bib <- "@mastersthesis{mastersthesis-full,
    title        = {Mastering Thesis Writing},
    author       = {Edouard Masterly},
    year         = 1988,
    month        = jun,
    address      = {English Department},
    note         = {This is a full MASTERSTHESIS entry},
    school       = {Stanford University},
    type         = {Master's project}
}"

cff_from_bibtex(bib)

## ----  echo=FALSE-----------------------------------------
toBibtex(cff_to_bibtex(cff_from_bibtex(bib)))

## ----echo=FALSE-------------------------------------------

bib <- "@phdthesis{phdthesis-full,
    title        = {Fighting Fire with Fire: Festooning {F}rench Phrases},
    author       = {F. Phidias Phony-Baloney},
    year         = 1988,
    month        = jun,
    address      = {Department of French},
    note         = {This is a full PHDTHESIS entry},
    school       = {Fanstord University},
    type         = {{PhD} Dissertation}
}"

cff_from_bibtex(bib)

## ----echo=FALSE-------------------------------------------
toBibtex(cff_to_bibtex(cff_from_bibtex(bib)))

## ----echo=FALSE-------------------------------------------

bib <- "@misc{misc-full,
    title        = {Handing out random pamphlets in airports},
    author       = {Joe-Bob Missilany},
    year         = 1984,
    month        = oct,
    note         = {This is a full MISC entry},
    howpublished = {Handed out at O'Hare}
}"

cff_from_bibtex(bib)

## ----echo=FALSE-------------------------------------------
toBibtex(cff_to_bibtex(cff_from_bibtex(bib)))

## ----echo=FALSE-------------------------------------------

bib <- "@proceedings{proceedings-full,
    title        = {Proc. Fifteenth Annual ACM Symposium on the Theory of Computing},
    year         = 1983,
    month        = mar,
    publisher    = {Academic Press},
    address      = {Boston},
    series       = {All ACM Conferences},
    number       = 17,
    note         = {This is a full PROCEEDINGS entry},
    editor       = {Wizard V. Oz and Mihalis Yannakakis},
    organization = {The OX Association for Computing Machinery}
}"

cff_from_bibtex(bib)

## ----echo=FALSE-------------------------------------------
toBibtex(cff_to_bibtex(cff_from_bibtex(bib)))

## ----echo=FALSE-------------------------------------------

bib <- "@techreport{techreport-full,
    title        = {A Sorting Algorithm},
    author       = {Tom Terrific},
    year         = 1988,
    month        = oct,
    address      = {Computer Science Department, Fanstord, California},
    number       = 7,
    note         = {This is a full TECHREPORT entry},
    institution  = {Fanstord University},
    type         = {Wishful Research Result}
}"

cff_from_bibtex(bib)

## ----echo=FALSE-------------------------------------------
toBibtex(cff_to_bibtex(cff_from_bibtex(bib)))

## ----echo=FALSE-------------------------------------------

bib <- "@unpublished{unpublished-minimal,
    title        = {Lower Bounds for Wishful Research Results},
    author       = {Ulrich Underwood and Ned Net and Paul Pot},
    note         = {Talk at Fanstord University (this is a minimal UNPUBLISHED entry)}
}"

cff_from_bibtex(bib)

## ----echo=FALSE-------------------------------------------
toBibtex(cff_to_bibtex(cff_from_bibtex(bib)))

