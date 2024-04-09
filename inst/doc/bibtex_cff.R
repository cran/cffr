## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = ""
)

# Load the table of tables

p2file <- system.file("extdata/crosswalk_tables.csv", package = "cffr")

table_master <- read.csv(p2file)

## ----bibentry, comment="#>"---------------------------------------------------
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

## ----echo=FALSE, results='asis'-----------------------------------------------
entry

## ----cffbibread, comment="#>"-------------------------------------------------
string <- "@book{einstein1921,
    title        = {Relativity: The Special and the General Theory},
    author       = {Einstein, A.},
    year         = 1920,
    publisher    = {Henry Holt and Company},
    address      = {London, United Kingdom},
    isbn         = 9781587340925}"

# To cff
library(cffr)
cff_format <- cff_read_bib_text(string)

cff_format

# To BibTeX with S3 method
toBibtex(cff_format)

## ----entry_fields1, echo=FALSE------------------------------------------------
df_table <- table_master[table_master$table == "entry_fields", -1]

nms <- c(
  "**field**", "**\\@article**", "**\\@book**", "**\\@booklet**",
  "**\\@inbook**", "**\\@incollection**", "**\\@conference, \\@inproceedings**",
  "**\\@manual**", "**\\@mastersthesis, phdthesis**", "**\\@misc**",
  "**\\@proceedings**", "**\\@techreport**", "**\\@unpublished**"
)


df_table[is.na(df_table)] <- ""
row.names(df_table) <- NULL
t1 <- df_table[, c(1:7)]
nm1 <- nms[1:7]

knitr::kable(t1,
  col.names = nm1, row.names = NA, align = c("l", rep("c", 6)),
  caption = "**BibTeX**, required fields by entry"
)

## ----entry_fields2, echo=FALSE------------------------------------------------
t2 <- df_table[, c(1, 8:13)]
nm2 <- nms[c(1, 8:13)]
knitr::kable(t2,
  col.names = nm2, row.names = NA, align = c("l", rep("c", 6)),
  caption = "(cont) **BibTeX**, required fields by entry"
)

## ----refkeys, echo=FALSE, message=FALSE, warning=FALSE, results='asis'--------
library(cffr)

# Fill with whites
init <- paste0("[", cff_schema_definitions_refs(), "]{.underline}")

l <- c(init, rep("", 4))


refkeys <- matrix(l, ncol = 5, byrow = TRUE)

knitr::kable(refkeys,
  row.names = NA,
  caption = "Valid keys on [CFF]{underline} `definition-reference` objects"
)

## ----entry_bib2cff, echo=FALSE, results='asis'--------------------------------
df_table <- table_master[table_master$table == "entry_bib2cff", c(2:4)]
df_table[is.na(df_table)] <- ""
# fix links
df_table$f3 <- gsub("link_to_entry_models", "#entrymodels", df_table$f3)
row.names(df_table) <- NULL

knitr::kable(df_table,
  col.names = c("**BibTeX** Entry", "[**CFF key: type**]{.underline}", "Notes"),
  row.names = NA,
  caption = "Entry/Type crosswalk: From **BibTeX** to [CFF]{.underline}"
)

## ----entry_cff2bib, echo=FALSE,results='asis'---------------------------------
df_table <- table_master[table_master$table == "entry_cff2bib", c(2:4)]
df_table[is.na(df_table)] <- ""
# fix links
df_table$f3 <- gsub("link_to_entry_models", "#entrymodels", df_table$f3)
row.names(df_table) <- NULL

knitr::kable(df_table,
  col.names = c("[**CFF key: type**]{.underline}", "**BibTeX** Entry", "Notes"),
  caption = "Entry/Type crosswalk: From [CFF]{.underline} to **BibTeX**"
)

## ----fields_bib2cff, echo=FALSE,results='asis'--------------------------------
df_table <- table_master[table_master$table == "fields_bib2cff", c(2:4)]
df_table[is.na(df_table)] <- ""
# fix links
df_table$f3 <- gsub("link_to_entry_models", "#entrymodels", df_table$f3)
row.names(df_table) <- NULL

knitr::kable(df_table,
  col.names = c("**BibTeX Field**", "[CFF key]{.underline}", "Notes"),
  caption = "**BibTeX** - [CFF]{.underline} Field/Key crosswalk"
)

