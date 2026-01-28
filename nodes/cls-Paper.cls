% Class `Paper' for use in making two-column papers. Used in `B.Sc Academic Writing'.
%
% ---------------------------------------------------------------------------------------------
%
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
%
% Here we define the new paper geometry to better match with the `IEEE-tran' standard.
\RequirePackage{geometry}
\newgeometry{%
  left   = 1in,%
  right  = 1in,%
  bottom = 1in,%
  top    = 0.75in%
}%
%

\definecolor{mci2}{HTML}{004983}

\usepackage{tikz}
\pgfkeys{/mci/paper/.cd,
  %
  abstract-font/.default    = \itshape,
  abstract-font/.store in   = \abstract@font,
  %
  abstract-colour/.default  = black,
  abstract-colour/.store in = \abstract@colour,
  %
  title-colour/.default     = mci2,
  title-colour/.store in    = \title@colour,
  %
  title-align/.store in    = \title@align,
  title-align/.initial     = left,
  %
  abstract-font,
  abstract-colour,
  title-colour,
  title-align,
}
 
\newcommand{\SetMCI}[1][]{%
  \pgfkeys{/mci/paper/.cd,#1}%
  
  }%

 
\pretocmd{\printbibliography}{\section*{Bibliography}}{}{}

\renewcommand{\thesection}{\@Roman{\c@section}}
\renewcommand{\theequation}{\@arabic\c@section}

\renewcommand{\sectionlinesformat}[4]{%
    %\@tempswafalse
        \ifstr{#1}{section}{%
                \centering\mbox{\@hangfrom{{#3}{#4}}}
        }
        {\ifstr{#1}{subsection}{%
                \centering\mbox{\@hangfrom{{#3}{#4}}}%
        }
    {\@hangfrom{\hskip#2#3}{#4}}}%
}

\usepackage{multicol}


\renewenvironment{abstract}
    {\textbf{Abstract\ }\color{\abstract@colour}\abstract@font } 
    { }

    \AtBeginDocument{\begin{flushleft}
  \begin{tikzpicture}[overlay, remember picture]
  \node at ([xshift=-7cm, yshift=11cm]current page.center) {
    \includegraphics[scale=4]{img/mci-logo-outline.pdf}
  };
\end{tikzpicture} 
  {\Large\the\TitleHeader\vspace*{\fill}\quad{\textit{\Large\the\Lecture}}\quad{\Large\the\Cohort} \\[0.5\baselineskip]
    {\Huge\textcolor{mci2}{\textbf{\textcolor{\title@colour}{\the\Title}}}}} \\[\baselineskip]
  \the\StudentName,\quad\the\StudentID
  \normalsize 
  % 
\end{flushleft}
\begin{multicols}{2}}

\AtEndDocument{\end{multicols}}

% ---------------------------------------------------------------------------------------------
%
% cls-Paper.cls ends here.
%
\endinput
