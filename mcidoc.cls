\NeedsTeXFormat{LaTeX2e}[13-02-2025]  
\ProvidesClass{mcidoc}[13-02-2025 A documentclass for mci MECH Students]

\DeclareKeys{
  state.store       = \KEY@DOCUMENTSTATE,   % Declare the document state (Thesis | Report)
  lang.store        = \KEY@LANGUAGE,        % Define document language   (EN | DE)
  degree.store      = \KEY@DEGREE,          % Define degree level        (BSc | MSc)
  dept.store        = \KEY@DEPARTMENT,      % Define department          (MECH)
  bib-active.store  = \KEY@BIBLIOGRAPHY,    % (true | false)
  bib-style.store   = \KEY@BIBSTYLE,        % (ieee)
  column-type.store = \KEY@COLUMNTYPE,      % (one | two)
}

\ProcessKeyOptions\relax

\newtoks\Cohort 
\newtoks\Module
\newtoks\Lecture
\newtoks\Lecturer
\newtoks\Group\Group{nil}

\newtoks\Title
\newtoks\TitleHeader
\newtoks\Semester
\newtoks\StudentName
\newtoks\StudentID

\newtoks\Department 
\newtoks\StudyProgram
\newtoks\Supervisor
\newtoks\PrimaryAssessor
\newtoks\SecondaryAssessor

\newtoks\Authors
\newtoks\Affiliations

\RequirePackage{ifthen}

\RequirePackage{tikz}
\usetikzlibrary{calc}

\RequirePackage{graphicx}
\usetikzlibrary{}

