% VGTU EF class
%
% Maksim Norkin, 2012

\ProvidesClass{vgtuef}

\LoadClass[12pt,a4paper,twoside,openright]{article}

% Table of contents
\RequirePackage{graphicx}
\RequirePackage[utf8x]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage[lithuanian]{babel}
\RequirePackage{fancyhdr}
\RequirePackage{layout}
\RequirePackage{color}
\RequirePackage[hmarginratio=1:1]{geometry}
\RequirePackage[toc,page]{appendix}
\RequirePackage[bookmarks]{hyperref}
\RequirePackage{fancyvrb}
\RequirePackage{tocloft}
\RequirePackage{mathptmx}
\RequirePackage[numbers]{natbib}

%% Lists
%\RequirePackage{tweaklist}
%\renewcommand{\itemhooki}{\setlength{\topsep}{0pt}%
%  \setlength{\itemsep}{0pt}}

%% Table
\RequirePackage{multirow}

\RequirePackage{epstopdf}
\RequirePackage{listings}

%% Math
\RequirePackage[sc]{mathpazo}
\RequirePackage{amsmath,amssymb}
\RequirePackage{upgreek}

%% Custom spaces
\RequirePackage{setspace}

%% Fonts
%\RequirePackage{winfonts}

%% Graphics
\RequirePackage{pgfplots}
\RequirePackage{tikz}

%% Custom captions
\RequirePackage[skip=5pt,labelfont=bf,justification=centering,labelsep=space,font=small]{caption}
\RequirePackage{chngcntr}
\counterwithin{figure}{section}
\counterwithin{equation}{section}
\counterwithin{table}{section}
\RequirePackage{newfloat}

%% Source code float environment
\RequirePackage{floatrow}
\newfloat{cfigure}{tbp}{lop}[section]
\DeclareFloatStyle{cfigure-fs}{
    capposition=top,
    heightadjust=all
}
\floatsetup[cfigure]{style=cfigure-fs}
\DeclareCaptionLabelFormat{cfigure-st}{#2 programinis kodas.}
\captionsetup[cfigure]{position=above,labelformat=cfigure-st,justification=justified,singlelinecheck=false}
\counterwithin{cfigure}{section}

\DeclareFloatStyle{table-fs}{
    capposition=top,
    heightadjust=all
}
\floatsetup[table]{style=cfigure-fs}
\DeclareCaptionLabelFormat{table-st}{#2 lentelė.}
\captionsetup[table]{position=above,labelformat=table-st,singlelinecheck=true}

%\RequirePackage{fontspec}

%% Source code style
\lstset{
  language=C,
  basicstyle=\ttfamily,
  columns=fullflexible,
  %numbers=none,
  showspaces=false,
  xleftmargin=20pt
}

% COLORS
\definecolor{b1}{cmyk}{0.68,0.15,0.0, 0.59}

\renewcommand{\sfdefault}{phv}
\renewcommand{\rmdefault}{ptm}

\pagestyle{fancy}

\fancypagestyle{plain}{}

\fancyhead{} % clear all the headers
\renewcommand{\headrulewidth}{0pt} % and lines
\fancyheadoffset[E]{0pt}
\fancyfoot{} % Clear all the footer stuff
\fancyfoot[L]{\color{b1}\tiny\ttfamily[EF-08-2.10LT]}
\fancyfoot[R]{\color{b1}\thepage}

\setlength{\hoffset}{-1in}
%\setlength{\voffset}{-46pt}
\setlength{\textwidth}{483pt}
\setlength{\marginparwidth}{0pt}
\setlength{\oddsidemargin}{70pt}
\setlength{\evensidemargin}{40pt}
\setlength{\marginparsep}{0pt}
%\setlength{\topmargin}{0pt}
\setlength{\textheight}{680pt}
\setlength{\footskip}{20pt}

%\setlength{\headheight}{}

%% Enable font
\normalfont\selectfont

% Table of contents
\renewcommand\thesection{\arabic{section}.}
\renewcommand\thesubsection{\thesection\arabic{subsection}.}
\renewcommand\thesubsubsection{\thesubsection\arabic{subsubsection}.}
\renewcommand{\cftdot}{}

\renewcommand{\cfttoctitlefont}{\hspace{6mm}\bfseries\color{b1}\MakeUppercase}
\renewcommand{\cftaftertoctitle}{\hfill}

% Section style
\def\section{\@startsection{section}{1}{\z@}{1.5ex plus 1.5ex minus 0.5ex}{0.7ex plus 1ex minus 0ex}{\normalfont\normalfont\scshape\bfseries\color{b1}\centering\large}}
\def\subsection{\@startsection{subsection}{2}{\z@}{1.5ex plus 1.5ex minus 0.5ex}{0.7ex plus .5ex minus 0ex}{\normalfont\normalsize\scshape\bfseries\color{b1}\large}}
\def\subsubsection{\@startsection{subsubsection}{3}{\z@}{1.5ex plus 1.5ex minus 0.5ex}{0.7ex plus .2ex minus 0ex}{\normalfont\normalsize\scshape\bfseries\color{b1}\large}}


\let\stdsection\section
\renewcommand\section{\newpage\stdsection}
%\renewcommand{\thesection}{}
%\renewcommand\thesubsection{\@arabic\c@section.\@arabic\c@subsection}

% Listing style
\newcommand{\blob}{\rule[.2ex]{0.7ex}{0.7ex}}
\renewcommand{\labelitemi}{$\blob$}

\renewenvironment{itemize}%
  {\begin{list}{$\blob$}%
     {\topsep=0.05in\itemsep=0.05in\parsep=0in\partopsep=0in\leftmargin=0.4in}%
   }{\end{list}}
   
   
\newcounter{qcounter}
\renewenvironment{enumerate}%
  {\begin{list}{$\arabic{qcounter}.$}%
     {\topsep=0.05in\itemsep=0.05in\parsep=0in\partopsep=0in\leftmargin=0.45in\usecounter{qcounter}}%
   }{\end{list}}
