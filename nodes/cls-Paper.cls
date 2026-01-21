\usepackage[nohints]{minitoc}
\mtcsetrules{minitoc}{off}
\newcommand{\dochaptertoc}{%
  \vspace{1.85\baselineskip} % workaround for removed rule
  \smash{\makebox[\linewidth]{\hrulefill}} % workaround for removed rule
  \vspace{-1.85\baselineskip} % workaround for removed rule 
  \minitoc
  \vspace{-1.15\baselineskip} % workaround for removed rule
  \smash{\makebox[\linewidth]{\hrulefill}} % workaround for removed rule
  \vspace{1.15\baselineskip} % workaround for removed rule
}
\newcommand{\setchaptertoc}{%
  \setchapterpreamble{% KOMA-Script command
    \dochaptertoc%
  }}
 
\newgeometry{left=1in, right=1in, bottom=1in, top=0.75in}

\pretocmd{\printbibliography}{\section*{Bibliography}}{}{}

\makeatletter
\renewcommand{\thesection}{\@Roman{\c@section}}
\renewcommand{\theequation}{\@arabic\c@section}
\makeatother
 
\makeatletter
\renewcommand{\sectionlinesformat}[4]{%
    %\@tempswafalse
        \ifstr{#1}{section}{%
                \centering\mbox{\@hangfrom{{#3}{#4}}}
        }
        {\ifstr{#1}{subsection}{%
                \centering\mbox{\@hangfrom{{#3}{#4}}}%
        }
    {\@hangfrom{\hskip#2#3}{#4}}}%
}\makeatother

\usepackage{multicol}

\definecolor{mci2}{HTML}{004983}
\renewenvironment{abstract}
    {\textbf{Abstract -- }\itshape}
    { }

    \AtBeginDocument{\begin{flushleft}
  \begin{tikzpicture}[overlay, remember picture]
  \node at ([xshift=-7cm, yshift=11cm]current page.center) {
    \includegraphics[scale=4]{img/mci-logo-outline.pdf}
  };
\end{tikzpicture} 
  {\Large\the\TitleHeader\vspace*{\fill}\quad{\textit{\Large\the\Lecture}}\quad{\Large\the\Cohort} \\[0.5\baselineskip]
    {\Huge\textcolor{mci2}{\textbf{\textcolor{black}{\the\Title}}}}} \\[\baselineskip]
  \normalsize 
  % 
\end{flushleft}
\begin{multicols}{2}}

\AtEndDocument{\end{multicols}}

\endinput
