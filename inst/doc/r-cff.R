## -----------------------------------------------------------------------------
#| include: false
library(cffr)


## -----------------------------------------------------------------------------
#| label: tbl-summary
#| echo: false
#| tbl-cap: "cffr and R packages: Conversion table"
keys <- cff_schema_keys(sorted = TRUE)
origin <- vector(length = length(keys))
origin[keys == "cff-version"] <- "function argument"
origin[keys == "type"] <- "Fixed value: 'software'"
origin[keys == "identifiers"] <- "DESCRIPTION and inst/CITATION"
origin[keys == "references"] <- "DESCRIPTION and inst/CITATION"

origin[
  keys %in%
    c(
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
    )
] <- "DESCRIPTION file"

origin[
  keys %in%
    c(
      "doi",
      "preferred-citation"
    )
] <- "inst/CITATION"

origin[origin == "FALSE"] <- "Ignored by cffr"

df <- data.frame(
  key = paste0("<a href='#", keys, "'>", keys, "</a>"),
  source = origin
)

knitr::kable(df, escape = FALSE)


## -----------------------------------------------------------------------------
#| label: abstract
library(cffr)

# Create a `cff` object for YAML.

cff_obj <- cff_create("rmarkdown")

# Get the DESCRIPTION of **rmarkdown** to check.

pkg <- desc::desc(file.path(find.package("rmarkdown"), "DESCRIPTION"))

cat(cff_obj$abstract)

cat(pkg$get("Description"))


## -----------------------------------------------------------------------------
#| label: authors
# An example DESCRIPTION.
path <- system.file("examples/DESCRIPTION_many_persons", package = "cffr")
pkg <- desc::desc(path)

# See the listed persons.
pkg$get_authors()

# Default behavior: use authors and creators (maintainers).
cff_obj <- cff_create(path)
cff_obj$authors

# Use copyright holders and maintainers.
cff_obj_alt <- cff_create(path, authors_roles = c("cre", "cph"))
cff_obj_alt$authors


## -----------------------------------------------------------------------------
#| label: cffversion
cff_objv110 <- cff_create("jsonlite", cff_version = "v1.1.0")

cat(cff_objv110$`cff-version`)


## -----------------------------------------------------------------------------
#| label: commit
# An example DESCRIPTION.
path <- system.file("examples/DESCRIPTION_r_universe", package = "cffr")
pkg <- desc::desc(path)

# See `RemoteSha`.
pkg$get("RemoteSha")

cff_read(path)


## -----------------------------------------------------------------------------
#| label: contact
cff_obj <- cff_create("rmarkdown")
pkg <- desc::desc(file.path(find.package("rmarkdown"), "DESCRIPTION"))

cff_obj$contact

pkg$get_author()


## -----------------------------------------------------------------------------
#| label: date-released
# Use an installed package.

cff_obj <- cff_create("rmarkdown")
pkg <- desc::desc(file.path(find.package("rmarkdown"), "DESCRIPTION"))

cat(pkg$get("Date/Publication"))

cat(cff_obj$`date-released`)

# A DESCRIPTION file without a `Date`.
nodate <- system.file("examples/DESCRIPTION_basic", package = "cffr")
tmp <- tempfile("DESCRIPTION")

# Create a temporary file.
file.copy(nodate, tmp)

pkgnodate <- desc::desc(tmp)
cffnodate <- cff_create(tmp)

# No value is returned.
cat(cffnodate$`date-released`)

pkgnodate

# Add a `Date`.

desc::desc_set("Date", "1999-01-01", file = tmp)

cat(cff_create(tmp)$`date-released`)


## -----------------------------------------------------------------------------
#| label: doi
cff_doi <- cff_create("cffr")

cat(cff_doi$doi)

cat(cff_doi$`preferred-citation`$doi)


## -----------------------------------------------------------------------------
#| label: identifiers
file <- system.file("examples/DESCRIPTION_many_urls", package = "cffr")

pkg <- desc::desc(file)

cat(pkg$get_urls())

cat(cff_create(file)$url)

cat(cff_create(file)$`repository-code`)

