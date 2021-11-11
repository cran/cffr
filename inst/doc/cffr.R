## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  warning = FALSE,
  message = TRUE
)

library(cffr)

## ----echo=FALSE, out.width="400", fig.align='center', fig.alt="GitHub-link"----
knitr::include_graphics("tweet-1.png")

## ----setup, eval=FALSE--------------------------------------------------------
#  
#  library(cffr)
#  
#  cff_write()
#  
#  # You are done!

## ----newfields----------------------------------------------------------------

newobject <- cff_create(cff())

# For modifying your auto-generated object, run this line instead:
# newoobject <- cff_create()

newobject

## ----validkeys----------------------------------------------------------------

cff_schema_keys()

## ----modify-------------------------------------------------------------------

newkeys <- list(
  "url" = "https://ropensci.org/",
  "version" = "0.0.1",
  "repository" = "https://github.com/user/repo",
  # If the field is already present, it would be overridden
  title = "Modifying a 'cff' object"
)

modobject <- cff_create(newobject, keys = newkeys)

modobject

# Validate against the schema

cff_validate(modobject)

## ----includeauthor------------------------------------------------------------

# Valid person keys

cff_schema_definitions_person()

# Create the person

chiquito <- person("Gregorio",
  "Sánchez Fernández",
  email = "fake@email2.com",
  comment = c(
    alias = "Chiquito de la Calzada",
    city = "Malaga",
    country = "ES",
    ORCID = "0000-0000-0000-0001"
  )
)

chiquito

# Parse it
chiquito_parsed <- cff_parse_person(chiquito)
chiquito_parsed


# Append to previous authors

# Needs to be append as a list
newauthors <- c(modobject$authors, list(chiquito_parsed))
newauthors

newauthorobject <- cff_create(modobject, keys = list(authors = newauthors))

newauthorobject

cff_validate(newauthorobject)

## ----parsingcits--------------------------------------------------------------
# Valid reference keys

cff_schema_definitions_refs()

# Auto parsed from another R package
base_r <- cff_parse_citation(citation("base"))

base_r

# Create with bibentry

bib <- bibentry("Book",
  title = "This is a book",
  author = "Lisa Lee",
  year = 1980,
  publisher = "McGraw Hill",
  volume = 2
)
bib

# Now parse it

bookparsed <- cff_parse_citation(bib)

bookparsed

## ----references---------------------------------------------------------------

refkeys <- list(references = c(list(base_r), list(bookparsed)))

refkeys

finalobject <- cff_create(newauthorobject, keys = refkeys)

finalobject

cff_validate(finalobject)

## ----write--------------------------------------------------------------------

# For example
tmp <- tempfile(fileext = ".cff")

see_res <- cff_write(finalobject, outfile = tmp)

see_res

## ----read---------------------------------------------------------------------

reading <- cff(tmp)

reading

## -----------------------------------------------------------------------------

allkeys <- list(
  "url" = "https://ropensci.org/",
  "version" = "0.0.1",
  "repository" = "https://github.com/user/repo",
  # If the field is already present, it would be overridden
  title = "Modifying a 'cff' object",
  authors = newauthors,
  references = c(list(base_r), list(bookparsed))
)

tmp2 <- tempfile(fileext = ".cff")

res <- cff_write(cff(), outfile = tmp2, keys = allkeys)

res

