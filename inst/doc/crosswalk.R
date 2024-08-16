## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

library(cffr)

## ----summary , echo=FALSE-----------------------------------------------------
keys <- cff_schema_keys(sorted = TRUE)
origin <- vector(length = length(keys))
origin[keys == "cff-version"] <- "parameter on function"
origin[keys == "type"] <- "Fixed value: 'software'"
origin[keys == "identifiers"] <- "DESCRIPTION/CITATION files"
origin[keys == "references"] <- "DESCRIPTION/CITATION files"

origin[keys %in% c(
  "message",
  "title",
  "version",
  "authors",
  "abstract",
  "repository",
  "repository-code",
  "url",
  "date-released",
  "contact",
  "keywords",
  "license",
  "commit"
)] <- "DESCRIPTION file"

origin[keys %in% c(
  "doi",
  "preferred-citation"
)] <- "CITATION file"


origin[origin == FALSE] <- "Ignored by cffr"

df <- data.frame(
  key = paste0("<a href='#", keys, "'>", keys, "</a>"),
  source = origin
)


knitr::kable(df, escape = FALSE)

## ----abstract-----------------------------------------------------------------
library(cffr)

# Create cffr for yaml

cff_obj <- cff_create("rmarkdown")

# Get DESCRIPTION of rmarkdown to check

pkg <- desc::desc(file.path(find.package("rmarkdown"), "DESCRIPTION"))

cat(cff_obj$abstract)

cat(pkg$get("Description"))

## ----authors------------------------------------------------------------------
# An example DESCRIPTION
path <- system.file("examples/DESCRIPTION_many_persons", package = "cffr")
pkg <- desc::desc(path)

# See persons listed
pkg$get_authors()


# Default behaviour, use authors and creators (maintainers)
cff_obj <- cff_create(path)
cff_obj$authors


# Use now Copyright holders and maintainers
cff_obj_alt <- cff_create(path, authors_roles = c("cre", "cph"))
cff_obj_alt$authors

## ----cffversion---------------------------------------------------------------
cff_objv110 <- cff_create("jsonlite", cff_version = "v1.1.0")

cat(cff_objv110$`cff-version`)

## ----commit-------------------------------------------------------------------
# An example DESCRIPTION
path <- system.file("examples/DESCRIPTION_r_universe", package = "cffr")
pkg <- desc::desc(path)

# See RemoteSha
pkg$get("RemoteSha")


cff_read(path)

## ----contact------------------------------------------------------------------
cff_obj <- cff_create("rmarkdown")
pkg <- desc::desc(file.path(find.package("rmarkdown"), "DESCRIPTION"))

cff_obj$contact

pkg$get_author()

## ----date-released------------------------------------------------------------
# From an installed package

cff_obj <- cff_create("rmarkdown")
pkg <- desc::desc(file.path(find.package("rmarkdown"), "DESCRIPTION"))


cat(pkg$get("Date/Publication"))


cat(cff_obj$`date-released`)



# A DESCRIPTION file without a Date
nodate <- system.file("examples/DESCRIPTION_basic", package = "cffr")
tmp <- tempfile("DESCRIPTION")

# Create a temporary file
file.copy(nodate, tmp)


pkgnodate <- desc::desc(tmp)
cffnodate <- cff_create(tmp)

# Won't appear
cat(cffnodate$`date-released`)

pkgnodate

# Adding a Date

desc::desc_set("Date", "1999-01-01", file = tmp)

cat(cff_create(tmp)$`date-released`)

## ----doi----------------------------------------------------------------------
cff_doi <- cff_create("cffr")

cat(cff_doi$doi)

cat(cff_doi$`preferred-citation`$doi)

## ----identifiers--------------------------------------------------------------
file <- system.file("examples/DESCRIPTION_many_urls", package = "cffr")

pkg <- desc::desc(file)

cat(pkg$get_urls())

cat(cff_create(file)$url)

cat(cff_create(file)$`repository-code`)

cff_create(file)$identifiers

## ----keyword------------------------------------------------------------------
# A DESCRIPTION file without keywords
nokeywords <- system.file("examples/DESCRIPTION_basic", package = "cffr")
tmp2 <- tempfile("DESCRIPTION")

# Create a temporary file
file.copy(nokeywords, tmp2)


pkgnokeywords <- desc::desc(tmp2)
cffnokeywords <- cff_create(tmp2)

# Won't appear
cat(cffnokeywords$keywords)

pkgnokeywords

# Adding Keywords

desc::desc_set("X-schema.org-keywords", "keyword1, keyword2, keyword3",
  file = tmp2
)

cat(cff_create(tmp2)$keywords)

## ----ghkeyword----------------------------------------------------------------
# Get cff object from jsonvalidate

jsonval <- cff_create("jsonvalidate")

# Keywords are retrieved from the GitHub repo

jsonval

# Check keywords
jsonval$keywords

# The repo
jsonval$`repository-code`

## ----license------------------------------------------------------------------
cff_obj <- cff_create("yaml")

cat(cff_obj$license)

pkg <- desc::desc(file.path(find.package("yaml"), "DESCRIPTION"))

cat(pkg$get("License"))

## ----eval=FALSE---------------------------------------------------------------
#  msg <- paste0(
#    'To cite package "',
#    "NAME_OF_THE_PACKAGE",
#    '" in publications use:'
#  )

## ----message------------------------------------------------------------------
cat(cff_create("jsonlite")$message)

## ----preferred-citation-------------------------------------------------------
cffobj <- cff_create("rmarkdown")

cffobj$`preferred-citation`

citation("rmarkdown")[1]

## ----references---------------------------------------------------------------
cffobj <- cff_create("rmarkdown")

cffobj$references

citation("rmarkdown")[-1]

## ----repository---------------------------------------------------------------
# Installed package

inst <- cff_create("jsonlite")

cat(inst$repository)

# Demo file downloaded from the r-universe

runiv <- system.file("examples/DESCRIPTION_r_universe", package = "cffr")
runiv_cff <- cff_create(runiv)

cat(runiv_cff$repository)

desc::desc(runiv)$get("Repository")

# For in development package

norepo <- system.file("examples/DESCRIPTION_basic", package = "cffr")

# No repo
norepo_cff <- cff_create(norepo)

cat(norepo_cff[["repository"]])

# Change the name to a known package on CRAN: ggplot2

tmp <- tempfile("DESCRIPTION")
file.copy(norepo, tmp)


# Change name
desc::desc_set("Package", "ggplot2", file = tmp)

cat(cff_create(tmp)[["repository"]])

## ----repository-code----------------------------------------------------------
# Installed package on GitHub

cff_create("jsonlite")$`repository-code`



# GitLab

gitlab <- system.file("examples/DESCRIPTION_gitlab", package = "cffr")

cat(cff_create(gitlab)$`repository-code`)


# Check

desc::desc(gitlab)

## ----eval=FALSE---------------------------------------------------------------
#  title <- paste0(
#    "NAME_OF_THE_PACKAGE",
#    ": ",
#    "TITLE_OF_THE_PACKAGE"
#  )

## ----title--------------------------------------------------------------------
# Installed package

cat(cff_create("testthat")$title)

## ----url----------------------------------------------------------------------
# Many urls
manyurls <- system.file("examples/DESCRIPTION_many_urls", package = "cffr")

cat(cff_create(manyurls)$url)

# Check

desc::desc(manyurls)

## ----version------------------------------------------------------------------
# Should be (>= 3.0.0)
cat(cff_create("testthat")$version)

