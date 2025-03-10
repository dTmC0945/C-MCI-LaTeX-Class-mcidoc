% ---------------------------------------------------------------------------------------------
% 
% MCI LaTeX Documentation Re-Caffeinated !! -DTMc
% -----------------------------------------------
% 
% INTRODUCTION
% ------------
% 
% This is a LaTeX document formatting designed to cater to all possible student requirements
% regarding:
% - document preparation,
% - presentation,
% - poster,
% - and thesis writing.
% All the aforementioned documents are bundled up as a class called mcidoc.
% 
% PURPOSE
% -------
% The main ethos of this class is to standardise and streamline document creation which abides
% to the standards set by the institution with regards to:
% - the font-size,
% - page spacing,
% - line spacing,
% - caption style,
% - languages specific settings
% - header/footer styles
% and so on so forth.
% 
% A second goal it to create a repository to house a standard class to minimise any friction
% between your work and the presentation. Therefore care was given to how the class behaves
% to minimise the dependencies it needs and give you key/value pairs to modify the document
% as you see fit.
% 
% 
% NOTE: This class has been tested on different computers, different OSs and LuaTeX
% : and pdfTeX. However, as with everything, there will always be edge cases and I am sure
% : to that end, if you let me know anonymously or just let me know via email, I can 
% : squash the bugs or add any feature it may seem necessary.
% 
% 
% WARNING: While I will try to help with any problem this class might have, it is by no means
% : I am providing any kind of WARRANTY or TECHNICAL SUPPORT. There will be
% : documentation and some example documents which should compile without any
% : additional configuration. Nevertheless, I can only help with the errors from code
% : and not with your personal LaTeX development environment (i.e., TeXStudio).
% 
% -DTMc
% 
% CLASS HEADER --------------------------------------------------------------------------------
% 
\NeedsTeXFormat{LaTeX2e}[13-02-2025]  % Define minimum requirements fro the class
\ProvidesClass{mcidoc}[13-02-2025]    % Give class information and description.

\def\mci@version{1.00}                % Define the mcidoc version

\RequirePackage{ifthen}               % Allows conditional statements,
% LINK: https://mirror.kumi.systems/ctan/macros/latex/base/ifthen.pdf
% 
% -- DEFINE KEYS FOR THE MCIDOC CLASS ---------------------------------------------------------

\DeclareKeys{
  % Global Keys
  state.store       = \DocState,       % Declare the document state (Thesis | Report | Slide)
  lang.store        = \Lang,           % Define document language   (EN | DE)
  degree.store      = \Degree,         % Define degree level        (BSc | MSc)
  dept.store        = \Dept,           % Define department          (mech)
  code-engine.store = \CodeEngine,     % Define code environment    (listings | minted)
  title-page.store  = \TitlePageStyle  % Define title page style    (standard | nouveau)
}

\ProcessKeyOptions\relax        % Process the key options


% \DeclareOption*{
% \PassOptionsToClass{
% \CurrentOption
% }{
% 		scrreprt
% }
% }


\ProcessOptions\relax

% REQUIRED GLOBAL PACKAGES --------------------------------------------------------------------
% 
% These are the packages which are needed by the class itself to function properly.
% This section is heavily monitored to remove even the slightest amount of redundancy as
% The point of this document to make your life easy and not to debug...
% 
% 
\RequirePackage{graphicx}      % For loading images/graphics
% LINK: https://mirror.kumi.systems/ctan/macros/latex/required/graphics/grfguide.pdf

% Include mathematical packages
\RequirePackage{
  amsmath,
  amssymb
}


\RequirePackage{tikz}

\RequirePackage{siunitx}

\usetikzlibrary{
  calc
}

\usepackage{tikzpagenodes}

\RequirePackage{xcolor}
\definecolor{mci2}{HTML}{004983}

% A simple wrapper command to check which state is currently active and does an action
% 
% ARGUMENTS
% ---------
% 1: The state of the document (i.e., Report, Thesis, ...)
% 2: The action to be taken