## ----fields_biblatex2cff, echo=FALSE,results='asis'---------------------------
df_table <- table_master[table_master$table == "fields_biblatex2cff", c(2:3)]
df_table[is.na(df_table)] <- ""
# fix links
df_table$f2 <- gsub("link_to_entry_models", "#entrymodels", df_table$f2)
row.names(df_table) <- NULL

knitr::kable(df_table,
  col.names = c("**BibLaTeX Field**", "[CFF key]{.underline}"),
  caption = "**BibLaTeX** - [CFF]{.underline} Field/Key crosswalk"
)

## ----model_article, echo=FALSE, results='asis'--------------------------------
df_table <- table_master[table_master$table == "model_article", c(2:4)]
df_table[is.na(df_table)] <- ""

# fix links
df_table$f3 <- gsub("link_to_entry_models", "#entrymodels", df_table$f3)
df_table$f3 <- gsub("link_to_article", "#article", df_table$f3)
df_table$f3 <- gsub("link_to_booklet", "#booklet", df_table$f3)
df_table$f3 <- gsub("link_to_book", "#book-inbook", df_table$f3)

row.names(df_table) <- NULL
knitr::kable(df_table,
  col.names = c("**BibTeX**", "[CFF]{.underline}", "Notes"),
  caption = "**\\@article** Model"
)

## ----echo=FALSE---------------------------------------------------------------
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

cff_read_bib_text(bib)

## ----echo=FALSE---------------------------------------------------------------
toBibtex(cff_read_bib_text(bib))

## ----model_book, echo=FALSE, results='asis'-----------------------------------
df_table <- table_master[table_master$table == "model_book", c(2:4)]
df_table[is.na(df_table)] <- ""

# fix links
df_table$f3 <- gsub("link_to_entry_models", "#entrymodels", df_table$f3)
df_table$f3 <- gsub("link_to_article", "#article", df_table$f3)
df_table$f3 <- gsub("link_to_booklet", "#booklet", df_table$f3)
df_table$f3 <- gsub("link_to_book", "#book-inbook", df_table$f3)

row.names(df_table) <- NULL
knitr::kable(df_table,
  col.names = c("**BibTeX**", "[CFF]{.underline}", "Notes"),
  caption = "**\\@book / \\@inbook** Model"
)

## ----echo=FALSE---------------------------------------------------------------
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

cff_read_bib_text(bib)

## ----echo=FALSE---------------------------------------------------------------
toBibtex(cff_read_bib_text(bib))

## ----echo=FALSE---------------------------------------------------------------
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

cff_read_bib_text(bib)

## ----echo=FALSE---------------------------------------------------------------
toBibtex(cff_read_bib_text(bib))

## ----model_booklet, echo=FALSE, results='asis'--------------------------------
df_table <- table_master[table_master$table == "model_booklet", c(2:4)]
df_table[is.na(df_table)] <- ""

# fix links
df_table$f3 <- gsub("link_to_entry_models", "#entrymodels", df_table$f3)
df_table$f3 <- gsub("link_to_article", "#article", df_table$f3)
df_table$f3 <- gsub("link_to_booklet", "#booklet", df_table$f3)
df_table$f3 <- gsub("link_to_book", "#book-inbook", df_table$f3)

row.names(df_table) <- NULL
knitr::kable(df_table,
  col.names = c("**BibTeX**", "[CFF]{.underline}", "Notes"),
  caption = "**\\@booklet** Model"
)

## ----echo=FALSE---------------------------------------------------------------
bib <- "@booklet{booklet-full,
    title        = {The Programming of Computer Art},
    author       = {Jill C. Knvth},
    date         = {1988-03-14},
    month        = feb,
    address      = {Stanford, California},
    note         = {This is a full BOOKLET entry},
    howpublished = {Vernier Art Center}
}"

cff_read_bib_text(bib)

## ----echo=FALSE---------------------------------------------------------------
toBibtex(cff_read_bib_text(bib))

## ----model_inproceedings, echo=FALSE, results='asis'--------------------------
df_table <- table_master[table_master$table == "model_inproceedings", c(2:4)]
df_table[is.na(df_table)] <- ""

# fix links
df_table$f3 <- gsub("link_to_entry_models", "#entrymodels", df_table$f3)
df_table$f3 <- gsub("link_to_article", "#article", df_table$f3)
df_table$f3 <- gsub("link_to_booklet", "#booklet", df_table$f3)
df_table$f3 <- gsub("link_to_book", "#book-inbook", df_table$f3)

