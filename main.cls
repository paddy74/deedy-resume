% Intro Options
% =============

\ProvidesClass{deedy-resume}[2025/00/00 CV class]
\NeedsTeXFormat{LaTeX2e}

% Options
% -------

\DeclareOption{print}{\def\@cv@print{}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}

% Engine guard (class already relies on fontspec)
% ===============================================

\RequirePackage{iftex}
\ifPDFTeX
  \ClassError{main}{This class requires XeLaTeX or LuaLaTeX}%
    {Use xelatex or lualatex. The class loads fontspec and OpenType fonts.}
\fi

% Package imports
% ===============

% Geometry / PDF management
\RequirePackage[hmargin=1.25cm, vmargin=0.75cm]{geometry}

% pdfx loads hyperref; pass options instead of loading twice
\PassOptionsToPackage{hidelinks}{hyperref}
\PassOptionsToPackage{usenames,dvipnames}{xcolor} % pdfx loads xcolor
\RequirePackage[a-1b]{pdfx} % keep legacy PDF/A-1b default

% Citations
% =========

\RequirePackage{cite}
\renewcommand\refname{\vskip -1.5cm}

% Color definitions
% =================

\definecolor{date}{HTML}{666666}
\definecolor{primary}{HTML}{2b2b2b}
\definecolor{headings}{HTML}{6A6A6A}
\definecolor{subheadings}{HTML}{333333}

% Fonts
% =====

\RequirePackage{fontspec}
% Prefer HarfBuzz renderer when available (LuaHB/XeTeX selects internally)
% NOTE: Mapping=tex-text is deprecated; use Ligatures=TeX
\setmainfont[
  Color          = primary,
  Path           = fonts/lato/,
  Ligatures      = TeX,
  BoldItalicFont = Lato-BolIta,
  BoldFont       = Lato-Bol,
  ItalicFont     = Lato-RegIta
]{Lato-Reg}

\setsansfont[
  Scale     = MatchLowercase,
  Ligatures = TeX,
  Path      = fonts/raleway/
]{Raleway-ExtraLight}

% Absolute blocks (date, work location)
% =====================================

\RequirePackage[absolute]{textpos}
\RequirePackage[UKenglish]{isodate}
\setlength{\TPHorizModule}{1mm}
\setlength{\TPVertModule}{1mm}

% Document last updated on
% ========================
\newcommand{\lastupdated}{%
  \begin{textblock}{60}(155,5)%
  \color{date}\fontspec[Path = fonts/raleway/]{Raleway-ExtraLight}\fontsize{8pt}{10pt}\selectfont%
  Last Updated on \today
  \end{textblock}%
}

% Name command
% ============

\newcommand{\namesection}[2]{%
  \centering{%
    \fontsize{40pt}{60pt}%
    \fontspec[Path = fonts/lato/]{Lato-Lig}\selectfont #1%
  }\\[5pt]%
  \centering{%
    \color{headings}%
    \fontspec[Path = fonts/raleway/]{Raleway-Medium}\fontsize{11pt}{14pt}\selectfont #2
  }%
  \noindent\makebox[\linewidth]{\color{headings}\rule{\paperwidth}{0.4pt}}%
  \vspace{-15pt}
}

% Section separators
% ==================

\RequirePackage{titlesec}
\titlespacing{\section}{0pt}{0pt}{0pt}
\titlespacing{\subsection}{0pt}{0pt}{0pt}
\newcommand{\sectionsep}{\vspace{8pt}}

% Headings command
% ----------------

\titleformat{\section}{
  \color{headings}%
  \scshape\fontspec[Path = fonts/lato/]{Lato-Reg}\fontsize{16pt}{24pt}\selectfont \raggedright\MakeUppercase
}{}{0em}{}


% Subheadings command
% -------------------

\titleformat{\subsection}{%
  \color{subheadings}
  \fontspec[Path = fonts/lato/]{Lato-Bol}\fontsize{12pt}{12pt}\selectfont\bfseries\MakeUppercase
}{}{0em}{}

\newcommand{\runsubsection}[1]{%
  \color{subheadings}
  \fontspec[Path = fonts/lato/]{Lato-Bol}\fontsize{12pt}{12pt}\selectfont\bfseries\MakeUppercase{#1}\normalfont
}

% Descriptors / location
% ----------------------

\newcommand{\descript}[1]{%
  \color{subheadings}
  \raggedright\scshape\fontspec[Path = fonts/raleway/]{Raleway-Medium}
  \fontsize{11pt}{13pt}
  \selectfont {#1 \\}\normalfont
}

\newcommand{\location}[1]{%
  \color{subheadings}
  \raggedright\fontspec[Path = fonts/raleway/]{Raleway-Medium}\fontsize{10pt}{12pt}\selectfont {#1\\}\normalfont
}


% Bullet lists with fewer gaps
% ============================
\newenvironment{tightemize}{%
  \vspace{-\topsep}\begin{itemize}\itemsep1pt \parskip0pt \parsep0pt
}%
{\end{itemize}\vspace{-\topsep}}
