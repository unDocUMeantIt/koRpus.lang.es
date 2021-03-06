# Copyright 2010-2020 Meik Michalke <meik.michalke@hhu.de>
#
# This file is part of the R package koRpus.lang.es.
#
# koRpus.lang.es is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# koRpus.lang.es is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with koRpus.lang.es.  If not, see <http://www.gnu.org/licenses/>.


# this is an internal file providing language support.
# please refer to inst/README.languages for details

#' Language support for Spanish
#' 
#' This function adds support for Spanish to the koRpus package. You should not
#' need to call it manually, as that is done automatically when this package is
#' being loaded.
#' 
#' In particular, this function adds the following:
#' \itemize{
#'  \item \code{lang}: The additional language "es" to be used with koRpus
#'  \item \code{treetag}: The additional preset "es", implemented according to the respective TreeTagger[1] script
#'  \item \code{POS tags}: An additional set of tags, implemented using the documentation for the corresponding
#'    TreeTagger parameter set[2]
#' }
#' Hyphenation patterns are provided by means of the \code{\link[sylly.es:hyph.support.es]{sylly.es}} package.
#'
#' @param ... Optional arguments for \code{\link[koRpus:set.lang.support]{set.lang.support}}.
#' @references
#' [1] \url{http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/}
#'
#' [2] \url{http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/data/spanish-tagset.txt}
#' @export
#' @importFrom koRpus set.lang.support
#' @examples
#' lang.support.es()