\newcommand{\If@State}[2]{
  \ifthenelse{\equal{\DocState}{#1}
  }{
    #2
  }{

  }
}


% CONDUCT THE CLASS SELECTION -----------------------------------------------------------------
% 
% As you can see I am not really creating anything from scratch. No one does as almost every
% document class is a super set of one another.

\If@State{Thesis}{
  \LoadClass[
  chapterprefix = true,
  DIV           = 11,
  paper         = A4,
  fontsize      = 11,
  twoside       = true,
  openright
  ]{scrreprt}
}


\If@State{Slide}{
  \LoadClass[
  ]{beamer}
}


\If@State{Report}{
  \LoadClass[
  chapterprefix = true,
  DIV           = 22,
  paper         = A4,
  fontsize      = 11,
  twoside       = false,
  ]{scrreprt}
}

\If@State{Poster}{
  \LoadClass[
  25pt,
  a0paper,
  portrait
  ]{tikzposter}
}

\ExecuteOptions{} % END OF OPTIONS ------------------------------------------------------------

% HEADER SETTINGS -----------------------------------------------------------------------------

% Contains the header and footer information of the classes
\If@State{Thesis}{

  \RequirePackage[
  automark,
  headsepline,
  autooneside  = false
  ]{scrlayer-scrpage}

  \clearpairofpagestyles

  \ihead{\leftmark}
  \ohead{\rightmark}
  \renewcommand{\headfont}{\normalfont}
}

\If@State{Report}{

  \RequirePackage[
  automark,
  headsepline,
  footsepline,
  autooneside = false
  ]{scrlayer-scrpage}

  \clearpairofpagestyles

  \ihead{\leftmark}
  \ohead{\rightmark}
  \rofoot{\pagemark}
  \ifoot{\the\StudentName}
	\renewcommand{\headfont}{\normalfont}
  }

  \usepackage{setspace}
  \setstretch{1.15}

  % Contains the header and footer information of the classes
  % Define the global font style for all documents

  \usepackage[T1]{fontenc}
  \usepackage[sfdefault]{AlegreyaSans}  % Option 'black' gives heavier bold face
  % The 'sfdefault' makes the base font sans serif
  \renewcommand*\oldstylenums[1]{{\AlegreyaSansOsF #1}}

  % CAPTION SETTINGS ----------------------------------------------------------------------------

  % Define font setting and caption heading which conform to the MCI standards as per
  % documented in their style guide.
  \ifthenelse{
	\equal{\DocState}{Report}
  \or
	\equal{\DocState}{Thesis}
  }{
	% make captions bold
	\setkomafont{captionlabel}{\bfseries}
	% turn captions small font
	\addtokomafont{caption}{\small}

	\RequirePackage{float, scrhack} % Use this to force captions to be in a specific shape
	% no matter where it is written

	\floatstyle{komaabove}          % make captions above for tables
	\restylefloat{table}            %
  }{}



  \usepackage{geometry}

  % GLOBAL TOKEN LIST ---------------------------------------------------------------------------
  % 
  % Here is a list of all the tokens used by the classes. Almost all are used 
  % 
  \newtoks\StudentName
  \newtoks\StudentID

  \newtoks\Cohort
  \newtoks\Module
  \newtoks\Lecture
  \newtoks\Lecturer
  \newtoks\Group\Group{nil}

  \newtoks\ThesisTitle

  \newtoks\TitleHeader
  \newtoks\Title
  \newtoks\Semester

  \newtoks\Department
  \newtoks\StudyProgram
  \newtoks\Supervisor
  \newtoks\PrimaryAssessor
  \newtoks\SecondaryAssessor

  % ---------------------------------------------------------------------------------------------




  % FIX COMES FROM: https://tex.stackexchange.com/questions/635663/package-tocbasic-is-used-twice-when-tcolorbox-minted-and-scrhack-is-used
  \AddToHook{begindocument/before}{\@ifpackageloaded{minted}{\removefromtoclist[float]{lol}}{}}

  \RequirePackage{etoolbox}
  \RequirePackage[most]{tcolorbox}
  \RequirePackage{tabularx}

  \RequirePackage{enumitem}
  % \def\labelitemi{$\blacksquare$}
  \setlist[itemize]{label=$\blacksquare$}

  % DEFINE QUICK CONDITIONAL COMMANDS -----------------------------------------------------------

  % For situations for the English Language
  \newcommand{\Lang@English}[1]{
	\ifthenelse{\equal{\Lang}{EN}
	}{
      #1
	}{
	}
  }

  % For situations for the German Language
  \newcommand{\Lang@German}[1]{
	\ifthenelse{\equal{\Lang}{DE}
	}{
      #1
	}{
	}
  }

  % DEPARTMENTAL CODES -------------------------------------------------------------------------

  % Mechatronics Department
  \ifthenelse{
	\equal{\Dept}{MECH}
  }{
	\Lang@English{\def\Department{Mechatronics}}

	\Lang@German{\def\Department{Mechatronik}}
  }{}

  % Smart Building Technologies Department
  \ifthenelse{
	\equal{\Dept}{SBT}
  }{
	\def\Department{Smart Building Technologies}
  }
  {}


  % DESIGNATING CODE ENGINE ---------------------------------------------------------------------

  % Coding makes the world go round and of course it is also important to showcase all your
  % important code in your report/thesis and for that LaTeX got you covered. This class supports
  % out of the box two (2) types of packages to showcase your good-looking code:
  % 
  % --- minted
  % 
  % --- listings
  % 
  % 
  % It is a worthy discussion to ask why did I have to come up with two packages which do the
  % same thing ?! Well,.... yeah but I have a legitimate reason you see. While minted is the
  % far superior option, it requires what is called a "shell escape". This basically means that
  % the minted package needs to access your shell interpreter to do its thing which can be seen
  % as a security issue (which is a good reason). To enable this, one must run their LaTeX in
  % shell escape mode and this can be a bit laborious so some might want to avoid this....
  % 
  % listings on the other hand is pure-bred LaTeX solution and does not need any -shell-escape
  % and can be used without modifications to your compilation.
  % 
  % If you are going to use Overleaf (Why tho?) both options are valid so it is up to you as
  % both were customised to look almost identical to each other.
  % 
  % 
  \ifthenelse{
	\equal{\CodeEngine}{minted}
  }{
	\RequirePackage{minted}
	\setminted{
      linenos,
      fontsize   = \scriptsize,
      autogobble,
      numbersep  = 7mm,
      breaklines = true,
	}


	\BeforeBeginEnvironment{minted}{
      \begin{tcolorbox}[
        colback = gray!10,
        arc     = 0mm,
        boxrule = 0pt,
        frame hidden,
        breakable
        ]}%

      \AfterEndEnvironment{minted}{\end{tcolorbox}}%
  }{
	\ifthenelse{
      \equal{\CodeEngine}{listings}
	}{



      \RequirePackage{listings}

      \definecolor{codegreen}{rgb}{0,0.6,0}
      \definecolor{codegray}{rgb}{0.5,0.5,0.5}
      \definecolor{codepurple}{rgb}{0.58,0,0.82}
      \definecolor{backcolour}{rgb}{0.95,0.95,0.92}

      \lstdefinestyle{mystyle}{
        backgroundcolor       = \color{gray!10},
        commentstyle          = \color{codegreen},
        keywordstyle          = \color{magenta},
        numberstyle           = \tiny\color{codegray},
        stringstyle           = \color{codepurple},
        basicstyle            = \ttfamily\footnotesize,
        breakatwhitespace     = false,
        breaklines            = true,
        captionpos            = b,
        keepspaces            = true,
        numbers               = left,
        numbersep             = 5pt,
        showspaces            = false,
        showstringspaces      = false,
        showtabs              = false,
        tabsize               = 2
      }


      \lstset{style=mystyle}
	}{
      \ifthenelse{
        \equal{\CodeEngine}{none}
      }{
      }{
      }

	}
  }
  % LANGUAGE SUPPORT ----------------------------------------------------------------------------
  % 
  % As this is a place where more than two (2) languages are used for teaching and examination
  % purposes, surely we need to abide by the rules set by the languages such as the way certain
  % content is written or how quotation is done in mid text.
  % 
  % This document supports two (2) languages:
  % 
  % - English: through the EN option in the class
  % - German:  through the DE option in the class
  % 
  % It was considered whether the LaTeX commands should also be translated but this idea was
  % scrapped quickly. I do not have the time to rewire the LaTeX system commands.
  % 
  % 
  \ifthenelse{\equal{\Lang}{EN}
  }{
	\RequirePackage[english]{babel}    % <-- Allows english settings and typography
  }{
	\RequirePackage[ngerman]{babel}    % <-- Allows german settings and typography
  }
  % 
  % 
  % LOAD CLASS SPECIFIC OPTIONS -----------------------------------------------------------------

  % Depending on the class chosen by the user (Report | Slide | Thesis | Poster) some specific
  % configuration is needed. Special care also needs to be taken when handling the Slide class
  % as it behaves significantly different compared to other classes.

  % TODO: Write the Poster Class

  % Load class-specific options/commands for Report:
  % REPORT : A Document state for all your needs for
  % : lab reports, assignment submission and
  % : anything in between. As an additional
  % : setting minted or listing are embedded
  % : so it is a matter of activating them
  % : by choosing the code-engine state.
  \ifthenelse{\equal{\DocState}{Thesis}
  }{

	% Report specific settings/commands
	\input{classes/Thesis/thesis-pool.sty}

	% Different title pages
	\input{classes/Thesis/title-page.sty}
  }{}


  % Load class-specific options/commands for Report
  \ifthenelse{\equal{\DocState}{Report}
  }{

    \def\TableOfContents{
      \tableofcontents
      % 
      \clearpage
      \pagenumbering{arabic}
      % 
      \pagestyle{scrheadings}

    }


    % Define the Title Page for the Report Option "nouveau"

    \ifthenelse{\equal{\TitlePageStyle}{nouveau}
    }{
      \newcommand{\MakeTitlePage}{

        \pagestyle{empty} % Define page style as empty (i.e., no header & footer)

        % Define new geometry for the title page (this will be reset later)
        \newgeometry{
          margin = 3cm,
          top    = 3cm} 

        \begin{titlepage}
          % 
          \begin{flushleft}
            % 
            % First Row of text with MCI on left and department on right
            \Lang@English{
              \MakeUppercase{MCI | The Entrepreneurial School}
            }
            \Lang@German{
              \MakeUppercase{MCI | Die Unternehmerische Hochschule}
            }
            \hfill
            \MakeUppercase{\textbf{\Department}} \\
            % 
            % Second row containing the degree of and it's corresponding study program
            \Degree\hfill\the\StudyProgram\\[1\baselineskip]
            
            \hfill \tiny Made with mcidoc v.\mci@version\\[2\baselineskip]

            \Large
            % 
            \the\TitleHeader\\

            % Write down the title of the report in Huge fort with mci M.Sc colours for flare
            % Include \noindent and \kern as a patch for the beginning line
            \Huge\textcolor{mci2}{\textbf{\the\Title}}

            \vspace{1ex}

            % Write down the name of the lecture (not module) under title
            \Large \the\Lecture \\
            \normalsize \the\Semester

          \end{flushleft}
          % 

          \centering

          \vfill
          \newcolumntype{b}{X}
          \newcolumntype{s}{>{\hsize=.5\hsize}X}
          \newcolumntype{g}{>{\hsize=.8\hsize}X}

          \Lang@English{
            \begin{table}[!b]
              \centering
              \normalsize
              \renewcommand{\arraystretch}{1.2}%
              \begin{tabularx}{\textwidth}{s|b}
                \textbf{Author(s)}                     & \the\StudentName \\
                \textbf{Student ID(s)}\phantom{Circus} & \the\StudentID   \\
                \textbf{Supervisor}                    & \the\Supervisor  \\
                \textbf{Cohort}                        & \the\Cohort      \\
                \ifthenelse{\equal{\the\Group}{nil}}{}{
                \textbf{Group}                         & \the\Group       \\
                }
                \textbf{Lecturer}                      & \the\Lecturer    \\
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
    }{
    }



    \ifthenelse{\equal{\TitlePageStyle}{tudor}
    }{
      \newcommand{\MakeTitlePage}{

        
        \pagestyle{empty} % Define page style as empty (i.e., no header & footer)

        % Define new geometry for the title page (this will be reset later)
        \newgeometry{
          margin = 3cm,
          top    = 3cm} 
        
        \begin{titlepage}
          % 
          \begin{tikzpicture}[overlay, remember picture]
            \node at ([xshift=-7cm, yshift=6cm]current page.center) {
              \includegraphics[scale=7]{/Users/danielmcguiness/GitHub/MCI-Source-Files/Configuration/ScriptsTeX/mcidoc/mci-logo-outline.pdf}
            };
          \end{tikzpicture}
          % 
          \begin{flushleft}
            % 
            % Include \noindent and \kern as a patch for the beginning line
            \Huge\textbf{\the\TitleHeader\,:\,\textcolor{black}{\the\Title}}
            
            \vspace{1ex}

            % Write the cohort as it is
            \Large\the\Cohort 
            
            \vspace{1ex}

            % Write down the name of the lecture (not module) under title
            \Large \the\Lecture \\
            \normalsize 

          \end{flushleft}
          % 



          \vfill

          \begin{flushleft}
            % 
            \Large \Degree\, Degree Course -  \the\StudyProgram \\
            \the\Semester \\
            \textbf{Lecturer}\,:\,\the\Lecturer \\
            \textbf{Group}\,:\,\the\Group \\
            \textbf{Author(s)}:\, \the\StudentName \\
            % 
          \end{flushleft}

          
          
          \newcolumntype{b}{X}
          \newcolumntype{s}{>{\hsize=.5\hsize}X}
          \newcolumntype{g}{>{\hsize=.8\hsize}X}

          \Lang@English{
            \begin{table}[!b]
              \centering
              \normalsize
              \renewcommand{\arraystretch}{1.2}%
              \begin{tabularx}{\textwidth}{s|b}
                \textbf{Author(s)}                     & \the\StudentName \\
                \textbf{Student ID(s)}\phantom{Circus} & \the\StudentID   \\
                \textbf{Supervisor}                    & \the\Supervisor  \\
                \textbf{Cohort}                        & \the\Cohort      \\
                \ifthenelse{\equal{\the\Group}{nil}}{}{
                \textbf{Group}                         & \the\Group       \\
                }
                \textbf{Lecturer}                      & \the\Lecturer    \\
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
          \hfill \tiny Made with mcidoc v.\mci@version\\[2\baselineskip]
        \end{titlepage}
        \restoregeometry
        \cleardoublepage
      }
    }{
    }
	
  }{}


  \usepackage{pgfplots}

  \usepackage{array, booktabs, multirow}

  % \usepackage{titlesec}

  % \input{classes/Thesis/thesis-pool.sty}


  \endinput

  % --------------------------------------------------------------------------------------- -DTMc
