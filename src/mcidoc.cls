% 
% #INFO: Documentclass for writing documents for students at MCI.
%
% Copyright (C) 2023-2026 D. T. McGuiness, Ph.D
%
% COPYRIGHT NOTICE:
% -----------------
% It may be distributed and/or modified under the conditions of the LaTeX Project Public
% License (LPPL), either version 1.3c of this license or (at your option) any later version.
% The latest version of this license is in the file
%
% https://www.latex-project.org/lppl.txt
%
% This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
% without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
% 
% This file is the core of `mcidoc' and should not be edited.
% 
% ---------------------------------------------------------------------------------------------
% 
\NeedsTeXFormat{LaTeX2e}[13-02-2025]
\ProvidesClass{mcidoc}[12-01-2026 A documentclass for MCI MECH Students]
%
\DeclareKeys{
	state.store       = \class@state,
}
%
\def\mcidoc@version{2026.SS}
%
\ProcessKeyOptions\relax%
%
% ---------------------------------------------------------------------------------------------
%
\RequirePackage{ifthen}
\RequirePackage{tikz}
\usetikzlibrary{calc}
\RequirePackage{xstring}
\RequirePackage{fancyvrb}
\RequirePackage[ngerman]{babel}
\RequirePackage[T1]{fontenc}
\RequirePackage{Gudea}

%
% ---------------------------------------------------------------------------------------------
%
% Start by defining the actual key values to control the document structure
\pgfkeys{% 
	% Here we define the bibliographic entries
	/Thesis/Bibliography/.cd,
	Print/.store in                  = \Thesis@Bibliography@Print,
	Print                            = {set},
	Location/.store in               = \Thesis@Bibliography@Location,
	Location                         = {},
	State/.store in                  = \Thesis@Bibliography@State,
	State                            = {},
	Style/.store in                  = \Thesis@Bibliography@Style,
	Style                            = {},
	% Setting to the Table of Contents
	/Thesis/ToC/.cd,
	Primary/.store in                = \Thesis@ToC@Primary,
	Primary                          = {set},
	Figures/.store in                = \Thesis@ToC@Figures,
	Figures                          = {set},
	Tables/.store in                 = \Thesis@ToC@Tables,
	Tables                           = {set},
	% Settings for the Double Degree Program
	/Thesis/Double-Degree/.cd,
	Institution/.store in            = \Thesis@DD@Institution,
	Institution                      = {unset},
	Student-Number/.store in         = \Thesis@DD@StudentNumber,
	Student-Number                   = {unset},
	% Settings for the Double Degree Supervisor
	/Thesis/Double-Degree/Supervisor/.cd,
	Prefix/.store in                 = \Thesis@DD@Supervisor@Prefix,
	Prefix                           = {unset},
	Name/.store in                   = \Thesis@DD@Supervisor@Name,
	Name                             = {unset},
	Postfix/.store in                = \Thesis@DD@Supervisor@Postfix,
	Postfix                          = {unset},
	% Settings for the Supervisor
	/Thesis/Supervisor/.cd,
	Prefix/.default                  = {},
	Prefix/.store in                 = \Thesis@Supervisor@Prefix,
	Name/.store in                   = \Thesis@Supervisor@Name,
	Name                             = {Alistair M. Corwell},
	Postfix/.store in                = \Thesis@Supervisor@Postfix,
	Postfix/.default                 = {},
	Company/.store in                = \Thesis@Supervisor@Company,
	Company                          = {unset},
	% Settings for the Supervisor
	/Thesis/Reviewer/.cd,
	Prefix/.default                  = {},
	Prefix/.store in                 = \Thesis@Reviewer@Prefix,
	Name/.store in                   = \Thesis@Reviewer@Name,
	Name                             = {Alistair M. Corwell},
	Postfix/.store in                = \Thesis@Reviewer@Postfix,
	Postfix/.default                 = {},
	% Thesis General Settings
	/Thesis/.cd,
	StudyProgram/.store in           = \Thesis@StudyProgram,
	StudyProgram                     = {Mechatronics \& Smart Technologies},
	Novelty/.store in                = \Thesis@DeclarationOfNovelty,
	Novelty                          = {set},
	Embargo/.store in                = \Thesis@EmbargoRequest,
	Embargo                          = {unset},
	Location/.store in               = \Thesis@Location,
	Location                         = {Innsbruck},
	Date/.store in                   = \Thesis@Date,
	Date                             = {\the\day.\the\month.\the\year},
	% ---
	/Student/.cd,
	Prefix/.store in                 = \Student@Prefix,
	Prefix                           = {unset},
	Name/.store in                   = \Student@Name,
	Name                             = {Alistair M. Corwell},
	Postfix/.store in                = \Student@Postfix,
	Postfix                          = {unset},
	% ---
	/.cd,
	Degree/.store in                 = \Global@Degree,
	Degree                           = {Enter Degree},
	Language/.store in               = \Global@Language,
	Language                         = {EN},
	Department/.store in             = \Global@Department,
	Department                       = {MECH},
	StudentName/.store in            = \Global@StudentName,
	StudentName                      = {Jason Brigham},
	StudentID/.store in              = \Global@StudentID,
	StudentID                        = {2024000095},
	Title/.store in                  = \Global@Title,
	Title                            = {Notes Title},
	% ---
	% Setting to the Table of Contents
	/Report/ToC/.cd,
	Primary/.store in                = \Report@ToC@Primary,
	Primary                          = {set},
	Figures/.store in                = \Report@ToC@Figures,
	Figures                          = {set},
	Tables/.store in                 = \Report@ToC@Tables,
	Tables                           = {set},
	% ---
	% Settings for the Supervisor
	/Report/Supervisor/.cd,
	Prefix/.default                  = {},
	Prefix/.store in                 = \Report@Supervisor@Prefix,
	Name/.store in                   = \Report@Supervisor@Name,
	Name                             = {Alistair M. Corwell},
	Postfix/.store in                = \Report@Supervisor@Postfix,
	Postfix/.default                 = {},
	% --
	/Report/.cd,
	Title/.store in                  = \Report@Title,
	Title                            = {Thesis Title},
	Lecture/.store in                = \Report@Lecture,
	Lecture                          = {unset},
	Cohort/.store in                 = \Report@Cohort,
	Cohort                           = {unset},
	Group/.store in                  = \Report@Group,
	Group                            = {unset},
	Mode/.store in                   = \Report@Mode,
	Mode                             = {Assignment},
	% ---
	/Notes/.cd,
	Title/.store in                  = \Notes@Title,
	Title                            = {Notes Title},
	Lecture/.store in                = \Notes@Lecture,
	Lecture                          = {unset},
}
%
%
%
\NewDocumentCommand{\SetMCI}{m}{%
	%%%% The Primary control mechanism on how the document is configured.
	\pgfkeys{%
		%
		/StudentName/.code                     = \pgfqkeys{/Student}{##1},
		/Thesis/.code                          = \pgfqkeys{/Thesis}{##1},
		/Thesis/ToC/.code                      = \pgfqkeys{/Thesis/ToC}{##1},
		/Thesis/Supervisor/.code               = \pgfqkeys{/Thesis/Supervisor}{##1},
		/Thesis/Double-Degree/.code            = \pgfqkeys{/Thesis/Double-Degree}{##1},
		/Thesis/Double-Degree/Supervisor/.code = \pgfqkeys{/Thesis/Double-Degree/Supervisor}{##1},
		/Thesis/Reviewer/.code                 = \pgfqkeys{/Thesis/Reviewer}{##1},
		/Thesis/Bibliography/.code             = \pgfqkeys{/Thesis/Bibliography}{##1},
		/Report/ToC/.code                      = \pgfqkeys{/Report/ToC}{##1},
		/Report/.code                          = \pgfqkeys{/Report}{##1},
		#1,
	}%
}% 
%
%
%
\NewDocumentCommand{\If@State}{mm}{%
	% -- A Simple control mechanism to change behavior of
	% -- class.
	% -- #1 : Defined `state'
	% -- #2 : Execute code.
	\ifthenelse{\equal{\class@state}{#1}
	}{%
		#2
	}{%
		% 
	}% 
}%
%
%
%
% LOAD BASE CLASS -----------------------------------------------------------------------------
%
\If@State{Thesis}{%
	% Load the default class for state `Thesis'
	\LoadClass[%
		chapterprefix = true,%
		DIV           = 11,%
		paper         = A4,%
		fontsize      = 10,%
		twoside       = false,%
		parskip       = full,
		abstract      = true,
	]{scrreprt}%
}%
%
%
%
\If@State{Paper}{%  
	\LoadClass[
		chapterprefix = true,
		DIV           = 22,
		paper         = A4,
		fontsize      = 10,
		twoside       = false,
	]{scrreprt}
}{}
%
%
%
\If@State{Report}{
	% Load the default class for state `Thesis'
	\LoadClass[%
		chapterprefix = true,%
		DIV           = 11,%
		paper         = A4,%
		fontsize      = 10,%
		twoside       = false,%
		parskip       = full,
		abstract      = true,
		headings=chapterprefix
	]{scrreprt}%
}{}
%
%
% 
\If@State{Notes}{
	% Load the default class for state `Thesis'
	\LoadClass[%
		chapterprefix = true,%
		DIV           = 11,%
		paper         = A4,%
		fontsize      = 10,%
		twoside       = false,%
		parskip       = full,
		abstract      = true,
	]{scrreprt}%
}{}
% 
% 
% 
\If@State{Slide}{
	\LoadClass[
		10pt,
		t]{beamer}
}
%
\ExecuteOptions{}
% 
% ---------------------------------------------------------------------------------------------
%
%
%
\ExplSyntaxOn%
\NewDocumentCommand{\LanguageCondition}{mmmm}{%
	% -- Create conditional cases for language specific features.
	% -- #1 : Described language,
	% -- #2 : Language specific variable.
	% -- #3 : Value of variable given in #2.
	% -- #4 : Requested output if true.
	\tl_set:Ne \l_tmplang_tl { \Global@Language }
	\tl_set:Ne \l_tmpsub_tl { #2 }

	\str_if_eq:NNTF { \l_tmplang_tl } { #1 }
	{
		\str_if_eq:NNTF { \l_tmpsub_tl } { #3 }
		{ #4 }
		{ }
	}
	{}
}
% 
% 
% 
\NewDocumentCommand{\DocumentationError}{mmm}{%
	% -- Describe error codes in English and German for proper MCI Formatting.
	% -- #1 : Subdomain of errors,
	% -- #2 : Error description in English,
	% -- #3 : Error description in German,
	\group_begin:
	\char_set_catcode_space:n { `\ }
	\msg_new:nnnn { mcidoc } { option / #1 }
	{ \\ EN: \\---\\#2 \\ \\DE:\\---\\#3 }{}
	\group_end:
}%
% 
%
%
\NewDocumentCommand{\LanguageNoCondition}{mm}{%
	% -- Create conditional cases for language specific features with no arguments.
	% -- #1 : Described language,
	% -- #2 : Required Output.
	\tl_set:Ne \l_tmplang_tl { \Global@Language }
	\tl_set:Ne \l_tmpsub_tl { #2 }
	\str_if_eq:NNTF { \l_tmplang_tl } { #1 }
	{ #2 }
	{}
}
\ExplSyntaxOff%
%
%
%
\NewDocumentCommand{\Lang@English}{m}{%
	% -- Specific Case for when `EN' is chosen.
	% -- #1 : Case when the language `EN' is chosen.
	\ifthenelse{\equal{\Global@Language}{EN}%
	}{%
		#1
	}{}%
}%
%
%
%
\NewDocumentCommand{\Lang@German}{m}{%
	% -- Specific case for when `DE' is chosen.
	% -- #1 : Case when the language `DE' is chosen.
	\ifthenelse{\equal{\Global@Language}{DE}
	}{%
		#1
	}{}%
}%
%
%
% We need this package to control how the header text is controlled.
\RequirePackage[fit, breakwords]{truncate}
%
%
% BEGINNING OF THESIS CLASS -------------------------------------------------------------------


\ifthenelse{\equal{\class@state}{Thesis}
}{
	% Add this so the titlePage is automatically inserted
	\NewDocumentCommand{\Th@DeclarationOfNovelty}{}{%
		% -- Define the text to be printed for the `Declaration in Lieu of Oath'.
		% -- First part is in `english' and the second part is in `german'.
		\ifthenelse{\equal{\Thesis@DeclarationOfNovelty}{set}}{
			% 
			\ifthenelse{%
				\equal{\Global@Language}{EN}%
			}{%
				\section*{Declaration in Lieu of Oath}

				I, {\Global@StudentName}, hereby declare, under oath, that this %
				\LanguageCondition{EN}{\Global@Degree}{BSc}{bachelor's} %
				\LanguageCondition{EN}{\Global@Degree}{MSc}{master's} %
				thesis with the title ``{\Global@Title}'' has been my independent work and has
				not been aided with any prohibited means. I declare, to the best of my
				knowledge and belief, that all passages taken from published and unpublished
				sources or documents have been reproduced, whether as original, slightly
				changed, or in thought, and have been mentioned as such at the corresponding
				places in the thesis by citation, where the extent of the original quotes is
				indicated.

				I have only used the permitted and documented tools and have disclosed the use
				of generative AI systems, as required by the degree program. I am fully
				responsible for the selection, adoption, and all results of the AI-generated
				output I have used.


				The paper has not been submitted for evaluation to another examination
				authority or has been published in this form or another.

				% Add the bottom signature place
				\vspace*{\fill}
				\rule{5cm}{0.2pt}\hfill\rule{5cm}{0.2pt}\\
				\noindent\parbox{5cm}{\centering{\Thesis@Location,\ \Thesis@Date}}
				\hfill%
				\parbox{5cm}{\centering{​Signature}}

			}{%
				\section*{Eidesstattliche Erklärung}

				Ich, {\Global@StudentName}, erkläre hiermit an Eides statt, dass ich die
				vorliegende %
				\LanguageCondition{DE}{\Global@Degree}{BSc}{Bachelor}%
				\LanguageCondition{DE}{\Global@Degree}{MSc}{Master}%
				arbeit mit dem Titel {\glqq{\Global@Title}\grqq} selbständig angefertigt
				habe. Die aus fremden Quellen direkt oder indirekt übernommenen Gedanken sind
				als solche kenntlich gemacht.

				Ich habe nur die erlaubten und dokumentierten Hilfsmittel benutzt und den
				Einsatz generativer KI-Systeme, wie vom Studiengang gefordert, offengelegt. Ich
				verantworte die Auswahl, Übernahme und sämtliche Ergebnisse des von mir
				verwendeten KI-generierten Outputs vollumfänglich selbst.

				Die Arbeit wurde bisher weder in gleicher noch in ähnlicher Form einer anderen
				Prüfungsbehörde vorgelegt und auch noch nicht veröffentlicht.

				\vspace*{\fill}
				\rule{5cm}{0.2pt}\hfill\rule{5cm}{0.2pt}\\
				\noindent\parbox{5cm}{\centering{\Thesis@Location,\ \Thesis@Date}}%
				\hfill%
				\parbox{5cm}{\centering{​Unterschrift}}

			}
			\cleardoublepage%
		}{}
	}
	%
	%
	%
	\NewDocumentCommand{\Th@ThesisEmbargoRequest}{O{5}}{%
		% -- Define the text to be printed for the `Preclusion from Public Access'.
		% -- #1: The date which embargo should be held.
		\ifthenelse{\equal{\Thesis@EmbargoRequest}{unset}}{}{
			% 
			\ifthenelse{%
				\equal{\Global@Language}{EN}
			}{%
				\section*{Preclusion from Public Access}

				I, {\Global@StudentName}, have requested preclusion from public access for this
				\LanguageCondition{EN}{\Global@Degree}{BSc}{bachelor's} %
				\LanguageCondition{EN}{\Global@Degree}{MSc}{master's} %
				thesis until {\Thesis@EmbargoRequest}, which was approved by the study program.

				% Add the bottom signature place
				\vspace{\fill}
				\noindent\rule{5cm}{0.2pt}\hfill\rule{5cm}{0.2pt}\\
				\noindent\parbox{5cm}{\centering{\Thesis@Location,\ \Thesis@Date}}
				\hspace*{\fill}%
				\parbox{5cm}{\centering{Signature}}
			}{%
				\section*{Ausschluss vom öffentlichen Zugang}

				Ich, {\Global@StudentName}, habe die Sperrung meiner
				\LanguageCondition{EN}{\Global@Degree}{BSc}{Bachelor}%
				\LanguageCondition{EN}{\Global@Degree}{MSc}{Master}%
				Arbeit beantragt, welche von der Studiengangsleitung genehmigt wurde. Die
				vorliegende Arbeit ist somit bis zum {\Thesis@EmbargoRequest} gesperrt.

				% Add the bottom signature place
				\vspace{\fill}
				\noindent\rule{5cm}{1pt}\hfill\rule{5cm}{1pt}\\
				\noindent\parbox{5cm}{\centering{\Thesis@Location,\ \Thesis@Date}}
				\hspace*{\fill}%
				\parbox{5cm}{\centering{​Unterschrift}}
			}%
			\cleardoublepage%
		}%
	}%
	% 
	% Here we define a new `boolean' to check if the user has requested an
	% acknowledgments. We also set it for false as its original state.
	\newif\ifacknowledgments%
	%\acknowledgementsfalse%
	% 
	% 
	\NewDocumentEnvironment{Abstract}{m}{%
		% -- Environment to store the text for abstract. Depending on
		% -- on the language store it in individual files and later
		% -- recall these. Requires `latexmk' for proper compilation
		% -- #1 : Language setting
		\IfEqCase{#1}{%
			{EN}{\def\abstract@filename{aux-\jobname-abstract-en.abs}}
			{DE}{\def\abstract@filename{aux-\jobname-abstract-de.abs}}
		}[\ClassError{mcidoc}{Undefined Language Option: #1}{}]
		\typeout{Writing the file \abstract@filename}
		\VerbatimOut{\abstract@filename}%
	}{%
		\endVerbatimOut%
	}%
	% 
	% 
	% 
	\NewDocumentEnvironment{Acknowledgments}{}{%
		% -- Environment to print out the acknowledgments.
		% -- Here we need to make sure `\ifacknowledgements' needs to be
		% -- set `globally' as the toggle seems to be restricted by the
		% -- `NewDocumentEnvironemt' command.
		\global\let\ifacknowledgments\iftrue%
		\def\acknowledgements@filename{aux-\jobname-acknowledgement.ack}
		\typeout{Writing the file \acknowledgements@filename}
		\VerbatimOut{\acknowledgements@filename}%
	}{%
		\endVerbatimOut%
	}%
	% 
	% 
	% 
	\NewDocumentCommand{\Th@Abstracts}{}{
		% -- Define how the abstract is printed.
		% -- A significant hurdle to tackle was the recalling of the
		% -- function when the content was defined after. To remedy this,
		% -- auxiliary files were used, and depending on the language either
		% -- english or both english plus german is printed.
		\ifthenelse{\equal{\Global@Language}{EN}}{%
			\foreach \ii / \jj in {english/en}{%
					\begin{otherlanguage}{\ii}
						\renewcaptionname{english}{\abstractname}{Abstract}
						\begin{abstract}
							\input{aux-\jobname-abstract-\jj.abs}
						\end{abstract}
					\end{otherlanguage}
				}%
		}{}
		%%%% 
		\ifthenelse{\equal{\Global@Language}{DE}}{%
			\foreach \ii / \jj in {ngerman/de, english/en}{%
					\renewcaptionname{ngerman}{\abstractname}{Zusammenfassung}
					\begin{otherlanguage}{\ii}
						\begin{abstract}
							\input{aux-\jobname-abstract-\jj.abs}
						\end{abstract}
					\end{otherlanguage}
				}%
		}{}
	}%
	% 
	% 
	% 
	\NewDocumentCommand{\Th@Acknowledgments}{}{
		% -- Define how the acknowledgment is printed
		\ifthenelse{\equal{\Global@Language}{EN}}{
			\bgroup%
			\renewcaptionname{english}{\abstractname}{Acknowledgements}
			\begin{otherlanguage}{english}
				\begin{abstract}
					\input{aux-\jobname-acknowledgement.ack}
				\end{abstract}
			\end{otherlanguage}
			\egroup%
		}{}
		%%%%
		\ifthenelse{\equal{\Global@Language}{DE}}{
			\bgroup%
			\renewcaptionname{ngerman}{\abstractname}{Danksagung}
			\begin{otherlanguage}{ngerman}
				\begin{abstract}
					\input{aux-\jobname-acknowledgement.ack}
				\end{abstract}
			\end{otherlanguage}
			\egroup%
		}{}
	}%
	% 
	% 
	% 
	\NewDocumentCommand{\Th@Preamble}{O{}}{
		% -- A collection command to print all necessary preamble.
		\MakeTitlePage
		\Th@ThesisEmbargoRequest[#1]
		\Th@DeclarationOfNovelty
		\ifacknowledgments%
			\Th@Acknowledgments
		\fi%
		\Th@Abstracts
		\TableOfContents
	}
	%
	%
	%
	\NewDocumentCommand{\TableOfContents}{}{
		% -- Define the way all Table of Contents are displayed.
		% -- An alteration is made by the assumption, the thesis will not be
		% -- printed. To decrease the amount of unnecessary white pages `\relax'
		% -- command is used for the `\listoftables'.
		\ifthenelse{\equal{\Thesis@ToC@Primary}{set}}{\tableofcontents}{}
		\begingroup
		\ifthenelse{\equal{\Thesis@ToC@Figures}{set}}{\listoffigures}{}
		\ifthenelse{\equal{\Thesis@ToC@Tables}{set}}{\let\clearpage\relax\listoftables}{}
		\endgroup
		\clearpage
		\pagenumbering{arabic}
		\pagestyle{scrheadings}
	}
	%
	%
	%
	\NewDocumentCommand{\MakeTitlePage}{}{%
		% -- Define the TitlePage for the Thesis.
		%
		% Make sure the page has no header/footer
		\pagestyle{empty}%
		% 
		% Break geometry and create a new one
		\newgeometry{%
			margin = 3cm,%
			top    = 3cm,%
		}%
		% Put the title on center of the page from margin.
		% Put the mci-logo on the page in upper right.
		%
		\begin{titlepage}%
			%
			\begin{center}%
				\LARGE\noindent\textbf{\Global@Title}
			\end{center}%
			% 
			\centering
			% 
			\begin{center}
				\vspace*{5ex}
				\noindent%
				\fbox{\begin{minipage}{%
							\dimexpr\textwidth-2\fboxsep-2\fboxrule\relax}
						\vspace*{1ex}\LARGE\centering\bfseries%
						%%%% 
						\LanguageCondition{DE}{\Global@Degree}{MSc}{MASTERARBEIT}
						\LanguageCondition{EN}{\Global@Degree}{MSc}{MASTER THESIS}
						%%%% 
						\LanguageCondition{DE}{\Global@Degree}{BSc}{BACHELORARBEIT}
						\LanguageCondition{EN}{\Global@Degree}{BSc}{BACHELOR THESIS}
						%%%% 
						\vspace*{0.8ex}
					\end{minipage}}
				% 
			\end{center}

			\vspace{2ex}

			% Write text under title, explaining the thesis requirements.
			\bgroup%
			\Large
			\LanguageNoCondition{EN}%
			{In partial fulfillment of the requirements for the degree}
			\LanguageNoCondition{DE}%
			{Zur Erlangung des akademischen Grades}%
			\egroup%

			\vspace*{-0.5ex}

			% Add which degree is it from.
			\bgroup\Large%
			\LanguageCondition{EN}{\Global@Degree}{BSc}{%
				\glqq{Bachelor of Science in Engineering}\grqq}
			\LanguageCondition{DE}{\Global@Degree}{BSc}{%
				\glqq{Bachelor of Science in Engineering}\grqq}
			%%%% 
			\LanguageCondition{EN}{\Global@Degree}{MSc}{%
				\grqq{Master of Science in Engineering}\grqq}
			\LanguageCondition{DE}{\Global@Degree}{MSc}{%
				\glqq{Master of Science in Engineering}\grqq}
			\ifthenelse{\equal{\Thesis@DD@Institution}{unset}}{}{

				\vspace{-2ex}

				\grqq%
				\IfEqCase{\Thesis@DD@Institution}{%
					{ASU}{Master of Science in Engineering Physics}
					{ESILV}{Diplôme d'Ingénieur ESILV conférant le grade de Master}
				}[]%
				\grqq%

			}
			\egroup%

			\vspace{4ex}

			\bgroup\large%
			\LanguageCondition{EN}{\Global@Degree}{BSc}{Bachelor program:}
			\LanguageCondition{DE}{\Global@Degree}{BSc}{Studiengang:}
			%%%%
			\LanguageCondition{EN}{\Global@Degree}{MSc}{%
				\ifthenelse{\equal{\Thesis@DD@Institution}{unset}}%
				{Master program:}%
				{Double Degree Master programs:}
			}%
			\LanguageCondition{DE}{\Global@Degree}{MSc}{Studiengang:}
			\egroup%

			\vspace{-1.5ex}

			\bgroup%
			\bfseries\large\Thesis@StudyProgram\normalfont%

			\vspace{-1.5ex}
			\IfEqCase{\Global@Language}{
				{DE}{MCI\,\,\textbar\,\,%
					Die Unternehmerische Hochschule\textsuperscript{\textregistered}}
				{EN}{MCI\,\,\textbar\,\,%
					The Entrepreneurial School\textsuperscript{\textregistered}}
			}[]
			\ifthenelse{\equal{\Thesis@DD@Institution}{unset}}{}{

				\vspace{-1.5ex}

				\bfseries\large%
				\IfEqCase{\Thesis@DD@Institution}{%
					{ASU}{Engineering Physics}
					{ESILV}{Modeling \& Computational Mechanics}
				}[]%
				\normalfont%

				\vspace{-1.5ex}

				\IfEqCase{\Thesis@DD@Institution}{%
					{ASU}{Appalachian State University}
					{ESILV}{Ecole Supérieure d'Ingénieurs Léonard de Vinci}
				}[]%

			}

			\egroup%

			\vspace*{\fill}

			{\large{%
					\LanguageNoCondition{EN}{Supervisor}%
					\LanguageNoCondition{DE}{Betreuer:in:}%
				}\linebreak\textbf{%
					\ifthenelse{\equal{\Thesis@DD@Institution}{unset}}{
						\ifthenelse{\equal{\Thesis@Supervisor@Company}{unset}}{}{
							\bgroup\normalfont\Thesis@Supervisor@Company\egroup \\}
						\Thesis@Supervisor@Prefix\,
						\Thesis@Supervisor@Name%
						\ifthenelse{\equal{\Thesis@Supervisor@Postfix}{}}{}{,}
						\Thesis@Supervisor@Postfix}}{%
					% Here we write a specific case for double degree program
					\bfseries
					\ifthenelse{\equal{\Thesis@DD@Institution}{unset}}{}{
						\ifthenelse{\equal{\Thesis@Supervisor@Prefix}{unset}}{}{%
							\Thesis@Supervisor@Prefix}
						\Thesis@Supervisor@Name%
						\ifthenelse{\equal{\Thesis@Supervisor@Postfix}{unset}}{}{%
							, \Thesis@Supervisor@Postfix} (MCI) \\
						\ifthenelse{\equal{\Thesis@DD@Supervisor@Prefix}{unset}}{}{%
							\Thesis@DD@Supervisor@Prefix}
						\Thesis@DD@Supervisor@Name%
						\ifthenelse{\equal{\Thesis@DD@Supervisor@Postfix}{unset}}{}{%
							, \Thesis@DD@Supervisor@Postfix} (\Thesis@DD@Institution)}
				}}

			\vspace{1ex}

			\ifthenelse{\equal{\Thesis@Supervisor@Company}{unset}}{}{
				{\large{%
						\LanguageNoCondition{EN}{Reviewer}%
						\LanguageNoCondition{DE}{Gutachter:in}%
					}\linebreak\textbf{
						\Thesis@Reviewer@Prefix\,
						\Thesis@Reviewer@Name%
						\ifthenelse{\equal{\Thesis@Reviewer@Postfix}{}}{}{,}
						\Thesis@Reviewer@Postfix}}}

			\bgroup%
			\large{%
				\LanguageNoCondition{EN}{Author}%
				\LanguageNoCondition{DE}{Verfasser:in:}%
			}\linebreak% 
			\textbf{%
				\ifthenelse{\equal{\Student@Prefix}{unset}}{}{\Student@Prefix}
				\Student@Name%
				\ifthenelse{\equal{\Student@Postfix}{unset}}{}{, \Student@Postfix}
			}\linebreak%
			\textbf{%
				\Global@StudentID
				\ifthenelse{\equal{\Thesis@DD@Institution}{unset}}{}{ (MCI),
					\Thesis@DD@StudentNumber\ (\Thesis@DD@Institution)}
			}
			\egroup%

		\end{titlepage}
		% 
		% 
		\restoregeometry%
		% 
		\cleardoublepage%
	}%
	%
	\AddToHook{begindocument/end}{%
		\Th@Preamble[\Thesis@EmbargoRequest]%
	}%
	\AddToHook{enddocument}{%
		\ifthenelse{\equal{\Thesis@Bibliography@Print}{unset}}{}{\printbibliography}%
	}%

	% HEADER / FOOTER SETTINGS ----------------------------------------------------------------

	\RequirePackage[
		automark,
		headsepline,
		footsepline,
		autooneside  = false
	]{scrlayer-scrpage}

	\clearpairofpagestyles%

	\ihead{\leftmark}
	\ohead{\rightmark}
	\ofoot{\thepage}
	\ifoot{%
		\ifthenelse{\equal{\Student@Prefix}{unset}}{}{\Student@Prefix}
		\Student@Name%
		\ifthenelse{\equal{\Student@Postfix}{unset}}{}{, \Student@Postfix}
	}
	\renewcommand{\headfont}{\normalfont}

	% Here we define how the chapter heading will be shown where the number will be
	% enlarged with a small text on upper left and the title will be printed below
	% with text flushed to the right.
	\setkomafont{chapter}{\huge}
	\setkomafont{chapterprefix}{\normalfont\normalsize\bfseries}
	\newkomafont{chapternumber}{\fontsize{100}{100}\selectfont}
	%
	%
	%
	\renewcommand\chapterformat{% 
		\usekomafont{chapter}
		\raisebox{1.25\baselineskip}{\makebox[0pt][r]{%
				\usekomafont{chapterprefix}\chapapp\enskip}}%
		\raisebox{-.5\baselineskip}{\usekomafont{chapternumber}\thechapter}%
	}
	%
	%
	%
	\RedeclareSectionCommand[
		innerskip=1ex
	]{chapter}
	%
	%
	%
	\newbox\chapternumberbox%
	\renewcommand\chapterlinesformat[3]{%
		\Ifstr{#1}{chapter}{%
			\Ifstr{#2}{}{#3}{%
				\savebox\chapternumberbox{\chapterformat}%
				\parbox[t]{\dimexpr\textwidth-\wd\chapternumberbox-1em\relax}{\raggedchapter#3}%
				\quad#2%
			}% 
		}{\@hangfrom{#2}{#3}}%
	}%
	%  
	\renewcommand\raggedchapter{\raggedleft}
	%
	% Control how much the text should be stretched. Ideally for thesis, keep
	% this at `1.5' for easy reading.
	\RequirePackage{setspace}
	\setstretch{1.5}
	%
}{}

% END OF THESIS CLASS -------------------------------------------------------------------------

\usepackage{setspace}

% BEGINNING OF PAPER CLASS --------------------------------------------------------------------

\ifthenelse{\equal{\class@state}{Paper}}{%
	%
	\RequirePackage{geometry}
	%
	% The document needs to be formatted using `\doublecolumn'.
	\AddToHook{begindocument/end}{\twocolumn}
	%
	%
	%
	% Set the page-geometry to conform to `IEEE' standard.
	\newgeometry{%
		top    = 2.54cm,%
		bottom = 2.54cm,%
		left   = 2.54cm,%
		right  = 2.54cm,%
	}%
	%
	\RequirePackage{setspace}
	\setstretch{1.25}
	%
	% Here we disable `Thesis' state commands if they are accidentally
	% used.

}{}

% END OF PAPER CLASS --------------------------------------------------------------------------

% BEGINNING OF NOTES CLASS --------------------------------------------------------------------
%
% #INFO: A `state' for students to write their lecture notes.
%
\ifthenelse{\equal{\class@state}{Notes}}{%
	% 
	\RequirePackage{verbatim}
	\RequirePackage{geometry}
	\RequirePackage{setspace}
	\setstretch{1.5}
	% 
	% 
	%
	% % Set the page-geometry to conform to `IEEE' standard.
	% \newgeometry{%
	% 	top    = 2.54cm,% 
	% 	bottom = 2.54cm,%
	% 	left   = 2.54cm,%
	% 	right  = 2.54cm,%
	% }%
	%
	%
	%
	\RequirePackage[
		automark,
		headsepline,
		footsepline,
		autooneside  = false
	]{scrlayer-scrpage}

	\clearpairofpagestyles%

	\ihead{\leftmark}
	\ohead{\rightmark}
	\ofoot{\thepage}
	\ifoot{%
		\ifthenelse{\equal{\Student@Prefix}{unset}}{}{\Student@Prefix}
		\Student@Name%
		\ifthenelse{\equal{\Student@Postfix}{unset}}{}{, \Student@Postfix}
	}
	\renewcommand{\headfont}{\normalfont}
	% 
	\NewDocumentEnvironment{Abstract}{m}{\expandafter\comment}{\expandafter\endcomment}
	\NewDocumentEnvironment{Acknowledgments}{}{\expandafter\comment}{\expandafter\endcomment}
	%
	%
	%
	\NewDocumentCommand{\MakeTitlePage}{}{
		% -- Generate a Title Page for the `Notes' Class.

		\pagestyle{empty} % Define page style as empty (i.e., no header & footer)

		% Define new geometry for the title page (this will be reset later)
		\newgeometry{
			margin = 3cm,
			top    = 3cm
		}

		\begin{titlepage}
			% 
			\begin{center}
				% 
				% Include
				\bgroup%
				\large%
				\IfEqCase{\Global@Language}{%
					{DE}{MCI\,\,\textbar\,\,%
						Die Unternehmerische Hochschule\textsuperscript{\textregistered}}
					{EN}{MCI\,\,\textbar\,\,%
						The Entrepreneurial School\textsuperscript{\textregistered}}}[]
				\hfill\textcolor{gray!75!black}{\Global@Degree} \\[1cm]
				{\Huge\bfseries\Global@Title}
				\egroup\\[0.4cm]
				{\Large Lecture Notes} \\[\baselineskip]
				{\Large\Notes@Lecture}
				\normalsize

			\end{center}
			%
			\vspace{\fill}
			%
		\end{titlepage}
		\restoregeometry%
		\cleardoublepage%
	}

	\NewDocumentCommand{\TableOfContents}{}{
		% -- Define the way all Table of Contents are displayed.
		% -- An alteration is made by the assumption, the thesis will not be
		% -- printed. To decrease the amount of unnecessary white pages `\relax'
		% -- command is used for the `\listoftables'.
		\ifthenelse{\equal{\Thesis@ToC@Primary}{set}}{\tableofcontents}{}
		\begingroup
		\ifthenelse{\equal{\Thesis@ToC@Figures}{set}}{\listoffigures}{}
		\ifthenelse{\equal{\Thesis@ToC@Tables}{set}}{\let\clearpage\relax\listoftables}{}
		\endgroup
		\clearpage
		\pagenumbering{arabic}
		\pagestyle{scrheadings}
	}
	%
	%
	%
	\NewDocumentCommand{\Preamble}{}{
		% -- A collection command to print all necessary preamble.
		\MakeTitlePage
		\TableOfContents
	}
	%
	%
	\AddToHook{begindocument/end}{%
		\Preamble%
	}%
	%
	%
}{}

% END OF NOTES CLASS -------------------------------------------------------------------------



% BEGINNING OF REPORT CLASS -------------------------------------------------------------------

\ifthenelse{\equal{\class@state}{Report}}{%
	\definecolor{mci2}{HTML}{004983}

	% 
	% Control how much the text should be stretched. Ideally for thesis, keep
	% this at `1.5' for easy reading.
	\RequirePackage{setspace}
	\setstretch{1.5}
	% 

	% Here we adjust the way chapters are written to minimise the space between top paper
	% and the content below.
	\RedeclareSectionCommand[%
		beforeskip = \dimexpr3.3\baselineskip+1\parskip\relax,
		innerskip  = 0pt,% <- space between chapter number and chapter title
		afterskip  = 0pt
	]{chapter}

	% Next we adjust the chapter fonts and push content to RHS.
	\renewcommand{\raggedchapter}{\raggedleft}%
	\renewcommand{\chapterformat}{%
		\textcolor{mci2}{%
			\fontsize{20pt}{20pt}%
			\selectfont Chapter %
				{\fontsize{80pt}{80pt}\selectfont\thechapter}%
		}%
	}%
	% Finally we reconfigure the chapter headline.
	\renewcommand{\chapterlineswithprefixformat}[3]{%
		#2#3%
		\vspace*{-\baselineskip}
		\textcolor{gray!50}{\rule{\textwidth}{.25pt}}\par\nobreak
	}%

	\RedeclareSectionCommands[
		beforeskip=0pt plus 1ex minus .2ex,
		afterskip=1sp plus .2ex
	]{section,subsection}
	\renewcommand*{\sectionformat}{\thesection\hspace*{1em}}
	\renewcommand*{\subsectionformat}{\thesubsection\hspace*{1em}}
	\renewcommand*\chapterheadstartvskip{}
	\renewcommand*\chapterheadendvskip{%
		\vspace*{1\baselineskip plus .1\baselineskip minus .167\baselineskip}}

	\NewDocumentEnvironment{Abstract}{m}{%
		% -- Environment to store the text for abstract. Depending on
		% -- on the language store it in individual files and later
		% -- recall these. Requires `latexmk' for proper compilation
		% -- #1 : Language setting
		\IfEqCase{#1}{%
			{EN}{\def\abstract@filename{aux-\jobname-abstract-en.abs}}
			{DE}{\def\abstract@filename{aux-\jobname-abstract-de.abs}}
		}[\ClassError{mcidoc}{Undefined Language Option: #1}{}]
		\typeout{Writing the file \abstract@filename}
		\VerbatimOut{\abstract@filename}%
	}{%
		\endVerbatimOut%
	}% 

	\NewDocumentCommand{\Th@Abstracts}{}{
		% -- Define how the abstract is printed.
		% -- A significant hurdle to tackle was the recalling of the
		% -- function when the content was defined after. To remedy this,
		% -- auxiliary files were used, and depending on the language either
		% -- english or both english plus german is printed.
		\ifthenelse{\equal{\Global@Language}{EN}}{%
			\foreach \ii / \jj in {english/en}{%
					\begin{otherlanguage}{\ii}
						\input{aux-\jobname-abstract-\jj.abs}
					\end{otherlanguage}
				}%
		}{}
		%%%% 
		\ifthenelse{\equal{\Global@Language}{DE}}{%
			\foreach \ii / \jj in {ngerman/de, english/en}{%
					\input{aux-\jobname-abstract-\jj.abs}
				}%
		}{}
	}%

	\NewDocumentCommand{\MakeTitlePage}{}{
		% -- Generate a Title Page for the `Report' Class.

		\pagestyle{empty} % Define page style as empty (i.e., no header & footer)

		% Define new geometry for the title page (this will be reset later)
		\newgeometry{
			margin = 3cm,
			top    = 3cm
		}

		\begin{titlepage}
			% 
			\begin{flushleft}
				% 			
				\bgroup%
				\large%
				\IfEqCase{\Global@Language}{%
					{DE}{MCI\,\,\textbar\,\,%
						Die Unternehmerische Hochschule\textsuperscript{\textregistered}}
					{EN}{MCI\,\,\textbar\,\,%
						The Entrepreneurial School\textsuperscript{\textregistered}}}[]
				\hfill\textcolor{gray!75!black}{\Global@Degree} \\[1cm]
				{\Huge\textbf{\textcolor{mci2}{\Global@Title}}}
				\egroup\\[1cm]
				{\Large\Report@Cohort} \\[\baselineskip]
				{\Large\Report@Lecture}
				\normalsize

			\end{flushleft}
			%

			\vspace{\fill}

			\newcolumntype{b}{X}
			\newcolumntype{s}{>{\hsize=.5\hsize}X}
			\newcolumntype{g}{>{\hsize=\hsize}X}

			\Lang@English{%
				\vspace{-6ex}
				\begin{table}[!b]
					\centering
					\large
					\renewcommand{\arraystretch}{1.5}%
					\begin{tabularx}{\textwidth}{sb}
						\noindent\textcolor{gray!75!black}{\rule{\textwidth}{0.1mm}} \\
						\textbf{Author(s)}                     & \Student@Name       \\
						\textbf{Student ID(s)}\phantom{Circus} & \Global@StudentID   \\
						\IfEqCase{\Report@Mode}{%
							{Assignment}{\textbf{Supervisor}}
							{Lab}{\textbf{Lab Supervisor}}}[] & a                       \\
						\textbf{Cohort}                        & \Report@Cohort      \\
						\ifthenelse{\equal{\Report@Group}{unset}}{}{
							\textbf{Group}                         & \Report@Group   \\
						}
					\end{tabularx}
				\end{table}
			}

			\Lang@German{
				\begin{table}[!b]
					\centering
					\normalsize
					\renewcommand{\arraystretch}{1.2}%
					\begin{tabularx}{\textwidth}{g|b}
						\textbf{Autor(en)}              & \the\StudentName \\
						\textbf{Studierendenausweis(e)} & \the\StudentID   \\
						\textbf{Supervisor}             & \the\Supervisor  \\
						\textbf{Kohorte}                & \the\Cohort      \\
						\ifthenelse{\equal{\the\Group}{nil}}{}{
							\textbf{Gruppe}                 & \the\Group       \\
						}
						\textbf{Lektor}                 & \the\Lecturer    \\
					\end{tabularx}
					\normalsize
				\end{table}
			}
		\end{titlepage}
		\restoregeometry
		\cleardoublepage
	}

	\NewDocumentCommand{\TableOfContents}{}{
		% -- Define the way all Table of Contents are displayed.
		% -- An alteration is made by the assumption, the thesis will not be
		% -- printed. To decrease the amount of unnecessary white pages `\relax'
		% -- command is used for the `\tableofcontents'.
		\ifthenelse{\equal{\Thesis@ToC@Primary}{set}}{\let\clearpage\relax\tableofcontents}{}
		\begingroup
		\ifthenelse{\equal{\Thesis@ToC@Figures}{set}}{\listoffigures}{}
		\ifthenelse{\equal{\Thesis@ToC@Tables}{set}}{\listoftables}{}
		\endgroup
		\clearpage
		\newpage
		\pagenumbering{arabic}
		\pagestyle{scrheadings}
	}
	%
	%
	%
	\NewDocumentCommand{\Preamble}{}{
		% -- A collection command to print all necessary preamble.
		\MakeTitlePage%
		\TableOfContents%
	}
	%
	%
	%
	\AddToHook{begindocument/end}{%
		\Preamble%
	}%

	% HEADER / FOOTER SETTINGS ----------------------------------------------------------------
	%
	\RequirePackage[
		automark,
		headsepline = 0.25pt,
		footsepline = 0.25pt,
		autooneside = false,
	]{scrlayer-scrpage}
	%
	% Change the colors of the line
	\addtokomafont{headsepline}{\color{gray!50}}
	\addtokomafont{footsepline}{\color{gray!50}}
	%
	\clearpairofpagestyles
	%
	% Redefine the Chapter header so the prefix is bold
	\renewcommand{\chaptermark}[1]{%
		\markboth{\textcolor{black}{\textbf{Chapter \thechapter}}\ \ \ #1}{}
	}%
	% We now control the text of header/footer. Here, we make sure the chapter
	% text is `truncated' so the text does not overflow. Default is set to `0.65'
	\ihead{\truncate{0.65 \textwidth}{\leftmark}}
	\ohead{\rightmark}
	\ofoot{\thepage}
	\ifoot{\Global@StudentName}
	% 
	\renewcommand{\headfont}{\normalfont} % Change the font on the header.
	%
}{}




\RequirePackage{geometry}


\RequirePackage{floatrow}
\floatsetup[table]{capposition=top}
\floatsetup[figure]{capposition=bottom}

\usepackage[font=small,labelfont=bf]{caption}

\RequirePackage{
	amsmath,
	amssymb
}

\RequirePackage{listings}
\usepackage[]{xcolor}
\definecolor{codegreen}{rgb}{0,0.6,0}
\definecolor{codegray}{rgb}{0.5,0.5,0.5}
\definecolor{codepurple}{rgb}{0.58,0,0.82}
\definecolor{backcolour}{rgb}{0.95,0.95,0.92}

\definecolor{sbase03}{HTML}{002B36}
\definecolor{sbase02}{HTML}{073642}
\definecolor{sbase01}{HTML}{586E75}
\definecolor{sbase00}{HTML}{657B83}
\definecolor{sbase0}{HTML}{839496}
\definecolor{sbase1}{HTML}{93A1A1}
\definecolor{sbase2}{HTML}{EEE8D5}
\definecolor{sbase3}{HTML}{FDF6E3}
\definecolor{syellow}{HTML}{B58900}
\definecolor{sorange}{HTML}{CB4B16}
\definecolor{sred}{HTML}{DC322F}
\definecolor{smagenta}{HTML}{D33682}
\definecolor{sviolet}{HTML}{6C71C4}
\definecolor{sblue}{HTML}{268BD2}
\definecolor{scyan}{HTML}{2AA198}
\definecolor{sgreen}{HTML}{859900}

\definecolor{comment-green}{HTML}{008000} % #008000
\definecolor{function-blue}{HTML}{00000F}

\definecolor{codegreen}{rgb}{0,0.6,0}
\definecolor{codegray}{rgb}{0.5,0.5,0.5}
\definecolor{codepurple}{rgb}{0.58,0,0.82}
\definecolor{backcolour}{rgb}{0.95,0.95,0.95}


\lstdefinestyle{mainStyle}{
	% How/what to match
	sensitive=true,
	% Border (above and below)
	frame=single,
	% Extra margin on line (align with paragraph)
	%xleftmargin=\parindent,
	breakatwhitespace     = false,
	% Put extra space under caption
	belowcaptionskip=1\baselineskip,
	% -- Style Defitions
	backgroundcolor=\color{backcolour},
	commentstyle=\color{codegreen},
	keywordstyle=\color{magenta},
	numberstyle=\tiny\color{codegray},
	stringstyle=\color{codepurple},
	basicstyle=\ttfamily\footnotesize,
	% Break long lines into multiple lines?
	breaklines=true,
	captionpos=t, % Set caption-style at bottom.
	% Show a character for spaces?
	showstringspaces=false,
	tabsize=2,
	keepspaces=true,
	numbers=left,
	numbersep=5pt,
	showspaces=false,
	showstringspaces=false,
	showtabs=false,
	% numbers               = left,
	numbersep=3mm,
}
\lstset{style=mainStyle}

%


% GLOBAL ERROR CORRECTION CHECK ---------------------------------------------------------------
%
% First write documentation information regarding error.
%
\DocumentationError{dept-error}{%
	An unsupported option for `Department' was chosen
	in `\SetMCI'. Please use a supported option.
}{%
	An unsupported `deparment' was chosen. Please use a supported option.  }

\DocumentationError{state-error}{%
	An unsupported option for was entered as the `State'
	options for `mcidoc' class.
}{%
	An unsupported `deparment' was chosen. Please use a supported option.  }

\DocumentationError{lang-error}{%
	An unsupported option for `Language' was chosen
	in `\SetMCI'. Please use a supported option.
}{%
	An unsupported `deparment' was chosen. Please use a supported option.  }

\DocumentationError{degree-error}{%
	An unsupported option for `Degree' was chosen
	in `\SetMCI'. Please use a supported option.
}{%
	An unsupported `deparment' was chosen. Please use a supported option.  }

\DocumentationError{matrikelnumber-first-number-error}{%
	The first number of StudentID must start with 5.
}{%
	An unsupported `deparment' was chosen. Please use a supported option.  }
% 

\ExplSyntaxOn%
\clist_new:N \l_some_clist
\clist_set:Nn \l_some_clist {EN,DE}
\tl_set:Nx \l_element_b_str { \Global@Language}
% 
\NewDocumentCommand{\IfStringInList}{mmmm}{%
	% -- Control how the error messages are checked based on a given
	% -- predefined list.
	% -- #1 : The item to be checked within the list,
	% -- #2 : The list of allowed items,
	% -- #3 : The action if correct,
	% -- #4 : The action if wrong.
	{ \clist_if_in:NoTF {#1} {#2} {#3} {#4} }
}
% 
\AtEndDocument{
	% \IfStringInList { \Global@Degree }
	% {BSc, MSc} {}
	% {\msg_fatal:nn { mcidoc } { option / degree-error }}

	% \IfStringInList { \class@state }
	% {Report, Thesis, Slide, Poster, Paper, Notes} {}
	% {\msg_fatal:nn { mcidoc } { option / state-error }}

	% \IfStringInList { \Global@Department }
	% {MECH} {}
	% {\msg_fatal:nn { mcidoc } { option / dept-error }}

	\IfStringInList  \l_some_clist
	{\l_element_b_str }
	{}
	{\msg_fatal:nn { mcidoc } { option / lang-error }}
}
%
\ExplSyntaxOff%
%
% ---------------------------------------------------------------------------------------------
%  
% mcidoc.cls ends here
%  
\endinput
%