lang.support.es <- function(...) {
  koRpus::set.lang.support("treetag",
    list("es"=list(
      ## preset: "es"
      # tags UTF-8 encoded text files
      # Earl Brown added this Spanish section
      lang="es",
      encoding="UTF-8",
      preset=function(TT.cmd, TT.bin, TT.lib, unix.OS){
        TT.tokenizer <- file.path(TT.cmd, "utf8-tokenize.perl")
        TT.abbrev    <- file.path(TT.lib, "spanish-abbreviations")
        TT.params    <- file.path(TT.lib, "spanish.par")
        TT.lexicon   <- file.path(TT.lib, "spanish-mwls")
        TT.lookup    <- file.path(TT.cmd, "mwl-lookup.perl")
        if(isTRUE(unix.OS)){
          # preset for unix systems
          return(
            list(
              TT.tokenizer      = TT.tokenizer,
              TT.tagger         = file.path(TT.bin, "tree-tagger"),
              TT.abbrev         = TT.abbrev,
              TT.params         = TT.params,
              TT.lexicon        = TT.lexicon,
              TT.lookup         = TT.lookup,
              TT.filter         = c(),

              TT.tknz.opts      = c(),
              TT.lookup.command = paste(TT.lookup, "-f", TT.lexicon, "|"),
              TT.filter.command = c()
            )
          )
        } else {
          # preset for windows systems
          return(
            list(
              TT.tokenizer      = TT.tokenizer,
              TT.tagger         = file.path(TT.bin, "tree-tagger.exe"),
              TT.abbrev         = TT.abbrev,
              TT.params         = TT.params,
              TT.lexicon        = TT.lexicon,
              TT.lookup         = TT.lookup,
              TT.filter         = c(),

              TT.tknz.opts      = c(),
              TT.lookup.command = paste("perl", TT.lookup, "-f", TT.lexicon, "|"),
              TT.filter.command = c()
            )
          )
        }
      })
    ),
    ...
  )

  koRpus::set.lang.support("kRp.POS.tags",
    ## tag and class definitions
    # es -- spanish
    # Earl Brown added these Spanish tags
    list("es"=list(
      tag.class.def.words=matrix(c(
        "ACRNM", "acronym", "acronym (ISO, CEI)",
        "ADJ", "adjective", "Adjectives (mayores, mayor)",
        "ADV", "adverb", "Adverbs (muy, demasiado, c\u00f3mo)",
        "ALFP", "letter", "Plural letter of the alphabet (As/Aes, bes)",
        "ALFS", "letter", "Singular letter of the alphabet (A, b)",
        "ART", "determiner", "Articles (un, las, la, unas)",
        "CARD", "number", "Cardinals",
        "CC", "conjunction", "Coordinating conjunction (y, o)",
        "CCAD", "conjunction", "Adversative coordinating conjunction (pero)",
        "CCNEG", "conjunction", "Negative coordinating conjunction (ni)",
        "CODE", "code", "Alphanumeric code",
        "CQUE", "conjunction", "que (as conjunction)",
        "CSUBF", "conjunction", "Subordinating conjunction that introduces finite clauses (apenas)",
        "CSUBI", "conjunction", "Subordinating conjunction that introduces infinite clauses (al)",
        "CSUBX", "conjunction", "Subordinating conjunction underspecified for subord-type (aunque)",
        "DM", "determiner", "Demonstrative pronouns (\u00e9sas, \u00e9se, esta)",
        "FO", "formula", "Formula",
        "INT", "pronoun", "Interrogative pronouns (qui\u00e9nes, cu\u00e1ntas, cu\u00e1nto)",
        "ITJN", "interjection", "Interjection (oh, ja)",
        "NC", "noun", "Common nouns (mesas, mesa, libro, ordenador)",
        "NEG", "negation", "Negation",
        "NMEA", "noun", "measure noun (metros, litros)",
        "NMON", "noun", "month name",
        "NP", "noun", "Proper nouns",
        "ORD", "ordinal", "Ordinals (primer, primeras, primera)",
        "PAL", "al", "Portmanteau word formed by a and el",
        "PDEL", "del", "Portmanteau word formed by de and el",
        "PE", "foreign", "Foreign word",
        "PNC", "unknown", "Unclassified word",
        "PPC", "pronoun", "Clitic personal pronoun (le, les)",
        "PPO", "pronoun", "Possessive pronouns (mi, su, sus)",
        "PPX", "pronoun", "Clitics and personal pronouns (nos, me, nosotras, te, s\u00ed)",
    #    "PREP", "preposition", "Negative preposition (sin)",
        "PREP", "preposition", "Preposition",
        "PREP/DEL", "preposition", "Complex preposition \"despu\u00e9s del\"",
        "QU", "quantifier", "Quantifiers (sendas, cada)",
        "REL", "pronoun", "Relative pronouns (cuyas, cuyo)",
        "SE", "se", "Se (as particle)",
        "SYM", "symbol", "Symbols",
        "UMMX", "unit", "measure unit (MHz, km, mA)",
        "VCLIger", "verb", "clitic gerund verb",
        "VCLIinf", "verb", "clitic infinitive verb",
        "VCLIfin", "verb", "clitic finite verb",
        "VEadj", "verb", "Verb estar. Past participle",
        "VEfin", "verb", "Verb estar. Finite",
        "VEger", "verb", "Verb estar. Gerund",
        "VEinf", "verb", "Verb estar. Infinitive",
        "VHadj", "verb", "Verb haber. Past participle",
        "VHfin", "verb", "Verb haber. Finite",
        "VHger", "verb", "Verb haber. Gerund",
        "VHinf", "verb", "Verb haber. Infinitive",
        "VLadj", "verb", "Lexical verb. Past participle",
        "VLfin", "verb", "Lexical verb. Finite",
        "VLger", "verb", "Lexical verb. Gerund",
        "VLinf", "verb", "Lexical verb. Infinitive",
        "VMadj", "verb", "Modal verb. Past participle",
        "VMfin", "verb", "Modal verb. Finite",
        "VMger", "verb", "Modal verb. Gerund",
        "VMinf", "verb", "Modal verb. Infinitive",
        "VSadj", "verb", "Verb ser. Past participle",
        "VSfin", "verb", "Verb ser. Finite",
        "VSger", "verb", "Verb ser. Gerund",
        "VSinf", "verb", "Verb ser. Infinitive"
        ), ncol = 3, byrow = TRUE, dimnames = list(c(), c("tag", "wclass", "desc"))),
      tag.class.def.punct=matrix(c(
        "BACKSLASH", "punctuation", "backslash (\\) ",
        "CM", "comma", "comma (,)",
        "COLON", "punctuation", "colon (:)",
        "DASH", "punctuation", "dash (-)",
        "DOTS", "punctuation", "POS tag for \"...\"",
        "LP", "punctuation", "left parenthesis (\"(\", \"[\")",
        "PERCT", "punctuation", "percent sign (%)",
        "QT", "punctuation", "quotation symbol (\" \' `)",
        "RP", "punctuation", "right parenthesis (\")\", \"]\")",
        "SEMICOLON", "punctuation", "semicolon (;)",
        "SLASH", "punctuation", "slash (/)"
        ), ncol = 3, byrow = TRUE, dimnames = list(c(), c("tag", "wclass", "desc"))),
      tag.class.def.sentc=matrix(c(
        "FS", "fullstop", "Full stop punctuation marks"
        ), ncol = 3, byrow = TRUE, dimnames = list(c(), c("tag", "wclass", "desc")))
      )
    ),
    ...
  )
}

# this internal, non-exported function causes the language support to be
# properly added when the package gets loaded
#' @importFrom sylly.es hyph.support.es
.onAttach <- function(...) {
  lang.support.es()
  sylly.es::hyph.support.es()
}
