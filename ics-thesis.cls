% ics-thesis.cls: thesis class in our department.
% \documentclass{ics-thesis}
\def\icsthesisversion{1.0}
\def\icsthesisdate{2000/01/25}
\NeedsTeXFormat{pLaTeX2e}
\ProvidesClass{ics-thesis}[\icsthesisdate, \icsthesisversion]
\LoadClass[11pt]{jarticle}
\typeout{Master/Bachelor Thesis Style for Dept. of I.C.S., Osaka Univ.}
%
% Printing Area.... for A4
%
%\typeout{printing area}
\textwidth=15cm
\textheight=22cm
\topmargin=0cm
\oddsidemargin=1cm
\evensidemargin=1cm
%%% baselinestretch 1.5 ->1.2 by saitoh(1996.2.18)
\def\baselinestretch{1.2}
%
% Section Header
%       from jarticle.cls, however, font and size was modified.
%
%\typeout{section}
\def\section{\newpage\@startsection {section}{1}{\z@}%
  {3.5ex plus 1ex minus .2ex}%
  {2.3ex plus .2ex}%
  {\normalfont\large\bfseries}}
\def\subsection{\@startsection{subsection}{2}{\z@}%
  {3.25ex plus 1ex minus .2ex}%
  {1.5ex plus .2ex}%
  {\normalfont\normalsize\bfseries}}
\def\subsubsection{\@startsection{subsubsection}{3}{\z@}%
  {3.25ex plus 1ex minus .2ex}%
  {1.5ex plus .2ex}%
  {\normalfont\normalsize\bfseries}}
\def\paragraph{\@startsection{paragraph}{4}{\z@}%
  {3.25ex plus 1ex minus .2ex}%
  {-1em}%
  {\normalfont\normalsize\bfseries}}
\def\subparagraph{\@startsection{subparagraph}{4}{\parindent}%
  {3.25ex plus 1ex minus .2ex}%
  {-1em}%
  {\normalfont\normalsize\bfseries}}