cff_create(file)$identifiers


## -----------------------------------------------------------------------------
#| label: keyword
# A DESCRIPTION file without keywords
nokeywords <- system.file("examples/DESCRIPTION_basic", package = "cffr")
tmp2 <- tempfile("DESCRIPTION")

# Create a temporary file.
file.copy(nokeywords, tmp2)

pkgnokeywords <- desc::desc(tmp2)
cffnokeywords <- cff_create(tmp2)

# No value is returned.
cat(cffnokeywords$keywords)

pkgnokeywords

# Add keywords.

desc::desc_set(
  "X-schema.org-keywords",
  "keyword1, keyword2, keyword3",
  file = tmp2
)

cat(cff_create(tmp2)$keywords)


## -----------------------------------------------------------------------------
#| label: ghkeyword
# Get a `cff` object from **jsonvalidate**.

jsonval <- cff_create("jsonvalidate")

# Keywords are retrieved from the GitHub repository.

jsonval

# Check keywords.
jsonval$keywords

# The repository.
jsonval$`repository-code`


## -----------------------------------------------------------------------------
#| label: license
cff_obj <- cff_create("yaml")

cat(cff_obj$license)

pkg <- desc::desc(file.path(find.package("yaml"), "DESCRIPTION"))

cat(pkg$get("License"))


## -----------------------------------------------------------------------------
#| eval: false
#| code-fold: false
# msg <- paste0(
#   'To cite package "',
#   "NAME_OF_THE_PACKAGE",
#   '" in publications use:'
# )


## -----------------------------------------------------------------------------
#| label: message
cat(cff_create("jsonlite")$message)


## -----------------------------------------------------------------------------
#| label: preferred-citation
cffobj <- cff_create("rmarkdown")

cffobj$`preferred-citation`

citation("rmarkdown")[1]


## -----------------------------------------------------------------------------
#| label: references
cffobj <- cff_create("rmarkdown")

cffobj$references

citation("rmarkdown")[-1]


## -----------------------------------------------------------------------------
#| label: repository
# Use an installed package.

inst <- cff_create("jsonlite")

cat(inst$repository)

# Demo file downloaded from the r-universe.

runiv <- system.file("examples/DESCRIPTION_r_universe", package = "cffr")
runiv_cff <- cff_create(runiv)

cat(runiv_cff$repository)

desc::desc(runiv)$get("Repository")

# For an in-development package.

norepo <- system.file("examples/DESCRIPTION_basic", package = "cffr")

# No repository is available.
norepo_cff <- cff_create(norepo)

cat(norepo_cff[["repository"]])

# Change the name to a known package on CRAN: ggplot2.

tmp <- tempfile("DESCRIPTION")
file.copy(norepo, tmp)

# Change the package name.
desc::desc_set("Package", "ggplot2", file = tmp)

cat(cff_create(tmp)[["repository"]])


## -----------------------------------------------------------------------------
#| label: repository-code
# Installed package on GitHub.

cat(cff_create("jsonlite")$`repository-code`)

# GitLab

gitlab <- system.file("examples/DESCRIPTION_gitlab", package = "cffr")

cat(cff_create(gitlab)$`repository-code`)

# Codeberg
codeberg <- system.file("examples/DESCRIPTION_codeberg", package = "cffr")

cat(cff_create(codeberg)$`repository-code`)


## -----------------------------------------------------------------------------
#| eval: false
#| code-fold: false
# title <- paste0("NAME_OF_THE_PACKAGE", ": ", "TITLE_OF_THE_PACKAGE")


## -----------------------------------------------------------------------------
#| label: title
# Use an installed package.

cat(cff_create("testthat")$title)


## -----------------------------------------------------------------------------
#| label: url
# Many URLs.
manyurls <- system.file("examples/DESCRIPTION_many_urls", package = "cffr")

cat(cff_create(manyurls)$url)

# Check the source metadata.

desc::desc(manyurls)


## -----------------------------------------------------------------------------
#| label: version
#| code-fold: false
# Should be (>= 3.0.0).
cat(cff_create("testthat")$version)