row.names(df_table) <- NULL
knitr::kable(df_table,
  col.names = c("**BibTeX**", "[CFF]{.underline}", "Notes"),
  caption = "**\\@conference / \\@inproceedings** Model"
)

## ----echo=FALSE---------------------------------------------------------------
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

cff_read_bib_text(bib)

## ----echo=FALSE---------------------------------------------------------------
toBibtex(cff_read_bib_text(bib))

## ----model_incollection, echo=FALSE, results='asis'---------------------------
df_table <- table_master[table_master$table == "model_incollection", c(2:4)]
df_table[is.na(df_table)] <- ""

# fix links
df_table$f3 <- gsub("link_to_entry_models", "#entrymodels", df_table$f3)
df_table$f3 <- gsub("link_to_article", "#article", df_table$f3)
df_table$f3 <- gsub("link_to_booklet", "#booklet", df_table$f3)
df_table$f3 <- gsub("link_to_book", "#book-inbook", df_table$f3)

row.names(df_table) <- NULL
knitr::kable(df_table,
  col.names = c("**BibTeX**", "[CFF]{.underline}", "Notes"),
  caption = "**\\@incollection** Model"
)

## ----echo=FALSE---------------------------------------------------------------
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

cff_read_bib_text(bib)

## ----echo=FALSE---------------------------------------------------------------
toBibtex(cff_read_bib_text(bib))

## ----model_manual, echo=FALSE, results='asis'---------------------------------
df_table <- table_master[table_master$table == "model_manual", c(2:4)]
df_table[is.na(df_table)] <- ""

# fix links
df_table$f3 <- gsub("link_to_entry_models", "#entrymodels", df_table$f3)
df_table$f3 <- gsub("link_to_article", "#article", df_table$f3)
df_table$f3 <- gsub("link_to_booklet", "#booklet", df_table$f3)
df_table$f3 <- gsub("link_to_book", "#book-inbook", df_table$f3)

row.names(df_table) <- NULL
knitr::kable(df_table,
  col.names = c("**BibTeX**", "[CFF]{.underline}", "Notes"),
  caption = "**\\@manual** Model"
)

## ----echo=FALSE---------------------------------------------------------------
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

cff_read_bib_text(bib)

## ----echo=FALSE---------------------------------------------------------------
toBibtex(cff_read_bib_text(bib))

## ----model_thesis, echo=FALSE, results='asis'---------------------------------
df_table <- table_master[table_master$table == "model_thesis", c(2:4)]
df_table[is.na(df_table)] <- ""

# fix links
df_table$f3 <- gsub("link_to_entry_models", "#entrymodels", df_table$f3)
df_table$f3 <- gsub("link_to_article", "#article", df_table$f3)
df_table$f3 <- gsub("link_to_booklet", "#booklet", df_table$f3)
df_table$f3 <- gsub("link_to_book", "#book-inbook", df_table$f3)

row.names(df_table) <- NULL
knitr::kable(df_table,
  col.names = c("**BibTeX**", "[CFF]{.underline}", "Notes"),
  caption = "**\\@mastersthesis / \\@phdthesis** Model"
)

## ----echo=FALSE---------------------------------------------------------------
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

cff_read_bib_text(bib)

## ----echo=FALSE---------------------------------------------------------------
toBibtex(cff_read_bib_text(bib))

## ----echo=FALSE---------------------------------------------------------------
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

cff_read_bib_text(bib)

## ----echo=FALSE---------------------------------------------------------------
toBibtex(cff_read_bib_text(bib))

## ----model_misc, echo=FALSE, results='asis'-----------------------------------
df_table <- table_master[table_master$table == "model_misc", c(2:4)]
df_table[is.na(df_table)] <- ""

# fix links
df_table$f3 <- gsub("link_to_entry_models", "#entrymodels", df_table$f3)
df_table$f3 <- gsub("link_to_article", "#article", df_table$f3)
df_table$f3 <- gsub("link_to_booklet", "#booklet", df_table$f3)
df_table$f3 <- gsub("link_to_book", "#book-inbook", df_table$f3)

row.names(df_table) <- NULL
knitr::kable(df_table,
  col.names = c("**BibTeX**", "[CFF]{.underline}", "Notes"),
  caption = "**\\@misc** Model"
)

## ----echo=FALSE---------------------------------------------------------------
bib <- "@misc{misc-full,
    title        = {Handing out random pamphlets in airports},
    author       = {Joe-Bob Missilany},
    year         = 1984,
    month        = oct,
    note         = {This is a full MISC entry},
    howpublished = {Handed out at O'Hare}
}"