\newcommand{\If@State}[2]{%
  \ifthenelse{\equal{\KEY@DOCUMENTSTATE}{#1}
  }{%
    #2
  }{%
    % 
  }%
}%

\If@State{Thesis}{%
  \LoadClass[%
  chapterprefix = true,%
  DIV           = 11,%
  paper         = A4,%
  fontsize      = 10,%
  twoside       = true,%
  openright%
  ]{scrreprt}%
}%

\If@State{Report}{
  \ifthenelse{
    \equal{\KEY@COLUMNTYPE}{one}
  }{
    \LoadClass[
    chapterprefix = true,
    DIV           = 22,
    paper         = A4,
    fontsize      = 10,
    twoside       = false,
    ]{scrreprt}
  }{
    \LoadClass[
    chapterprefix = true,
    DIV           = 22,
    paper         = A4,
    fontsize      = 10,
    twoside       = false,
    twocolumn
    ]{scrreprt}
    }
}

\If@State{Poster}{
    \LoadClass[
    25pt
    margin=0in,
    a0paper,
    ]{tikzposter}
}

\ExecuteOptions{}

\ifthenelse{%
  \equal{\KEY@BIBLIOGRAPHY}{true}
}{%
  \RequirePackage[
  backend = bibtex,
  style   = \KEY@BIBSTYLE,        
  ]{biblatex}     
}{}%

\newcommand{\Lang@English}[1]{%
  \ifthenelse{\equal{\KEY@LANGUAGE}{EN}%
  }{%
    #1
  }{%
  }%
}%

\newcommand{\Lang@German}[1]{%
  \ifthenelse{\equal{\KEY@LANGUAGE}{DE}
  }{%
    #1
  }{%
  }%
}%

\ifthenelse{%
  \equal{\KEY@DEPARTMENT}{MECH}%
}{%
  \Lang@English{\def\Department{Mechatronics}}%
  % 
  \Lang@German{\def\Department{Mechatronik}}
}{}%

\ifthenelse{\equal{\KEY@LANGUAGE}{EN}%
}{%
  \RequirePackage[english]{babel}    % <-- Allows english settings and typography
}{%
  \RequirePackage[ngerman]{babel}    % <-- Allows german settings and typography
}%

\ifthenelse{\equal{\KEY@DOCUMENTSTATE}{Thesis}
 }{

\newcommand\DeclarationOfNovelty{%

\ifthenelse{%
  \equal{\KEY@LANGUAGE}{EN}%
}{%

\section*{Declaration in Lieu of Oath}

I hereby declare, under oath, the thesis titled,
% 
\begin{center}
  \textit{\the\Title}
\end{center}
% 
has been my independent work and has not been aided
with any prohibited means as declared 
by the program and/or the institution. \\

I declare, to the best of my knowledge and belief, that
all passages taken from published, unpublished sources
have been reproduced as original, slightly changed,
have been mentioned and sources have been cited
accordingly as required by academic academic standards
decreed by the institution and the program \\[5\baselineskip]

\vspace{\fill}

\rule{5cm}{0.2pt}\hfill\rule{5cm}{0.2pt}\\
\phantom{Placeholder}Place, Date\hfill Signature\hspace{15mm}

}{%

\section*{Eidesstattliche Erklärung}
Ich erkl\"are hiermit an Eides statt, dass ich die vorliegende
Arbeit selbst"andig angefertigt habe. Die aus fremden
Quellen direkt oder indirekt \"ubernommenen Gedanken sind
als solche kenntlich gemacht. Die Arbeit wurde bisher weder
in gleicher noch in \"ahnlicher Form einer anderen
Pr\"ufungsbeh\"orde vorgelegt und auch noch nicht
ver\"offentlicht.\\[5\baselineskip]

\vspace{\fill}

\rule{5cm}{0.2pt}\hfill\rule{5cm}{0.2pt}\\
\phantom{Datum }Ort, Datum\hfill Unterschrift\hspace{15mm}

}
\cleardoublepage
}

\newcommand{\ThesisEmbargoRequest}[1][5]{

% 
\ifthenelse{%
  \equal{\KEY@LANGUAGE}{EN}
}{%

\section*{Preclusion from Public Access}

I have requested preclusion from public
access for the work titled,
% 
\begin{center}
  \textit{\the\Title}
\end{center}
% 
which was approved by the \the\year\, study program,
and therefore has been blocked from
public domain until the
date of 31.07.\fpeval{\the\year + #1}.

\vspace{\fill}

\rule{5cm}{0.2pt}\hfill\rule{5cm}{0.2pt}\\
\phantom{Placeholder}Place, Date\hfill Signature\hspace{15mm}

}{

\section*{Ausschluss vom öffentlichen Zugang}
Ich habe den Ausschluss der öffentlichen
Zugänglichkeit für die Arbeit mit dem Titel
% 
\begin{center}
  \textit{\the\Title}
\end{center}
% 
beantragt, die vom Studienprogramm \the\year\, genehmigt
wurde und daher gesperrt wurde
bis zum Datum 31.07.\engord{\numexpr{\the\year + #1}\relax}
gemeinfrei.


\vspace{\fill}

\rule{5cm}{1pt}\hfill\rule{5cm}{1pt}\\
\phantom{Datum }Ort, Datum\hfill Unterschrift\hspace{15mm}

}
\cleardoublepage
}

\newcommand{\TableOfContents}{
  \tableofcontents
  \listoffigures
  \listoftables
  % 
  \clearpage
  \pagenumbering{arabic}
  % 
  \pagestyle{scrheadings}
}

\newcommand\MakeTitlePage{
  %
  % Make sure the page has no header/footer
  \pagestyle{empty}
  %
  % Break geometry and create a new one
  \newgeometry{%
    margin = 3cm,
    top    = 3cm,
  }%
  % Put the title on centre-stage
  \begin{titlepage}
    \vspace*{15ex}
    \begin{center}
      \LARGE \noindent\kern-1pt\textbf{\the\Title}
    \end{center}
    % 
    \centering
    %
    % Put the mci-logo on the page in upper right.x
    %
    \begin{tikzpicture}[remember picture, overlay]
      \node at (7,5) {\includegraphics{img/mci-logo.pdf}};
    \end{tikzpicture}

    % Put the subtitle text whether it is M.Sc or B.Sc
    \begin{center}
      \ifthenelse{%
        \equal{\KEY@DEGREE}{MSc}%
      }{%
        \ifthenelse{%
          \equal{\KEY@LANGUAGE}{EN}%
        }{%
          \LARGE \textbf{Master Thesis}%
        }{%
          \LARGE \textbf{Master Artbeit}%
        }%
      }{%
        \ifthenelse{%
          \equal{\KEY@LANGUAGE}{EN}%
        }{%
          \LARGE \textbf{Bachelor Thesis}%
        }{%
          \LARGE \textbf{Bachelor Artbeit}%
        }%
      }%
    \end{center}

    \vspace{4ex}

    % Add the fullfilment text
    \ifthenelse{%
      \equal{\KEY@LANGUAGE}{EN}%
    }{%
      \Large In partial fulfillment of the requirements for the degree%
    }{%
      \Large zur Erlangung des akademischen Grades%
    }%

    \vspace{1ex}

    % Add which degree is it from.
    \ifthenelse{%
      \equal{\KEY@DEGREE}{BSc}%
    }{%
      \Large {\em Bachelor of Science in Engineering}%
    }{%
      \Large {\em Master of Science in Engineering}%
    }%

    \vspace{\fill}

    % Add a third (!?) declaration of degree
    \ifthenelse{%
      \equal{\KEY@DEGREE}{BSc}%
    }{%
      \Large {Bachelor Program}%
    }{%
      \Large {Master Program}%
    }%

    \vspace{1ex}%

    {\normalsize Mechatronics \& Smart Technologies:}

    \vspace{1ex}

    {\normalsize Management Center Innsbruck}

    \vspace{8ex}

    {\Large Supervisor} 

    \vspace{1ex}

    {\Large \the\Supervisor}

    \vspace{8ex}

    {\Large Author}

    \vspace{1ex}

    {\Large \the\StudentName}

    \vspace{1ex}

    {\Large \the\StudentID}

  \end{titlepage}
  %
  %
  \restoregeometry
  %
  \cleardoublepage
}%

\RequirePackage[
automark,
headsepline,
footsepline,
autooneside  = false
]{scrlayer-scrpage}

\clearpairofpagestyles

\ihead{\MakeUppercase{\leftmark}}
\ohead{\rightmark}
\ofoot{\thepage}
\ifoot{\the\StudentName}
\renewcommand{\headfont}{\normalfont}

}{}

\ifthenelse{\equal{\KEY@DOCUMENTSTATE}{Report}
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
        \node at ([xshift=-7cm, yshift=7cm]current page.center) {
          \includegraphics[scale=7]{img/mci-logo-outline.pdf}
        };
      \end{tikzpicture}
      % 
      \begin{flushleft}
        %
        % Include \noindent and \kern as a patch for the beginning line
        {\Large\the\TitleHeader \\[\baselineskip]
        {\Huge\textbf{\textcolor{black}{\the\Title}}}} \\[\baselineskip]
        {\Large\the\Cohort} \\[\baselineskip]
        {\Large \the\Lecture}
        \normalsize 

      \end{flushleft}
      %

      \vspace{\fill}

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

\newcommand{\TableOfContents}{
  \tableofcontents
  \listoffigures
  \listoftables
  % 
  \clearpage
  \pagenumbering{arabic}
  % 
  \pagestyle{scrheadings}
}

\RequirePackage[
automark,
headsepline,
footsepline,
autooneside  = false
]{scrlayer-scrpage}

\clearpairofpagestyles
 
\ihead{\MakeUppercase{\leftmark}}
\ohead{\rightmark}
\ofoot{\thepage}
\ifoot{\the\StudentName}
\renewcommand{\headfont}{\normalfont}

}{}

\ifthenelse{\equal{\KEY@DOCUMENTSTATE}{Poster}
 }{

\renewcommand\TP@maketitle{%
  
  \begin{tikzpicture}[overlay, remember picture]
    \draw[fill=mci2,draw=none]
    (current page.north west) rectangle
    ([xshift=0cm, yshift=-20cm]current page.north east);

    \node[%
    execute at begin node = \linespread{1.5}\selectfont,
    font=\Huge,
    text width=60cm,
    align=left,
    ] at ([xshift=32.5cm, yshift=-2cm]current page.north west) {\bf \textcolor{white}{\the\Title}};
 
    \draw[line width=4pt,draw=mci2!70!white]
    ([xshift=2.5cm, yshift=-11cm]current page.north west) -- ([xshift=-22cm, yshift=-11cm]current page.north east);
 
    \node[font=\LARGE,text width=60cm, align=left] at
    ([xshift=32.5cm, yshift=-12cm]current page.north west) {\it \textcolor{white}{\the\Authors}};

   
     \node[font=\Large,text width=60cm, align=left] at
    ([xshift=32.5cm, yshift=-15cm]current page.north west) {\textcolor{white}{\the\Affiliations}};

      \draw[fill=mci2!95,draw=none]
      (current page.north east) rectangle
      ([xshift=-15cm, yshift=-20cm]current page.north east);

      
      \draw[fill=mci2!90,draw=none]
      (current page.north east) rectangle
      ([xshift=-7.5cm, yshift=-20cm]current page.north east);

      \draw[fill=mci2!75,draw=none] 
      (current page.north east) rectangle
      ([xshift=-2.5cm, yshift=-20cm]current page.north east);

      \node[rotate=90, align=left, text width=20cm] at
      ([xshift=-2.25cm, yshift=-9cm]current page.north east) {\textcolor{mci2!70!black}{\Department}};

% 
\ifthenelse{%
  \equal{\KEY@LANGUAGE}{EN}
}{%
      \node at
      ([xshift=-11cm, yshift=-9cm]current page.north east)
      {\includegraphics[scale=2]{img/mci-logo-neg-EN.pdf}};
      }
 
\ifthenelse{%
  \equal{\KEY@LANGUAGE}{DE}
}{%
      \node at
      ([xshift=-11cm, yshift=-9cm]current page.north east)
      {\includegraphics[scale=2]{img/mci-logo-neg-DE.pdf}};
      }
      
  \end{tikzpicture}
  ~
  \begin{tikzpicture}
  \draw[fill=none, draw=none]
    (current page.north west) rectangle
    ([xshift=-25cm, yshift=-20cm]current page.north east);
  \end{tikzpicture}
}

\usetheme{Simple}
\usetitlestyle{Empty}

% We use one of the mci colours for the header
\definecolor{mci2}{HTML}{004983}

\AtEndOfClass{
  \usepackage[scaled]{helvet}
  \renewcommand\familydefault{\sfdefault} 
  \usepackage[T1]{fontenc}
}

\defineblockstyle{Minimal}{
  titlewidthscale   = 1,
  bodywidthscale    = 1,
  titleleft, 
  titleoffsetx      = 0pt,
  titleoffsety      = 0pt,
  bodyoffsetx       = 0pt,
  bodyoffsety       = 0pt,
  bodyverticalshift = 0pt,
  roundedcorners    = 0,
  linewidth         = 0.1cm,
  titleinnersep     = 1cm,
  bodyinnersep      = 1cm 
}{
  \begin{scope}[line width=\blocklinewidth, rounded corners=\blockroundedcorners]
    \ifBlockHasTitle %
      \draw[draw=none]
      (blockbody.south west) rectangle (blocktitle.north east);
      \draw[draw=gray, dotted] 
      (blocktitle.south west) -- (blocktitle.south east);%
    \else
      \draw[draw=none]
      (blockbody.south west) rectangle (blockbody.north east);
    \fi
  \end{scope}
}

\newcounter{tablecounter}
\newenvironment{tikztable}[1][]{
  \def \rememberparameter{#1}
  \vspace{10pt}
  \refstepcounter{tablecounter}
  \begin{center}
  }{
    \ifx\rememberparameter\@empty
    \else
    \\[10pt]
    {\small Tab.~\thetablecounter: \rememberparameter}
    \fi
  \end{center}
}

\newcommand{\MakeTitlePage}{
  \node[above right,
  outer sep=0pt,
  minimum width=\paperwidth,
  minimum height=3cm,
  align=center,font=\normalsize,
  draw=none,fill=gray!30,
  ultra thick] at ([shift={(0.5*\pgflinewidth,0.5*\pgflinewidth)}]bottomleft) {%
    MCI | 6020 Innsbruck / Austria, Universit\"atsstra{\ss}e 15 | + 42 512 2070 | office@mci.edu
  };

  \node[above right,
  outer sep=0pt,
  minimum height=1.8cm,
  minimum width=7cm,
  align=left,font=\normalsize,
  draw=none, fill=gray!30] at ([yshift=3cm]bottomleft) {};

  \node[above right,
  outer sep=0pt,
  minimum height=1.8cm,
  minimum width=0.9cm,
  align=left,font=\normalsize,
  draw=none, fill=gray!15] at ([xshift=7cm, yshift=3cm]bottomleft) {};

  \node[above right,
  outer sep=0pt,
  minimum height=0.9cm,
  minimum width=1.8cm,
  align=left,font=\normalsize,
  draw=none, fill=gray!15] at ([xshift=7cm, yshift=3cm]bottomleft) {};

  \node[above right,
  outer sep=0pt,
  minimum height=0.9cm,
  minimum width=0.9cm,
  align=left,font=\normalsize,
  draw=none, fill=gray!25] at ([xshift=7cm, yshift=3cm]bottomleft) {};

  \node[above right,
  outer sep=0pt,
  minimum height=1cm,
  align=left,font=\normalsize,
  draw=none] at ([xshift=-1cm, yshift=-0.9cm]bottomleft) {%
	\includegraphics[scale=1.2]{%
      img/mci-logo.pdf}
  };
  \maketitle
}

}{}

\RequirePackage{Gudea}  
\RequirePackage[T1]{fontenc}

\RequirePackage{setspace}
\setstretch{1.25}

\RequirePackage{geometry}

\RequirePackage{siunitx}

\RequirePackage{tabularx}

\RequirePackage{array, booktabs, multirow}

\RequirePackage{enumitem} 
\setlist[itemize]{label=$\blacksquare$}

\RequirePackage{pgfplots}

\usepackage[font=small,labelfont=bf]{caption}

\RequirePackage{
  amsmath,
  amssymb
}

\RequirePackage{listings}

  \definecolor{codegreen}{rgb}{0,0.6,0}
  \definecolor{codegray}{rgb}{0.5,0.5,0.5}
  \definecolor{codepurple}{rgb}{0.58,0,0.82}
  \definecolor{backcolour}{rgb}{0.95,0.95,0.92}

  \lstdefinestyle{mainStyle}{
    backgroundcolor       = \color{white},
    commentstyle          = \color{codegreen},
    keywordstyle          = \color{magenta},
    numberstyle           = \tiny\color{codegray},
    stringstyle           = \color{codepurple},
    basicstyle            = \ttfamily\footnotesize,
    breakatwhitespace     = false,
    breaklines            = true,
    captionpos            = b,
    frame                 = l,
    keepspaces            = true,
    numbers               = left,
    numbersep             = 10pt,
    showspaces            = false,
    showstringspaces      = false,
    showtabs              = false,
    tabsize               = 2
  }
  \lstset{style=mainStyle} % \(^.^)/
