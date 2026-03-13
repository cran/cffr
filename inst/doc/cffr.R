## -----------------------------------------------------------------------------
#| include: false
library(cffr)


## -----------------------------------------------------------------------------
#| label: setup
#| eval: false
# library(cffr)
# 
# cff_write()
# 
# # You are done!


## -----------------------------------------------------------------------------
#| label: newfields
newobject <- cff()

newobject


## -----------------------------------------------------------------------------
#| label: validkeys
cff_schema_keys()


## -----------------------------------------------------------------------------
#| label: modify
modobject <- cff_modify(
  newobject,
  url = "https://ropensci.org/",
  version = "0.0.1",
  repository = "https://github.com/ropensci/cffr",
  # If the field is already present, it would be overridden
  title = "Modifying a 'cff' object"
)

modobject

# Validate against the schema

cff_validate(modobject)


## -----------------------------------------------------------------------------
#| label: includeauthor
# Valid person keys

cff_schema_definitions_person()

# Create the person

chiquito <- person(
  "Gregorio",
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

# To cff
chiquito_cff <- as_cff_person(chiquito)
chiquito_cff

# Append to previous authors

newauthors <- c(modobject$authors, chiquito_cff)
newauthors

newauthorobject <- cff_modify(modobject, authors = newauthors)

newauthorobject

cff_validate(newauthorobject)


## -----------------------------------------------------------------------------
#| label: parsingcits
# Valid reference keys

cff_schema_definitions_refs()

# Auto coercion from another R package
base_r <- citation("base")

bib <- bibentry(
  "Book",
  title = "This is a book",
  author = "Lisa Lee",
  year = 1980,
  publisher = "McGraw Hill",
  volume = 2
)

refs <- c(base_r, bib)

refs

# Now to cff

refs_cff <- as_cff(refs)

refs_cff


## -----------------------------------------------------------------------------
#| label: references
finalobject <- cff_modify(newauthorobject, references = refs_cff)

finalobject

cff_validate(finalobject)


## -----------------------------------------------------------------------------
#| label: write
# For example
tmp <- tempfile(fileext = ".cff")

see_res <- cff_write(finalobject, outfile = tmp)

cat(readLines(tmp), sep = "\n")


## -----------------------------------------------------------------------------
#| label: read
reading <- cff_read(tmp)

reading


## -----------------------------------------------------------------------------
allkeys <- list(
  "url" = "https://ropensci.org/",
  "version" = "0.0.1",
  "repository" = "https://github.com/ropensci/cffr",
  # If the field is already present, it would be overridden
  title = "Modifying a 'cff' object",
  authors = newauthors,
  references = refs_cff
)

tmp2 <- tempfile(fileext = ".cff")

res <- cff_write(cff(), outfile = tmp2, keys = allkeys)

res


## -----------------------------------------------------------------------------
#| include: false
# Clean temps
unlink(tmp)
unlink(tmp2)