cff_read_bib_text(bib)

## ----echo=FALSE---------------------------------------------------------------
toBibtex(cff_read_bib_text(bib))

## ----model_proceedings, echo=FALSE, results='asis'----------------------------
df_table <- table_master[table_master$table == "model_proceedings", c(2:4)]
df_table[is.na(df_table)] <- ""

# fix links
df_table$f3 <- gsub("link_to_entry_models", "#entrymodels", df_table$f3)
df_table$f3 <- gsub("link_to_article", "#article", df_table$f3)
df_table$f3 <- gsub("link_to_booklet", "#booklet", df_table$f3)
df_table$f3 <- gsub("link_to_book", "#book-inbook", df_table$f3)

row.names(df_table) <- NULL
knitr::kable(df_table,
  col.names = c("**BibTeX**", "[CFF]{.underline}", "Notes"),
  caption = "**\\@proceedings** Model"
)

## ----echo=FALSE---------------------------------------------------------------
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

cff_read_bib_text(bib)

## ----echo=FALSE---------------------------------------------------------------
toBibtex(cff_read_bib_text(bib))

## ----model_techreport, echo=FALSE, results='asis'-----------------------------
df_table <- table_master[table_master$table == "model_techreport", c(2:4)]
df_table[is.na(df_table)] <- ""

# fix links
df_table$f3 <- gsub("link_to_entry_models", "#entrymodels", df_table$f3)
df_table$f3 <- gsub("link_to_article", "#article", df_table$f3)
df_table$f3 <- gsub("link_to_booklet", "#booklet", df_table$f3)
df_table$f3 <- gsub("link_to_book", "#book-inbook", df_table$f3)

row.names(df_table) <- NULL
knitr::kable(df_table,
  col.names = c("**BibTeX**", "[CFF]{.underline}", "Notes"),
  caption = "**\\@techreport** Model"
)

## ----echo=FALSE---------------------------------------------------------------
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

cff_read_bib_text(bib)

## ----echo=FALSE---------------------------------------------------------------
toBibtex(cff_read_bib_text(bib))

## ----model_unpublished, echo=FALSE, results='asis'----------------------------
df_table <- table_master[table_master$table == "model_unpublished", c(2:4)]
df_table[is.na(df_table)] <- ""

# fix links
df_table$f3 <- gsub("link_to_entry_models", "#entrymodels", df_table$f3)
df_table$f3 <- gsub("link_to_article", "#article", df_table$f3)
df_table$f3 <- gsub("link_to_booklet", "#booklet", df_table$f3)
df_table$f3 <- gsub("link_to_book", "#book-inbook", df_table$f3)

row.names(df_table) <- NULL
knitr::kable(df_table,
  col.names = c("**BibTeX**", "[CFF]{.underline}", "Notes"),
  caption = "**\\@unpublished** Model"
)

## ----echo=FALSE---------------------------------------------------------------
bib <- "@unpublished{unpublished-minimal,
    title        = {Lower Bounds for Wishful Research Results},
    author       = {Ulrich Underwood and Ned Net and Paul Pot},
    note         = {Talk at Fanstord University (this is a minimal UNPUBLISHED entry)}
}"

cff_read_bib_text(bib)

## ----echo=FALSE---------------------------------------------------------------
toBibtex(cff_read_bib_text(bib))

## ----echo=FALSE---------------------------------------------------------------
bib <- "@inbook{inbook-biblatex,
	author       = {Yihui Xie and Christophe Dervieux and Emily Riederer},
	title        = {Bibliographies and citations},
	booktitle    = {{R} Markdown Cookbook},
	date         = {2023-12-30},
	publisher    = {Chapman and Hall/CRC},
	address      = {Boca Raton, Florida},
	series       = {The {R} Series},
	isbn         = 9780367563837,
	url          = {https://bookdown.org/yihui/rmarkdown-cookbook},
	chapter      = {4.5}
}"

cff_read_bib_text(bib)

## ----echo=FALSE---------------------------------------------------------------
toBibtex(cff_read_bib_text(bib))

## ----cff_types, echo=FALSE, results='asis'------------------------------------
df_table <- table_master[table_master$table == "cff_types", c(2:3)]
df_table[is.na(df_table)] <- ""
row.names(df_table) <- NULL
knitr::kable(df_table,
  col.names = c("Reference type string", "Description"),
  row.names = NA,
  caption = "Complete list of [CFF]{.underline} reference types."
)

