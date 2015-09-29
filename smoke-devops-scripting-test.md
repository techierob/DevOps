
You have a list of linebreak-separated codes (see codes.txt)

Each code is of the format: ABC-DEF-GHI-JKLM-123-001

Write a script that reads the codes, and creates a directory structure based on the first four hyphen-separated components of the codes.

Create an empty file for each code at the appropriate place in the directory structure, and give it a .mov extension.

eg: ABC-DEF-GHI-JKLM-123-001 should result in:

      /DEF
        /GHI
          /JKLM
            ABC-DEF-GHI-JKLM-123-001.mov

Use an online version control repository such as Github or Bitbucket to publish your script (and any ancillary files), and email us with the URL.