%
% References (bug fix jarticle.sty)
%
%\typeout{reference}
\def\thebibliography#1{\section*{参考文献\markboth
    {参 考 文 献}{参 考 文 献}\addcontentsline{toc}{section}{参考文献}}\list
  {[\arabic{enumi}]}{\settowidth\labelwidth{[#1]}\leftmargin\labelwidth
    \advance\leftmargin\labelsep
    \usecounter{enumi}}
  \def\newblock{\hskip .11em plus .33em minus -.07em}
  \sloppy
  \sfcode`\.=1000\relax}
\let\endthebibliography=\endlist
%
% today
%
%\typeout{jpntoday}
\newif\if西暦\let\if西暦=\iffalse \def\西暦{\let\if西暦=\iftrue}
\def\jpntoday{{\if西暦\count0=\year\else%
    \count0=\year\advance\count0 -1988 平成\,\fi%
    \number\count0\,年\hspace{.5em}\nobreak%
    \number\month\,月\hspace{.5em}\nobreak\number\day\,日}}
%
\newcount\nendo
\def\nendostr{{\ifnum\month<4\nendo=\year\advance\nendo -1989\else%
    \nendo=\year\advance\nendo -1988\fi%
    平成{\ifnum\nendo=1{元}\else\number\nendo\fi}年度}}
%
%\typeout{engtoday}
\def\engtoday{
  \ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space\number\day, \number\year}
%
%\typeout{current time}
\newcount\curmin \newcount\hour \newcount\onehour \newcount\curhour
\onehour=60
\hour=\time
\divide\hour by\onehour
\curhour=\hour
\multiply\hour by-\onehour
\curmin=\time
\advance\curmin by\hour
\def\curtime{{\rm\number\curhour 時\number\curmin 分}}
%
% Theorem Environment: 
% \newtheoremで定義されるexampleとかがitalicになってしまうのがいやなの
% で次のように再定義する。 
%
\def\@begintheorem#1#2{\trivlist \item[\hskip \labelsep{\bf [#1\ #2]}]}
%
% pagestyle
%
%\typeout{pagestyle}
\def\myfoot{\textsf{ \thepage}}
\def\yes{1}
%
% for master student
%
\def\ps@masterthesis{
  \def\isfinal{1}
  \def\doctitle{修士学位論文}
  \def\institutestr{
    大阪大学 大学院基礎工学研究科 \\
    情報数理系専攻 ソフトウェア科学分野}% 
  \def\@evenhead{}%
  \def\@oddhead{}%
  \def\@oddfoot{\hfill\myfoot\hfill}%
  \def\@evenfoot{\hfill\myfoot\hfill}%
%  }
%
% for bachelor student
%
\def\ps@bachelorthesis{
  \def\isfinal{1}
  \def\doctitle{特別研究報告}
  \def\institutestr{大阪大学 基礎工学部 情報科学科}
  \def\@evenhead{}%
  \def\@oddhead{}%
  \def\@oddfoot{\hfill\myfoot\hfill}%
  \def\@evenfoot{\hfill\myfoot\hfill}%
  }
%
% drafts
%
\def\ps@draft{
  \def\isfinal{0}
  \def\doctitle{DRAFT}
  \def\institutestr{大阪大学 基礎工学部 情報科学科}
  \def\draftstr{{\jpntoday, \curtime: \authorstr}}
  \def\draftfoot{%
    {\textsf{ \draftstr}\hfill\textsf{ \thepage}}%
    }
  \def\@evenhead{}%
  \def\@oddhead{}%
  \def\@oddfoot{{\draftfoot}}%
  \def\@evenfoot{{\draftfoot}}%
  }
%
% title page items
%
%\typeout{commands...}
\def\titlestr{Don't Trust Over Thirty!!}
\renewcommand{\title}[1]{
  \def\titlestr{#1}
  }
%
\def\authorstr{Mr. Foo Bar}
\renewcommand{\author}[1]{
  \def\authorstr{#1}
  }
%
\def\supervisorstr{宮原 秀夫 教授}
\newcommand{\supervisor}[1]{
  \def\supervisorstr{#1}
  }
%
\def\deadlinestr{}
\newcommand{\deadline}[1]{
 \def\deadlinestr{#1}
 }
%
% title page
%
%\typeout{titlepage}
\renewcommand{\titlepage}{
  \newpage
  \thispagestyle{empty}
  \setcounter{page}{0}
  \if\isfinal\yes
  \vspace*{\fill}
  \begin{center}
    {\textbf{\Large\doctitle}}
  \end{center}
  \vspace*{5mm}
  \begin{center}
    {\large 題目}
  \end{center}
  \vspace*{3mm}
  \begin{center}
    \textbf{\Large\titlestr}
  \end{center}
  \vspace*{5mm}
  \begin{center}
    指導教員 \\
    \supervisorstr
  \end{center}
  \vspace*{5mm}
  \begin{center}
    報告者 \\
    \authorstr
  \end{center}
  \vspace*{5mm}
  \begin{center}
    \deadlinestr
  \end{center}
  \vspace*{5mm}
  \begin{center}
    \institutestr
  \end{center}
  \vspace*{\fill}
  \else
  \vspace*{\fill}
  \begin{center}
    \textbf{\Huge DRAFT}
  \end{center}
  \vspace*{1cm}
  \begin{center}
    \textbf{\Large\titlestr}
  \end{center}
  \vspace*{1cm}
  \begin{center}
    {\Large \authorstr}
  \end{center}
  \vspace*{1cm}
  \begin{center}
    \textbf{\Large \engtoday}
  \end{center}
  \vspace*{\fill}
  \fi
  }
%
%\typeout{abstract}
\renewcommand{\abstract}{
  \newpage
  \begin{flushleft}
    \nendostr\ \doctitle
  \end{flushleft}
  \vspace*{2mm}
  \begin{flushleft}
    \titlestr
  \end{flushleft}
  \begin{flushright}
    \authorstr
  \end{flushright}
  \vspace*{2mm}
  \begin{flushleft}
    \textbf{\large 内容梗概}
  \end{flushleft}
  \vspace*{2mm}
  \par
  }
%
%\typeout{keyword}
\newcommand{\keyword}{
  \vspace*{5mm}
  \begin{flushleft}
    \textbf{ 主な用語}
  \end{flushleft}
  }
%
%\typeout{toc}
\newcommand{\toc}{
  \if\isfinal\yes
  \newpage
  \tableofcontents
  \fi
  }
%typeout{acknowledgement}
\newcommand{\acknowledgement}{
  \newpage
  \section*{謝辞\addcontentsline{toc}{section}{謝辞}}
  }
%typeout{appendix}
\renewcommand{\appendix}{
  \newpage
  \section*{付録\addcontentsline{toc}{section}{付録}}
  }
%typeout{yet another reference}
\newcommand{\reference}{
  \newpage
  \section*{参考文献\addcontentsline{toc}{section}{参考文献}}
  }
%\typeout{done}
