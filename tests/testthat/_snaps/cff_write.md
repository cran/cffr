# Add new keys

    Code
      s
    Output
      cff-version: 1.2.0
      message: This overwrites fields
      type: software
      license: GPL-3.0-only
      title: 'basicdesc: A Basic Description'
      version: 0.1.6
      abstract: New abstract
      authors:
      - family-names: Nadie
        given-names: Don
      repository-code: https://github.com/basic/package
      url: https://basic.github.io/package
      date-released: '1900-01-01'
      contact:
      - family-names: Basic
        given-names: Marc
        email: marcbasic@gmail.com
      keywords:
      - A
      - new
      - list
      - of
      - keywords

# Append keys

    Code
      desc_file
    Output
      cff-version: 1.2.0
      message: 'To cite package "basicdesc" in publications use:'
      type: software
      license: GPL-3.0-only
      title: 'basicdesc: A Basic Description'
      version: 0.1.6
      abstract: A very basic description. Should parse without problems.
      authors:
      - family-names: Basic
        given-names: Marc
        email: marcbasic@gmail.com
      repository-code: https://github.com/basic/package
      url: https://basic.github.io/package
      contact:
      - family-names: Basic
        given-names: Marc
        email: marcbasic@gmail.com

---

    Code
      s
    Output
      cff-version: 1.2.0
      message: 'To cite package "basicdesc" in publications use:'
      type: software
      license: GPL-3.0-only
      title: 'basicdesc: A Basic Description'
      version: 0.1.6
      abstract: A very basic description. Should parse without problems.
      authors:
      - family-names: Basic
        given-names: Marc
        email: marcbasic@gmail.com
      - family-names: author
        given-names: New
        website: https://stackoverflow.com/
        country: IT
      repository-code: https://github.com/basic/package
      url: https://basic.github.io/package
      contact:
      - family-names: Basic
        given-names: Marc
        email: marcbasic@gmail.com

