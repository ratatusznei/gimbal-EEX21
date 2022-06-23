%% UTFPRCT-TEX, v1.0.6 wmeira on 2021/10/11
%% Copyright (C) 2020- by William H. T. Meira
%%
%% Modified version of project 'utfprpgtex' maintained
%% by Luiz E. M. Lima
%%
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
%%
%% This work has the LPPL maintenance status `maintained'.
%%
%% The Current Maintainer of this work is William H. T. Meira.
%%
%% This project consists mainly of files: 'utfprct.cls', 'utfprct.tex',
%% 'utfprct-dados.tex'
%%
%% The 'abntex2-alf.bst' and 'abntex2-num.bst' files are slightly
%% modified versions of the bibtex styles from abntex2 (v.1.9.7)
%% package to suit NBR6023/2018 (not yet implemented there).
%% Complementary, 'abntex2-alf-en.bst' and 'abntex2-num-en.bst' are
%% english versions of the respective bibtex styles.
%%
%% Contribute to improve this project (github repo):
%% https://github.com/wmeira/utfprct-tex
%%


%% Identificação e modificações
\NeedsTeXFormat{LaTeX2e}[2005/12/01]
\ProvidesClass{utfprct}[2021/10/11 v1.0.6]
\RequirePackage{color}%% Controle de cores em documentos LaTeX
\RequirePackage{substr}%% Controle de substrings em strings

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{abntex2}}%% Envio das opções atuais para a classe abntex2
%% -- Opções da classe utfprct
%%    -- Impressão dos elementos pré-textuais
\newif\if@pretexttwoside%% Condicional para impressão dos elementos pré-textuais
\DeclareOption{pretextualoneside}{\typeout{-----> Option: pretextualoneside}\@pretexttwosidefalse}%% Anverso
\DeclareOption{pretextualtwoside}{\typeout{-----> Option: pretextualtwoside}\@pretexttwosidetrue}%% Anverso e verso
%%    -- Fonte do texto
\gdef\@tipodefonte{lmodern} % Computer modern roman (default)
\DeclareOption{fontemodern}{\typeout{-----> Option: fontemodern}\gdef\@tipodefonte{lmodern}}%% Computer modern roman (default)
\DeclareOption{fontetimes}{\typeout{-----> Option: fontetimes}\gdef\@tipodefonte{times}}%% Times
\DeclareOption{fontearial}{\typeout{-----> Option: fontearial}\gdef\@tipodefonte{arial}}%% Helvetica (closest to Arial)
\DeclareOption{fontecourier}{\typeout{-----> Option: fontecourier}\gdef\@tipodefonte{courier}}%% Courier
%%    -- Cores nos vínculos (padrões: citecolor = green, filecolor = cyan, linkcolor = red, urlcolor = magenta)

\definecolor{bblue}{rgb}{0, 0, 0.25}%% Definição do azul escuro (modificado)
\definecolor{gray}{rgb}{0.5, 0.5, 0.5}%% Definição do cinza (modificado)
\def\@cordosvinculos{black}%% Preto (NBR 14724/2011: cor preta)
\DeclareOption{vinculoscoloridos}{\typeout{-----> Option: vinculoscoloridos}\def\@cordosvinculos{bblue}}%% Azul escuro
\def\@citecolor{\@cordosvinculos}%% Cor das citações
\def\@filecolor{\@cordosvinculos}%% Cor dos arquivos
\def\@linkcolor{\@cordosvinculos}%% Cor dos links
\def\@urlcolor{\@cordosvinculos}%% Cor das urls
%%    -- Remoção do recuo dos itens no sumário
\newif\if@semrecuonosumario%% Condicional para remoção do recuo dos itens no sumário
\@semrecuonosumariofalse%% Remove
\DeclareOption{semrecuonosumario}{\typeout{-----> Option: semrecuonosumario}\@semrecuonosumariotrue}%% Adiciona
\newif\if@inserirbackref%% Condicional para inserir backref na lista de referencias (Citado na página...)
\@inserirbackreffalse%% Nao inseri (default)
\DeclareOption{inserirbackref}{\typeout{-----> Option: inserirbackref}\@inserirbackreftrue}%% inseri backref nas ref.
%%    -- Compilação de glossários e índices utilizando makeindex
\newif\if@usemakeindex%% Condicional para compilação de glossários e índices utilizando makeindex
\@usemakeindexfalse%% Desabilita
\DeclareOption{usemakeindex}{\typeout{-----> Option: usemakeindex}\@usemakeindextrue}%% Habilita
%%    -- Alinhamento das legendas
\newif\if@legendascentralizadas%% Condicional para o alinhamento das legendas
\@legendascentralizadasfalse%% À esquerda
\DeclareOption{legendascentralizadas}{\typeout{-----> Option: legendascentralizadas}\@legendascentralizadastrue}%% Centralizado
%%    -- Folha de aprovação do programa de pós-graduação
\newif\if@aprovacaoestiloppg%% Condicional para a folha de aprovação do programa de pós-graduação
\@aprovacaoestiloppgfalse%% Estilo padrão
\DeclareOption{aprovacaoestiloppg}{\typeout{-----> Option: aprovacaoestiloppg}\@aprovacaoestiloppgtrue}%% Estilo do PPG
%%    -- Assinaturas na folha de aprovação
\newif\if@pardeassinaturas%% Condicional para as assinaturas na folha de aprovação
\@pardeassinaturasfalse%% Em uma única coluna
\DeclareOption{pardeassinaturas}{\typeout{-----> Option: pardeassinaturas}\@pardeassinaturastrue}%% Em até duas colunas
%%    -- Linhas de assinaturas na folha de aprovação
\newif\if@linhasdeassinaturas%% Condicional para as linhas de assinaturas na folha de aprovação
\@linhasdeassinaturasfalse%% Remove as linhas
\DeclareOption{linhasdeassinaturas}{\typeout{-----> Option: linhasdeassinaturas}\@linhasdeassinaturastrue}%% Adiciona as linhas
\ProcessOptions\relax%% Processamento das opções
\LoadClass{abntex2}%% Carregamento da classe abntex2


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Pacotes carregados
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{silence}
% Supress warning: captions config. via caption package interface instead the memoir class
\WarningFilter{memoir}{For the caption package}

\RequirePackage[utf8]{inputenc}%% Codificações de entrada: unix - latin1/utf8; windows - ansinew; Mac - applemax; DOS-OS/2 - cp850
\ifpdf%% Compilação com pdflatex
  \RequirePackage{cmap}%% Busca e cópia em arquivos PDF
  \RequirePackage{ae}%% Fontes virtuais para codificação de fontes T1
  \RequirePackage[pdftex]{graphics}%% Padrão gráfico de figuras
  \RequirePackage[pdftex]{graphicx}%% Aperfeiçoamentos do padrão gráfico de figuras
\else%% Compilação com latex
  \RequirePackage[T1]{fontenc}%% Codificação de fontes T1
  \RequirePackage{epic, eepic}%% Aperfeiçoamentos e extensões do ambiente figure
  \RequirePackage[dvips]{epsfig}%% Emulação de figuras (e)ps
  \RequirePackage[dvips]{graphics}%% Padrão gráfico de figuras
  \RequirePackage[dvips]{graphicx}%% Aperfeiçoamentos do padrão gráfico de figuras
\fi
\RequirePackage{fix-cm}%% Fontes "Computer Modern" em tamanhos arbitrários
\RequirePackage{hyphenat}%% Hifenização de palavras

%% Configurações do pacote backref
\if@inserirbackref%% Inserir backref na lista de referencias
\ifthenelse{\equal{\languagename}{english}}
{%% english
\RequirePackage[english, hyperpageref]{backref}%% Páginas das citações nas referências
\renewcommand{\backrefpagesname}{Cited on page(s):~}%% Comando usado sem a opção hyperpageref do pacote backref
\renewcommand{\backref}{}%% Texto padrão antes do número das páginas
\renewcommand*{\backrefalt}[4]{%% Definição dos textos da citação
  \ifcase #1%%
    No citation in the text.%%
  \or%%
    Cited on page #2.%%
  \else%%
    Cited #1 times on pages #2.%%
  \fi
}
}{%% portugues (default)
\RequirePackage[brazilian, hyperpageref]{backref}%% Páginas das citações nas referências
\renewcommand{\backrefpagesname}{Citado na(s) página(s):~}%% Comando usado sem a opção hyperpageref do pacote backref
\renewcommand{\backref}{}%% Texto padrão antes do número das páginas
\renewcommand*{\backrefalt}[4]{%% Definição dos textos da citação
  \ifcase #1%%
    Nenhuma citação no texto.%%
  \or%%
    Citado na página #2.%%
  \else%%
    Citado #1 vezes nas páginas #2.%%
  \fi
}
}
\fi

%NBR6023/2018: alinhado para esquerda (package default: bibleftalign)
%Numérico é possível na ABNT (usar num), mas não é o preferível e mais comum
\RequirePackage[alf, bibleftalign]{abntex2cite}%% Citações padrão ABNT (autor-data)

%Bibliografia em estilo inglês
\ifthenelse{\equal{\languagename}{english}}{%
	\bibliographystyle{abntex2-alf-en}
}{}%

\ifpdf%% Compilação com pdflatex
\else%% Compilação com latex
  \@ifpackageloaded{breakurl}%% Verificação do pacote breakurl
    {\PassOptionsToPackage{hyphenbreaks}{breakurl}}{\RequirePackage[hyphenbreaks]{breakurl}}%% Quebra de linha em endereços da web
\fi
% \RequirePackage[showframe]{geometry}
\RequirePackage{geometry}
\RequirePackage{lastpage}%% Referência da última página
\RequirePackage{algorithmic}%% Ferramenta para tipografar um algoritmo em pseudocódigo
%\RequirePackage{algorithmicx}%% Ferramenta para tipografar um algoritmo em pseudocódigo (optional)
%\RequirePackage{algpseudocode}%% Ferramenta para tipografar um algoritmo em pseudocódigo (optional)
\RequirePackage[acronym, nosuper, nowarn, sanitize={description=false}, style=index]{glossaries}%% Glossários e listas de acrônimos
\RequirePackage{nomencl}%% Listas de símbolos como uma nomenclatura
\RequirePackage{amsmath}%% Ferramentas para linguagem matemática
\RequirePackage{sistyle}%% Unidades, números e ângulos no SI
\RequirePackage{caption}%% Configuração das legendas de objetos flutuantes
\RequirePackage{xtab}%% Tabelas em múltiplas páginas
\RequirePackage{etoolbox}%% Caixa de ferramentas para programadores LaTeX usando e-TEX
\RequirePackage{indentfirst}%% Recuo do primeiro parágrafo após cabeçalho da seção
\RequirePackage{morewrites}%% Espaços adicionais para comandos \write*
\RequirePackage{pdfpages}%% Inclusão de PDF com múltiplas páginas

\let\footruleskip\undefined%% Remoção da definição de "\footruleskip" antes do carregamento do pacote fancyhdr
\RequirePackage{fancyhdr}%% Controle extensivo de cabeçalhos e rodapés

%% Logo UTFPRPGTeX
\newcommand{\utfprpgtex}{UTF\kern-0.75ex\lower0.4ex\hbox{\tiny PR}\kern-0.9ex\lower-0.585ex\hbox{\tiny PG}\kern-0.1ex\TeX}

%% Logo UTFPRCTTeX
\newcommand{\utfprcttex}{UTF\kern-0.75ex\lower0.4ex\hbox{\tiny PR}\kern-0.9ex\lower-0.585ex\hbox{\tiny CT}\kern-0.1ex\TeX}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Configurações do pacote hyperref
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\hypersetup{%% Opções do pacote hyperref
  breaklinks=true,%%
  colorlinks=true,%%
  citecolor=\@cordosvinculos,%%
  filecolor=\@cordosvinculos,%%
  linkcolor=\@cordosvinculos,%%
  urlcolor=\@cordosvinculos,%%
  bookmarksopen=true,%%
  bookmarksnumbered=true,%%
  pdfdisplaydoctitle=true,%%
  pdfpagelayout=SinglePage%%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Configurações do pacote abntex2cite
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\AtBeginDocument{%% Definições carregadas no início do documento
  \citeoption{abnt-emphasize=bf}
  \citeoption{abnt-etal-cite=2}%número de autores max para nao usar et al
  \citeoption{abnt-etal-list=0}%nao usar et al. nas ref.
  \citeoption{abnt-full-initials=yes}
  \citeoption{abnt-thesis-year=both}
  \citeoption{abnt-url-package=url}

  %NBR6023/2018: sem traço sublinear quando referências (mesmos autores) forem repetidos (yes para colocar)
  \citeoption{abnt-repeated-title-omit=no}

  %NBR6023/2018: URLs nao devem ter "<" and ">" (altera o comando do abntex2cite.sty)
  \renewcommand\UrlLeft{}%antes era "<"
  \renewcommand\UrlRight{}%antes era ">"
}

%%%%%%%%
%% Para alterar o idioma do documento para o INGLÊS:
%1) Colocar o "english" como último idioma carregado no documentclass (o último será o principal do documento. Adicionalmente, pode-se selecionar o english como língua principal.
%\selectlanguage{english}%descomentar para ingles

%2) Usar o abntex2-alf-en ou abntex2-num-en ao invés do default em pt-br do abntex2.
%
%%%%%%%%


%%%%%%%%
%% Licenciamento
%%
%% A resolução conjunta Nº 01/2020 COGEP-COPPG torna
%% obrigatório o uso de uma das 6 licenças Creative Commons
%% disponíveis (CC-BY, CC-BY-SA, CC-BY-ND, CC-BY-NC, CC-BY-NC-SA, CC-BY-NC-ND),
%% sendo necessário verificar junto ao curso ou programa de pós-graduação do
%% discente qual deve-se utilizar no trabalho.
%%
%% Opções: CC-BY, CC-BY-SA, CC-BY-ND, CC-BY-NC, CC-BY-NC-SA, CC-BY-NC-ND, Nenhuma
\providecommand{\licenciamento}{Nenhuma} %default
\newcommand{\Licenca}[1]{\renewcommand{\licenciamento}{#1}}
%%
%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Variáveis dependentes do idioma
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ifthenelse{\equal{\languagename}{english}}
{%% Definição do idioma INGLES
  \AtBeginDocument{
  	\newcommand{\lingua}{english}
    \newcommand{\nomecapa}{Cover}
    \newcommand{\nomefolhaderosto}{Title Page}
    \newcommand{\nomefichacatalografica}{Index Card}
    \newcommand{\nomeerrata}{Errata}%Errata Sheet / Erratum
    \newcommand{\nomefolhadeaprovacao}{Approval Term}
    % \newcommand{\nomededicatoria}{Dedicatory}
    \renewcommand{\agradecimentosname}{Acknowledgements}
    % \newcommand{\nomeepigrafe}{Epigraphy}
    \newcommand{\nomeresumo}{Resumo}
    \newcommand{\nomepalavraschave}{Palavras-chave}
    \newcommand{\nomeabstract}{Abstract}
    \newcommand{\nomekeywords}{Keywords}
    \newcommand{\listalgorithmname}{List of Algorithms}
    \newcommand{\algorithmname}{Algorithm}
    \renewcommand{\listfigurename}{List of Figures}
    % \renewcommand{\figurename}{Figure}
    \newcommand{\photographname}{Photograph}
    \newcommand{\graphname}{Graph}
    \newcommand{\tabframedname}{Frame}
    \renewcommand{\listtablename}{List of Tables}
    % \renewcommand{\tablename}{Table}
    \newcommand{\nomefonte}{Source}
    \renewcommand{\nomname}{Nomenclature}
    \newcommand{\nomelistadeacronimos}{List of Acronyms}
    \newcommand{\nomeabreviaturas}{Abbreviations}
    \newcommand{\nomesiglas}{Initialism} %Initialism
    \newcommand{\nomeacronimos}{Acronyms}
    \newcommand{\nomelistadesimbolos}{List of Symbols}
    \newcommand{\nomeletraslatinas}{Latin Letters}
    \newcommand{\nomeletrasgregas}{Greek Letters}
    \newcommand{\nomesobrescritos}{Superscripts}
    \newcommand{\nomesubscritos}{Subscripts}
    \newcommand{\nomenotacoes}{Notations}
    \newcommand{\nomeindicessets}{Indices and Sets}
    \newcommand{\nomeparam}{Parameters}
    \newcommand{\nomefloatvar}{Continuos Variables}
    \newcommand{\nomeintvar}{Integer Variables}
    \newcommand{\nomebinvar}{Binary Variables}

    % abntex2
    % \renewcommand{\contentsname}{Summary}
    \renewcommand{\chapterautorefname}{Chapter}
    \renewcommand{\sectionautorefname}{Section}
    \renewcommand{\subsectionautorefname}{Subsection}
    \renewcommand{\subsubsectionautorefname}{Subsection}
    \renewcommand{\paragraphautorefname}{\subsubsectionautorefname}
    \renewcommand{\bibname}{References}
    \renewcommand{\refname}{\bibname}
    \renewcommand{\appendixname}{Appendix}
    \newcommand{\apendiceautorefname}{Appendix}
    \renewcommand{\anexosname}{Annex}
    \newcommand{\anexoautorefname}{Annex}
    \renewcommand{\indexname}{Index}
  }
}{%Definição do idioma em Português (DEFAULT)
  \AtBeginDocument{%% Definições carregadas no início do documento
  	\newcommand{\lingua}{brazil}
    \newcommand{\nomecapa}{Capa}
    \newcommand{\nomefolhaderosto}{Folha de Rosto}
    \newcommand{\nomefichacatalografica}{Ficha Catalográfica}
    \newcommand{\nomeerrata}{Errata}
    \newcommand{\nomefolhadeaprovacao}{Folha de Aprovação}
    % \newcommand{\nomededicatoria}{Dedicatória}
    \renewcommand{\agradecimentosname}{Agradecimentos}
    % \newcommand{\nomeepigrafe}{Epígrafe}
    \newcommand{\nomeresumo}{Resumo}
    \newcommand{\nomepalavraschave}{Palavras-chave}
    \newcommand{\nomeabstract}{Abstract}
    \newcommand{\nomekeywords}{Keywords}
    \newcommand{\listalgorithmname}{Lista de Algoritmos}
    \newcommand{\algorithmname}{Algoritmo}
    \renewcommand{\listfigurename}{Lista de Ilustrações}
    % \renewcommand{\figurename}{Figura}
    \newcommand{\photographname}{Fotografia}
    \newcommand{\graphname}{Gráfico}
    \newcommand{\tabframedname}{Quadro}
    \renewcommand{\listtablename}{Lista de Tabelas}
    % \renewcommand{\tablename}{Tabela}
    \newcommand{\nomefonte}{Fonte}
    % \renewcommand{\nomname}{Nomenclatura}
    \newcommand{\nomelistadeacronimos}{Lista de Abreviaturas, Siglas e Acrônimos}
    \newcommand{\nomeabreviaturas}{Abreviaturas}
    \newcommand{\nomesiglas}{Siglas}
    \newcommand{\nomeacronimos}{Acrônimos}
    \newcommand{\nomelistadesimbolos}{Lista de Símbolos}
    \newcommand{\nomeletraslatinas}{Letras Latinas}
    \newcommand{\nomeletrasgregas}{Letras Gregas}
    \newcommand{\nomesobrescritos}{Sobrescritos}
    \newcommand{\nomesubscritos}{Subscritos}
    \newcommand{\nomenotacoes}{Notações}
    \newcommand{\nomeindicessets}{Índices e Conjuntos}
    \newcommand{\nomeparam}{Parâmetros}
    \newcommand{\nomefloatvar}{Variáveis Contínuas}
    \newcommand{\nomeintvar}{Variáveis Inteiras}
    \newcommand{\nomebinvar}{Variáveis Binárias}

    % abntex2
    % \renewcommand{\contentsname}{Sumário}
    % \renewcommand{\chapterautorefname}{Capítulo}
    % \renewcommand{\sectionautorefname}{Seção}
    % \renewcommand{\subsectionautorefname}{Subseção}
    % \renewcommand{\subsubsectionautorefname}{Subseção}
    \renewcommand{\paragraphautorefname}{\subsubsectionautorefname}
    \renewcommand{\bibname}{Referências}
    \renewcommand{\refname}{\bibname}
    \renewcommand{\appendixname}{Apêndice}
    \newcommand{\apendiceautorefname}{Apêndice}
    \renewcommand{\anexosname}{Anexo}
    \newcommand{\anexoautorefname}{Anexo}
    \renewcommand{\indexname}{Índice Remissivo}

    %algorithmicx
    \renewcommand{\algorithmicrequire}{\textbf{requer}}
    \renewcommand{\algorithmicensure}{\textbf{inserir}}
    \renewcommand{\algorithmicend}{\textbf{finaliza}}
    \renewcommand{\algorithmicif}{\textbf{se}}
    \renewcommand{\algorithmicthen}{\textbf{então}}
    \renewcommand{\algorithmicelse}{\textbf{senão,}}
    \renewcommand{\algorithmicfor}{\textbf{para}}
    \renewcommand{\algorithmicforall}{\textbf{para todos}}
    \renewcommand{\algorithmicdo}{\textbf{faça}}
    \renewcommand{\algorithmicwhile}{\textbf{enquanto}}
    \renewcommand{\algorithmicloop}{\textbf{sequência}}
    \renewcommand{\algorithmicrepeat}{\textbf{repita}}
    \renewcommand{\algorithmicuntil}{\textbf{até}}
    \renewcommand{\algorithmicprint}{\textbf{imprime}}
    \renewcommand{\algorithmicreturn}{\textbf{retorna}}
    \renewcommand{\algorithmictrue}{\textbf{verdadeiro}}
    \renewcommand{\algorithmicfalse}{\textbf{falso}}

    \renewcommand{\glossaryname}{Glossário}
    \providetranslation{Glossary}{Glossário}
    \providetranslation{Acronyms}{Siglas}
    \providetranslation{Notation (glossaries)}{Notação}
    \providetranslation{Description (glossaries)}{Descrição}
    \providetranslation{Symbol (glossaries)}{Símbolo}
    \providetranslation{Page List (glossaries)}{Lista de Páginas}
    \providetranslation{Symbols (glossaries)}{Símbolos}
    \providetranslation{Numbers (glossaries)}{Números}
    \SIdecimalsign{,}%% Símbolo de decimal (pacote sistyle)
  }
}

\renewcommand{\folhaderostoname}{\nomefolhaderosto}
\renewcommand{\folhadeaprovacaoname}{\nomefolhadeaprovacao}
\renewcommand{\listadesiglasname}{\nomelistadeacronimos}
%\renewcommand{\listadesimbolosname}{\nomelistadesimbolos}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Informações do Documento
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Tipo de documento
\providecommand{\imprimirtipodedocumento}{Tese} %default
\newcommand{\TipoDeDocumento}[1]{\renewcommand{\imprimirtipodedocumento}{#1}}

% Document type
\providecommand{\imprimirdocumenttype}{Thesis}
\newcommand{\DocumentType}[1]{\renewcommand{\imprimirdocumenttype}{#1}}

%% Nível de formação
\providecommand{\imprimirniveldeformacao}{Doutorado}
\newcommand{\NivelDeFormacao}[1]{\renewcommand{\imprimirniveldeformacao}{#1}}

%% Formation level
\providecommand{\imprimirformationlevel}{PhD}
\newcommand{\FormationLevel}[1]{\renewcommand{\imprimirformationlevel}{#1}}

%% Título pretendido
\providecommand{\imprimirtitulopretendido}{Doutor(a)}
\newcommand{\TituloPretendido}[1]{\renewcommand{\imprimirtitulopretendido}{#1}}

%% Título do documento
\providecommand{\imprimirtitulododocumento}{Título}
\newcommand{\TituloDoDocumento}[1]
{\renewcommand{\imprimirtitulododocumento}{#1}}

%% Document title
\providecommand{\imprimirdocumenttitle}{Title}
\newcommand{\DocumentTitle}[1]{\renewcommand{\imprimirdocumenttitle}{#1}}

%% Título em multiplas linhas
\providecommand{\imprimirtituloemmultiplaslinhas}{Título: \par Subtítulo}
\newcommand{\TituloEmMultiplasLinhas}[1]{\renewcommand{\imprimirtituloemmultiplaslinhas}{#1}}

%% Título em multiplas linhas em inglês
\providecommand{\imprimirtituloemmultiplaslinhasingles}{Title: \par Subtitle}
\newcommand{\TituloEmMultiplasLinhasIngles}[1]{\renewcommand{\imprimirtituloemmultiplaslinhasingles}{#1}}

%% Dia da defesa com número de dígitos exatos (opcional)
\providecommand{\imprimirdia}{1}
\newcommand{\Dia}[1]{\renewcommand{\imprimirdia}{#1}}

%% Mês da defesa por extenso (opcional)
\providecommand{\imprimirmesporextenso}{Janeiro}
\newcommand{\MesPorExtenso}[1]{\renewcommand{\imprimirmesporextenso}{#1}}

%% Ano da defesa com quatro dígitos
\providecommand{\imprimirano}{2020}
\newcommand{\Ano}[1]{\renewcommand{\imprimirano}{#1}}

%% Número de palavras-chave (máximo 5)
\providecommand{\imprimirnumerodepalavraschave}{5}
\newcommand{\NumeroDePalavrasChave}[1]{\renewcommand{\imprimirnumerodepalavraschave}{#1}}

%% Palavra-chave A
\providecommand{\imprimirpalavrachavea}{A}
\newcommand{\PalavraChaveA}[1]{\renewcommand{\imprimirpalavrachavea}{#1}}

%% Palavra-chave B
\providecommand{\imprimirpalavrachaveb}{B}
\newcommand{\PalavraChaveB}[1]{\renewcommand{\imprimirpalavrachaveb}{#1}}

%% Palavra-chave C
\providecommand{\imprimirpalavrachavec}{C}
\newcommand{\PalavraChaveC}[1]{\renewcommand{\imprimirpalavrachavec}{#1}}

%% Palavra-chave D
\providecommand{\imprimirpalavrachaved}{D}
\newcommand{\PalavraChaveD}[1]{\renewcommand{\imprimirpalavrachaved}{#1}}

%% Palavra-chave E
\providecommand{\imprimirpalavrachavee}{E}
\newcommand{\PalavraChaveE}[1]{\renewcommand{\imprimirpalavrachavee}{#1}}

%% Número de keywords (máximo 5)
\providecommand{\imprimirnumerodekeywords}{\imprimirnumerodepalavraschave}
\newcommand{\NumeroDeKeywords}[1]{\renewcommand{\imprimirnumerodekeywords}{#1}}

%% Keyword A
\providecommand{\imprimirkeyworda}{\imprimirpalavrachavea}
\newcommand{\KeywordA}[1]{\renewcommand{\imprimirkeyworda}{#1}}

%% Keyword B
\providecommand{\imprimirkeywordb}{\imprimirpalavrachaveb}
\newcommand{\KeywordB}[1]{\renewcommand{\imprimirkeywordb}{#1}}

%% Keyword C
\providecommand{\imprimirkeywordc}{\imprimirpalavrachavec}
\newcommand{\KeywordC}[1]{\renewcommand{\imprimirkeywordc}{#1}}

%% Keyword D
\providecommand{\imprimirkeywordd}{\imprimirpalavrachaved}
\newcommand{\KeywordD}[1]{\renewcommand{\imprimirkeywordd}{#1}}

%% Keyword E
\providecommand{\imprimirkeyworde}{\imprimirpalavrachavee}
\newcommand{\KeywordE}[1]{\renewcommand{\imprimirkeyworde}{#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Informação do Autor(a) ou Autores(as) (TCC)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Nome completo do(a) autor(a)
\providecommand{\imprimirnomedoautor}{Nome do(a) Autor(a)}
\newcommand{\NomeDoAutor}[1]{\renewcommand{\imprimirnomedoautor}{#1}}

%% Sobrenome do(a) autor(a)
\providecommand{\imprimirsobrenomedoautor}{Último Nome}
\newcommand{\SobrenomeDoAutor}[1]{\renewcommand{\imprimirsobrenomedoautor}{#1}}

%% Prenome do(a) autor(a)
\providecommand{\imprimirprenomedoautor}{Nome do(a) Autor(a) Sem Último}
\newcommand{\PrenomeDoAutor}[1]{\renewcommand{\imprimirprenomedoautor}{#1}}

%% Insere ou remove autor(a) 2
\providecommand{\imprimiratribuiautordois}{false}
\newcommand{\AtribuiAutorDois}[1]{
  \ifthenelse{\equal{\imprimirtipodedocumento}{Oficina de integração 1 - Relatório Final}}%% Verificação do tipo de documento
    {\renewcommand{\imprimiratribuiautordois}{#1}}%% Insere ou remove autor(a) 2
    {\renewcommand{\imprimiratribuiautordois}{false}}%% Remove autor(a) 2
}

%% Nome completo do(a) autor(a) 2
\providecommand{\imprimirnomedoautordois}{Nome do(a) Autor(a) 2}
\newcommand{\NomeDoAutorDois}[1]{\renewcommand{\imprimirnomedoautordois}{#1}}

%% Sobrenome do(a) autor(a) 2
\providecommand{\imprimirsobrenomedoautordois}{Último Nome}
\newcommand{\SobrenomeDoAutorDois}[1]{\renewcommand{\imprimirsobrenomedoautordois}{#1}}

%% Prenome do(a) autor(a) 2
\providecommand{\imprimirprenomedoautordois}{Nome do(a) Autor(a) 2 Sem Último}
\newcommand{\PrenomeDoAutorDois}[1]{\renewcommand{\imprimirprenomedoautordois}{#1}}

%% Insere ou remove autor(a) 3
\providecommand{\imprimiratribuiautortres}{false}
\newcommand{\AtribuiAutorTres}[1]{
  \ifthenelse{\equal{\imprimirtipodedocumento}{Oficina de integração 1 - Relatório Final}}%% Verificação do tipo de documento
    {\renewcommand{\imprimiratribuiautortres}{#1}}%% Insere ou remove autor(a) 3
    {\renewcommand{\imprimiratribuiautortres}{false}}%% Remove autor(a) 3
}

%% Nome completo do(a) autor(a) 3
\providecommand{\imprimirnomedoautortres}{Nome do(a) Autor(a) 3}
\newcommand{\NomeDoAutorTres}[1]{\renewcommand{\imprimirnomedoautortres}{#1}}

%% Sobrenome do(a) autor(a) 3
\providecommand{\imprimirsobrenomedoautortres}{Último Nome}
\newcommand{\SobrenomeDoAutorTres}[1]{\renewcommand{\imprimirsobrenomedoautortres}{#1}}

%% Prenome do(a) autor(a) 3
\providecommand{\imprimirprenomedoautortres}{Nome do(a) Autor(a) 3 Sem Último}
\newcommand{\PrenomeDoAutorTres}[1]{\renewcommand{\imprimirprenomedoautortres}{#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Informações do Orientador(a) e Coorientador(a)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Atribuição "orientador(a)"
\providecommand{\imprimiratribuicaoorientador}{Orientador(a)}
\newcommand{\AtribuicaoOrientador}[1]{\renewcommand{\imprimiratribuicaoorientador}{#1}}

%% Título do(a) orientador(a)
\providecommand{\imprimirtitulodoorientador}{Prof(a). Dr(a).}
\newcommand{\TituloDoOrientador}[1]{\renewcommand{\imprimirtitulodoorientador}{#1}}

%% Nome completo do(a) orientador(a)
\providecommand{\imprimirnomedoorientador}{RONNIER FRATES ROHRICH e 
Juliano Mourão Vieira}
\newcommand{\NomeDoOrientador}[1]{\renewcommand{\imprimirnomedoorientador}{#1}}

%% Sobrenome do(a) orientador(a)
\providecommand{\imprimirsobrenomedoorientador}{Último Nome}
\newcommand{\SobrenomeDoOrienador}[1]{\renewcommand{\imprimirsobrenomedoorientador}{#1}}

%% Prenome do(a) orientador(a)
\providecommand{\imprimirprenomedoorientador}{Nome do(a) Orientador(a) Sem Último}
\newcommand{\PrenomeDoOrientador}[1]{\renewcommand{\imprimirprenomedoorientador}{#1}}

%% Insere ou remove o(a) coorientador(a)
\providecommand{\imprimiratribuicoorientador}{false}
\newcommand{\AtribuiCoorientador}[1]{\renewcommand{\imprimiratribuicoorientador}{#1}}

%% Atribuição "coorientador(a)"
\providecommand{\imprimiratribuicaocoorientador}{Coorientador(a)}
\newcommand{\AtribuicaoCoorientador}[1]{\renewcommand{\imprimiratribuicaocoorientador}{#1}}

%% Título do(a) coorientador(a)
\providecommand{\imprimirtitulodocoorientador}{Prof(a). Dr(a).}
\newcommand{\TituloDoCoorientador}[1]{\renewcommand{\imprimirtitulodocoorientador}{#1}}

%% Nome completo do(a) coorientador(a)
\providecommand{\imprimirnomedocoorientador}{Nome Completo do(a) Coorientador(a)}
\newcommand{\NomeDoCoorientador}[1]{\renewcommand{\imprimirnomedocoorientador}{#1}}

%% Sobrenome do(a) coorientador(a)
\providecommand{\imprimirsobrenomedocoorientador}{Último Nome}
\newcommand{\SobrenomeDoCoorienador}[1]{\renewcommand{\imprimirsobrenomedocoorientador}{#1}}

%% Prenome do(a) coorientador(a)
\providecommand{\imprimirprenomedocoorientador}{Nome do(a) Coorientador(a) Sem Último}
\newcommand{\PrenomeDoCoorientador}[1]{\renewcommand{\imprimirprenomedocoorientador}{#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Informações da Instituição
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Instituição (from abntex2)
\renewcommand{\imprimirinstituicao}{Universidade Tecnológica Federal do Paraná}
\let\Instituicao\instituicao

%% Institution name
\providecommand{\imprimirinstitution}{Universidade Tecnológica Federal do Paraná}
\newcommand{\Institution}[1]{\renewcommand{\imprimirinstitution}{#1}}

%% Sigla instituicao
\providecommand{\imprimirsiglainstituicao}{UTFPR}
\newcommand{\SiglaInstituicao}[1]{\renewcommand{\imprimirsiglainstituicao}{#1}}

%% Nome da cidade (câmpus)
\providecommand{\imprimircidade}{Curitiba}
\newcommand{\Cidade}[1]{\renewcommand{\imprimircidade}{#1}}

%% Diretoria
\providecommand{\imprimirdiretoria}{Diretoria de Pesquisa e Pós-Graduação}
\newcommand{\Diretoria}[1]{\renewcommand{\imprimirdiretoria}{Diretoria de #1}}

%% Nome do departamento
\providecommand{\imprimirdepartamento}{Nome do Departamento ou da Coordenação}
\newcommand{\Departamento}[1]{\renewcommand{\imprimirdepartamento}{#1}}

%% Sigla do departamento
\providecommand{\imprimirsigladepartamento}{DPT}
\newcommand{\SiglaDepartamento}[1]{\renewcommand{\imprimirsigladepartamento}{#1}}

%% Nome do curso
\providecommand{\imprimircurso}{Nome do Curso}
\newcommand{\Curso}[1]{\renewcommand{\imprimircurso}{#1}}

%% Course name
\providecommand{\imprimircourse}{Course Name}
\newcommand{\Course}[1]{\renewcommand{\imprimircourse}{#1}}

%% Nome do programa ou nome do curso completo
\providecommand{\imprimirprograma}{Programa de Pós-Graduação em \imprimircurso}
\newcommand{\Programa}[1]{\renewcommand{\imprimirprograma}{#1}}

%% Sigla do programa de pós-graduação
\providecommand{\imprimirsigladoppg}{PPG}
\newcommand{\SiglaDoPPG}[1]{\renewcommand{\imprimirsigladoppg}{#1}}

%% Programa de pós-graduação ou departamento
\newcommand{\imprimirppgoudepartamento}{
  \ifthenelse{\equal{\imprimirtipodedocumento}{Tese}\or\equal{\imprimirtipodedocumento}{Dissertação}}%% Tese ou dissertação
  {\imprimirprograma}%% Programa de pós-graduação
  {\imprimirdepartamento}%% Departamento (default)
}

%% Nome da área de concentração
\providecommand{\imprimirareadeconcentracao}{Nome da Área de Concentração}
\newcommand{\AreaDeConcentracao}[1]{\renewcommand{\imprimirareadeconcentracao}{#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Informações de Cotutela (Duplo Grau)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Insere dados de cotutela
\providecommand{\imprimiratribuicotutela}{false}
\newcommand{\AtribuiCotutela}[1]{\renewcommand{\imprimiratribuicotutela}{#1}}

%% Instituicao cotutela
\providecommand{\imprimirinstituicaocotutela}{Universidade Da Cotutela}
\newcommand{\InstituicaoCotutela}[1]{\renewcommand{\imprimirinstituicaocotutela}{#1}}

%% Institution cotutela
\providecommand{\imprimirinstitutioncotutela}{Double Degree University}
\newcommand{\InstitutionCotutela}[1]{\renewcommand{\imprimirinstitutioncotutela}{#1}}

%% Sigla instituicao cotutela
\providecommand{\imprimirsiglainstituicaocotutela}{UC}
\newcommand{\SiglaInstituicaoCotutela}[1]{\renewcommand{\imprimirsiglainstituicaocotutela}{#1}}

%% Nome do departamento da inst. cotutela
\providecommand{\imprimirdepartamentocotutela}{Nome do Departamento ou da Coordenação}
\newcommand{\DepartamentoCotutela}[1]{\renewcommand{\imprimirdepartamentocotutela}{#1}}

%% Sigla do departamento da inst. cotutela
\providecommand{\imprimirsigladepartamentocotutela}{DPT-EXT}
\newcommand{\SiglaDepartamentoCotutela}[1]{\renewcommand{\imprimirsigladepartamentocotutela}{#1}}

%% Nome do curso bachalerado ou pós-graduação (PPG)
\providecommand{\imprimircursocotutela}{Nome do Curso Cotutela}
\newcommand{\CursoCotutela}[1]{\renewcommand{\imprimircursocotutela}{#1}}

%% Cotutela Course name
\providecommand{\imprimircoursecotutela}{Second Degree Course}
\newcommand{\CourseCotutela}[1]{\renewcommand{\imprimircoursecotutela}{#1}}

%% Nome do programa ou nome do curso completo na inst. cotutela
\providecommand{\imprimirprogramacotutela}{Programa de Doutoral em \imprimircursocotutela}
\newcommand{\ProgramaCotutela}[1]{\renewcommand{\imprimirprogramacotutela}{#1}}

%% Sigla do programa de pós-graduação da inst. de cotutela
\providecommand{\imprimirsigladoppgcotutela}{PPG-EXT}
\newcommand{\SiglaDoPPGCotutela}[1]{\renewcommand{\imprimirsigladoppgcotutela}{#1}}

%% Area de concentração na inst. de cotutela
\providecommand{\imprimirareadeconcentracaocotutela}{Nome da Área de Concentração}
\newcommand{\AreaDeConcentracaoCotutela}[1]{\renewcommand{\imprimirareadeconcentracaocotutela}{#1}}

%% Nível de formação no resumo
\providecommand{\imprimirniveldeformacaoresumo}{Duplo doutorado}
\newcommand{\NivelDeFormacaoResumo}[1]{\renewcommand{\imprimirniveldeformacaoresumo}{#1}}

%% Formation level no abstract
\providecommand{\imprimirformationlevelabstract}{Double PhD}
\newcommand{\FormationLevelAbstract}[1]{\renewcommand{\imprimirformationlevelabstract}{#1}}

%% Informacoes do orientador(a) da inst. cotutela

%% Atribuição "orientador(a)" de cotutela
\providecommand{\imprimiratribuicaoorientadorcotutela}{Orientador(a)}
\newcommand{\AtribuicaoOrientadorCotutela}[1]{\renewcommand{\imprimiratribuicaoorientadorcotutela}{#1}}

%% Título do(a) orientador(a) de cotutela
\providecommand{\imprimirtitulodoorientadorcotutela}{Prof(a). Dr(a).}
\newcommand{\TituloDoOrientadorCotutela}[1]{\renewcommand{\imprimirtitulodoorientadorcotutela}{#1}}

%% Nome completo do(a) orientador(a) de cotutela
\providecommand{\imprimirnomedoorientadorcotutela}{Nome Completo do(a) Orientador(a)}
\newcommand{\NomeDoOrientadorCotutela}[1]{\renewcommand{\imprimirnomedoorientadorcotutela}{#1}}

%% Sobrenome do(a) orientador(a) de cotutela
\providecommand{\imprimirsobrenomedoorientadorcotutela}{Último Nome}
\newcommand{\SobrenomeDoOrienadorCotutela}[1]{\renewcommand{\imprimirsobrenomedoorientadorcotutela}{#1}}

%% Prenome do(a) orientador(a) de cotutela
\providecommand{\imprimirprenomedoorientadorcotutela}{Nome do(a) Orientador(a) Sem Último}
\newcommand{\PrenomeDoOrientadorCotutela}[1]{\renewcommand{\imprimirprenomedoorientadorcotutela}{#1}}

%% Insere ou remove o(a) coorientador(a) de cotutela
\providecommand{\imprimiratribuicoorientadorcotutela}{false}
\newcommand{\AtribuiCoorientadorCotutela}[1]{\renewcommand{\imprimiratribuicoorientadorcotutela}{#1}}

%% Atribuição "coorientador(a)" de cotutela
\providecommand{\imprimiratribuicaocoorientadorcotutela}{Coorientador(a)}
\newcommand{\AtribuicaoCoorientadorCotutela}[1]{\renewcommand{\imprimiratribuicaocoorientadorcotutela}{#1}}

%% Título do(a) coorientador(a)
\providecommand{\imprimirtitulodocoorientadorcotutela}{Prof(a). Dr(a).}
\newcommand{\TituloDoCoorientadorCotutela}[1]{\renewcommand{\imprimirtitulodocoorientadorcotutela}{#1}}

%% Nome completo do(a) coorientador(a)
\providecommand{\imprimirnomedocoorientadorcotutela}{Nome Completo do(a) Coorientador(a)}
\newcommand{\NomeDoCoorientadorCotutela}[1]{\renewcommand{\imprimirnomedocoorientadorcotutela}{#1}}

%% Sobrenome do(a) coorientador(a)
\providecommand{\imprimirsobrenomedocoorientadorcotutela}{Último Nome}
\newcommand{\SobrenomeDoCoorienadorCotutela}[1]{\renewcommand{\imprimirsobrenomedocoorientadorcotutela}{#1}}

%% Prenome do(a) coorientador(a)
\providecommand{\imprimirprenomedocoorientadorcotutela}{Nome do(a) Coorientador(a) Sem Último}
\newcommand{\PrenomeDoCoorientadorCotutela}[1]{\renewcommand{\imprimirprenomedocoorientadorcotutela}{#1}}

%% Programa de pós-graduação ou departamento da inst. cotutela
\newcommand{\imprimirppgoudepartamentocotutela}{
  \ifthenelse{\equal{\imprimirtipodedocumento}{Tese}\or\equal{\imprimirtipodedocumento}{Dissertação}}%% Tese ou dissertação
  {\imprimirprogramacotutela}%% Programa de pós-graduação
  {\imprimirdepartamentocotutela}%% Departamento
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Folha de Rosto
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Descrição do documento
\providecommand{\imprimirdescricaododocumento}{\imprimirtipodedocumento\ apresentado(a) como requisito parcial à obtenção do título de \imprimirtitulopretendido\ em \imprimircurso, do \imprimirppgoudepartamento, da \imprimirinstituicao.
}
\newcommand{\DescricaoDoDocumento}[1]{\renewcommand{\imprimirdescricaododocumento}{#1}}

%% Insere descrição de cotutela na folha de rosto
\providecommand{\imprimiratribuidescricaocotutela}{false}
\newcommand{\AtribuiDescricaoCotutela}[1]{\renewcommand{\imprimiratribuidescricaocotutela}{#1}}

%% Descrição do documento (cotutela)
\providecommand{\imprimirdescricaododocumentocotutela}{\imprimirtipodedocumento\ apresentado(a) como requisito parcial à obtenção do título de \imprimirtitulopretendido\ em \imprimircursocotutela, do \imprimirppgoudepartamentocotutela, da \imprimirinstituicaocotutela.}
\newcommand{\DescricaoDoDocumentoCotutela}[1]{\renewcommand{\imprimirdescricaododocumentocotutela}{#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Configuração de fontes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ifthenelse{\equal{\@tipodefonte}{lmodern}}{
	\renewcommand{\familydefault}{\rmdefault}
}{
	\RequirePackage{times}%% Seleção da fonte Adobe Times Roman (ou equivalente) como fonte padrão
	\renewcommand{\rmdefault}{ptm}%% Fonte Adobe Times
	\renewcommand{\sfdefault}{phv}%% Fonte Adobe Helvetica
	\renewcommand{\ttdefault}{pcr}%% Fonte Adobe Courier
	\ifthenelse{\equal{\@tipodefonte}{arial}}{
		%% Fonte arial com fator de escala de 1.0 (fonte principal arial)
  		\RequirePackage{helvet}%% Fonte Arial (ou equivalente) como fonte padrão
  		%\RequirePackage{sfmath}%% Fonte Helvetica no modo matemático
		\renewcommand{\familydefault}{\sfdefault}
	}{
		\RequirePackage[scaled=0.9]{helvet}%% Fonte arial com fator de escala de 0.9 quando não é fonte principal

		\ifthenelse{\equal{\@tipodefonte}{courier}}{
			\renewcommand{\familydefault}{\ttdefault}
		}{
			\renewcommand{\familydefault}{\rmdefault}
		}
	}
}
\normalsize%% Tamanho padrão de fonte
\renewcommand{\ABNTEXpartfont}{\fontfamily{\familydefault}\bfseries}%% Estilo da fonte da parte
\renewcommand{\ABNTEXpartfontsize}{\normalsize}%% Tamanho da fonte da parte
\renewcommand{\ABNTEXchapterfont}{\ABNTEXpartfont}%% Estilo da fonte do capítulo
\renewcommand{\ABNTEXchapterfontsize}{\ABNTEXpartfontsize}%% Tamanho da fonte do capítulo
\renewcommand{\ABNTEXsectionfont}{\normalfont}%% Estilo da fonte da seção
\renewcommand{\ABNTEXsectionfontsize}{\normalsize}%% Tamanho da fonte da seção
\renewcommand{\ABNTEXsubsectionfont}{\ABNTEXsectionfont}%% Estilo da fonte da subseção
\renewcommand{\ABNTEXsubsectionfontsize}{\ABNTEXsectionfontsize}%% Tamanho da fonte da subseção
\renewcommand{\ABNTEXsubsubsectionfont}{\ABNTEXsubsectionfont}%% Estilo da fonte da subsubseção
\renewcommand{\ABNTEXsubsubsectionfontsize}{\ABNTEXsubsectionfontsize}%% Tamanho da fonte da subsubseção


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Formatação das páginas no documento
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\let\newtextual\textual%% Elementos textuais
\let\newpretextual\pretextual%% Elementos pré-textuais
\if@twoside%% Estilo de impressão para elementos textuais e pós-textuais (anverso e verso)
  \renewcommand{\textual}{\setboolean{@twoside}{true}\newtextual}%% Redefinição dos elementos textuais
\else%% Estilo de impressão para elementos textuais e pós-textuais (anverso)
  \renewcommand{\textual}{\setboolean{@twoside}{false}\newtextual}%% Redefinição dos elementos textuais
\fi
\if@pretexttwoside%% Estilo de impressão para elementos pré-textuais (anverso e verso)
  \renewcommand{\pretextual}{\setboolean{@twoside}{true}\newpretextual}%% Redefinição dos elementos pré-textuais
\else%% Estilo de impressão para elementos pré-textuais (anverso)
  \renewcommand{\pretextual}{\setboolean{@twoside}{false}\newpretextual}%% Redefinição dos elementos pré-textuais
\fi

%% Formatação e espaçamentos nas páginas
\newgeometry{%
  top      = 30mm,%
  left     = 30mm,%
  right    = 20mm,%
  bottom   = 20mm,%
  head     = 10mm,%
  headsep  = 5.5mm,% NBR 14724/2011: 2 cm da borda superior (ajustado manualmente para ficar proximo do esperado)
  footskip = 5mm,%
  includehead = false,
}%
\savegeometry{standard}

\frenchspacing%% Remoção de espaço adicional após ponto final
\raggedbottom%% Remoção de espaços adicionais no texto
\sloppy%% Força todas as linhas ficarem dentro das margens
\newlength{\linha}%% Escala linha
\setlength{\linha}{\baselineskip}%% Espessura da escala linha
\setlength{\parskip}{0pt}%% Espaçamento entre parágrafos
\setlength{\parindent}{15mm}%% Recuo dos parágrafos
% \setlength{\hoffset}{-1in}%% Deslocamento horizontal
% \setlength{\voffset}{-1in}%% Deslocamento vertical
% \setlength{\headheight}{\linha}%% Espessura do cabeçalho
% \setlength{\headsep}{10mm}%% Espaçamento entre texto e cabeçalho
% \setlength{\footskip}{5mm}%% Espaçamento entre texto e rodapé
% \setlength{\topmargin}{30mm-\headsep-\headheight}%% Margem superior
% \setlength{\oddsidemargin}{30mm}%% Margem lateral da página impar
% \setlength{\evensidemargin}{20mm}%% Margem lateral da página par
% \setlength{\marginparsep}{0pt}%% Espaçamento horizontal entre a margem e a nota de margem
% \setlength{\marginparpush}{0pt}%% Espaçamento vertical mínimo entre duas notas de margem
% \setlength{\marginparwidth}{0pt}%% Largura da nota de margem
\if@fleqn\setlength{\mathindent}{\parindent}\fi%% Recuo dos parágrafos de equações alinhadas à esquerda (em ambiente matemático)
\renewcommand{\baselinestretch}{1.5}%% Espaçamento entre linhas (1, 1,5 ou 2)

%% Formatação dos cabeçalhos
\makepagestyle{abntheadings}%% Cabeçalho
\makeevenhead{abntheadings}{\ABNTEXfontereduzida\thepage}{}{}%% Formatação do cabeçalho (par)
\makeoddhead{abntheadings}{}{}{\ABNTEXfontereduzida\thepage}%% Formatação do cabeçalho (ímpar)
\makeheadrule{abntheadings}{0pt}{\normalrulethickness}%% Formatação da regua do cabeçalho
\makepagestyle{abntchapfirst}%% Cabeçalho do início do capítulo
\makeoddhead{abntchapfirst}{}{}{\ABNTEXfontereduzida\thepage}%% Formatação do cabeçalho do início do capítulo (ímpar)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Capa
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\incluircapa}{%% Formatação da capa
  \begin{capa}%% Ambiente capa
    \pdfbookmark[0]{\nomecapa}{capa}%% Marcador
    \renewcommand{\thepage}{\roman{page}}%% Numéração de página em algarismos romanos
    %\vspace*{-2\linha}
	%\hspace*{-0.162\textwidth}
	%\includegraphics[width = 40mm]{./Capitulos/figures/logos/logo_utfpr.png}%
	%\hfill
	%\includegraphics[width = 40mm]{./Capitulos/figures/logos/logo_inst_cotutela.png}
	%\vspace*{1\linha}
    \begin{center}%% Texto centralizado
      \bfseries%% Texto em negrito
      \MakeUppercase{\imprimirinstituicao}\\%% Instituição
      \ifthenelse{%% Verificação do tipo de documento
        \equal{\imprimirtipodedocumento}{Tese}
        \or\equal{\imprimirtipodedocumento}{Dissertação}
      }{%% Programa de pós-graduação
        \MakeUppercase{\imprimirprograma}
      }{%% Departamento
        \MakeUppercase{\imprimirdepartamento}
      }\\[0.5\linha]%
	  %\MakeUppercase{\imprimirniveldeformacao\ em \imprimircurso}\\[80pt]%% Titulação e curso
	  \ifthenelse{\equal{\imprimiratribuicotutela}{true}}{%%
		\MakeUppercase{\imprimirinstituicaocotutela}\par%%
	    \MakeUppercase{\imprimirprogramacotutela}\\[80pt]%%
	  }{\vspace*{100pt}}%%
      \ifthenelse{\equal{\imprimiratribuiautortres}{true}}{%% Insere 3 autores(as)
	    \MakeUppercase{\imprimirnomedoautor}\par%% Autor(a)
      	\MakeUppercase{\imprimirnomedoautordois}\par%% Autor(a) 2
      	\MakeUppercase{\imprimirnomedoautortres}\\[96pt]%% Autor(a) 3
      }{%
      	\ifthenelse{\equal{\imprimiratribuiautordois}{true}}{%% Insere 2 autores(as)
          \MakeUppercase{\imprimirnomedoautor}\par%% Autor(a)
	      \MakeUppercase{\imprimirnomedoautordois}\\[118pt]%% Autor(a) 2
      	}{%% Insere 1 autor(a)
          \MakeUppercase{\imprimirnomedoautor}\\[140pt]%% Autor(a)
        }
      }%%
      \ifthenelse{\equal{\lingua}{english}}{%
	   	  {\large\MakeUppercase{\imprimirtituloemmultiplaslinhasingles}}\\[120pt]}
   	  {%
      	{\large\MakeUppercase{\imprimirtituloemmultiplaslinhas}}\\[120pt]
      }

      \MakeUppercase{\imprimirtipodedocumento}\\%% Tipo de documento
      \vspace*{\stretch{1}}%% Espaçamento vertical
      \MakeUppercase{\imprimircidade}\par%% Cidade
      \MakeUppercase{\imprimirano}%% Ano
    \end{center}
  \end{capa}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Folha de rosto
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\renewcommand{\folhaderostocontent}{%% Formatação da folha de rosto

  \ifthenelse{\equal{\licenciamento}{Nenhuma}}{}{
	\newgeometry{bottom=30mm}
  }
  \begin{center}%% Texto centralizado
    \bfseries%% Texto em negrito
    \ifthenelse{\equal{\imprimiratribuiautortres}{true}}{%% Insere 3 autores(as)
      \MakeUppercase{\imprimirnomedoautor}\par%% Autor(a)
      \MakeUppercase{\imprimirnomedoautordois}\par%% Autor(a) 2
      \MakeUppercase{\imprimirnomedoautortres}\\[224pt]%% Autor(a) 3
    }{%
      \ifthenelse{\equal{\imprimiratribuiautordois}{true}}{%% Insere 2 autores(as)
        \MakeUppercase{\imprimirnomedoautor}\par%% Autor(a)
        \MakeUppercase{\imprimirnomedoautordois}\\[246pt]%% Autor(a) 2
      }{%% Insere 1 autor(a)
        \MakeUppercase{\imprimirnomedoautor}\\[268pt]%% Autor(a)
      }
    }
    \ifthenelse{\equal{\imprimiratribuicotutela}{true}}{%%
    	\ifthenelse{\equal{\imprimiratribuidescricaocotutela}{true}}{%%
			{\vspace{-70pt}}
    	}{}
    }{}
    \ifthenelse{\equal{\lingua}{english}} {
    	\vspace{-45pt}
		{\large\MakeUppercase{\imprimirtituloemmultiplaslinhasingles}}\\[10pt]%% Título do documento (em ingles)
		{\large{\imprimirtituloemmultiplaslinhas}}\\[35pt]
    }{
    	\vspace{-45pt}
		{\large\MakeUppercase{\imprimirtituloemmultiplaslinhas}}\\[10pt]%% Título do documento
		{\large{\imprimirtituloemmultiplaslinhasingles}}\\[35pt]
    }

  \end{center}
  \begin{flushright}%% Alinhamento à direita
    \begin{Spacing}{1.0}%% Espaçamento simples entre linhas
      \parbox{0.5\textwidth}{%% Caixa de texto
	  \imprimirdescricaododocumento\\[\linha]
      %\imprimiratribuicaoorientador: \imprimirtitulodoorientador\ \imprimirnomedoorientador\\%% Orientador
	  \ifthenelse{\equal{\imprimiratribuicotutela}{true}}{%%
      \ifthenelse{\equal{\imprimiratribuidescricaocotutela}{true}}%%
      {%1)coorientador + outra descrição + orientador(ext) + coorientador(ext)
		\ifthenelse{\equal{\imprimiratribuicoorientador}{true}}%% Existe coorientador
        {\imprimiratribuicaocoorientador: \imprimirtitulodocoorientador\ \imprimirnomedocoorientador\\[\linha]}{\\[\linha]}%% Coorientador
		\imprimirdescricaododocumentocotutela\\[\linha]
        \imprimiratribuicaoorientadorcotutela: \imprimirtitulodoorientadorcotutela\ \imprimirnomedoorientadorcotutela\par%% Orientador Cotutela
   		\ifthenelse{\equal{\imprimiratribuicoorientadorcotutela}{true}}%% Existe coorientador cotutela
        {\imprimiratribuicaocoorientadorcotutela: \imprimirtitulodocoorientadorcotutela\ \imprimirnomedocoorientadorcotutela\par}{\par}%% Coorientador Cotutela
	  }%%
	  {%2)orientador(ext) + coorientador + coorientador(ext)
	  	\imprimiratribuicaoorientadorcotutela: \imprimirtitulodoorientadorcotutela\ \imprimirnomedoorientadorcotutela\par%% Orientador Cotutela
		\ifthenelse{\equal{\imprimiratribuicoorientador}{true}}%% Existe coorientador
        {\imprimiratribuicaocoorientador: \imprimirtitulodocoorientador\ \imprimirnomedocoorientador\par}{\par}%% Coorientador
   		\ifthenelse{\equal{\imprimiratribuicoorientadorcotutela}{true}}%% Existe coorientador cotutela
        {\imprimiratribuicaocoorientadorcotutela: \imprimirtitulodocoorientadorcotutela\ \imprimirnomedocoorientadorcotutela\par}{\par}%%
	  }}%%
	  {%3)apenas coorientador
		%\ifthenelse{\equal{\imprimiratribuicoorientador}{true}}%% Existe coorientador
        %{\imprimiratribuicaocoorientador: \imprimirtitulodocoorientador\ \imprimirnomedocoorientador\par}{\par}%% Coorientador
	  }
      }%end parbox
    \end{Spacing}
  \end{flushright}
  \vspace*{\stretch{1}}%% Espaçamento vertical
  \begin{center}%% Texto centralizado
    \bfseries%% Texto em negrito
    \MakeUppercase{\imprimircidade}\par%% Cidade
    \MakeUppercase{\imprimirano}%% Ano
  \end{center}

}
\newcommand{\incluirfolhaderosto}[1][\folhaderostoname]{%% Inclusão da folha de rosto (com ou sem ficha catalográfica)
\@ifstar\imprimirfolhaderostostar\imprimirfolhaderostonostar%% Verificação do asterisco (*)
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Resumo
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\AtBeginDocument{%% Definições carregadas no início do documento
  \renewcommand{\abstracttextfont}{\normalfont\normalsize}%% Fonte do texto do resumo
  \setlength{\absleftindent}{0pt}%% Recuo esquerdo do resumo
  \setlength{\absrightindent}{0pt}%% Recuo direito do resumo
  \setlength{\absparindent}{0pt}%% Recuo dos parágrafos do resumo
  \setlength{\absparsep}{\linha}%% Espaçamento entre parágrafos
  \setlength{\abstitleskip}{1.25\linha}%% Espaçamento após o título do resumo
}
\newenvironment{resumoutfpr}{%% Formatação do ambiente resumoutfpr
  \begin{resumo}[\nomeresumo]%% Ambiente resumo
    \begin{Spacing}{1.0}%% Espaçamento simples entre linhas
      \begin{flushleft}%% Alinhamento à esquerda
        %\MakeUppercase{\imprimirsobrenomedoautor}, \imprimirprenomedoautor
		%\ifthenelse{\equal{\imprimiratribuiautordois}{true}}%% 2 autores?
        %{; \MakeUppercase{\imprimirsobrenomedoautordois}, \imprimirprenomedoautordois%
        %\ifthenelse{\equal{\imprimiratribuiautortres}{true}}%% 3 autores?
        %{; \MakeUppercase{\imprimirsobrenomedoautortres}, \imprimirprenomedoautortres.}
        %{.}}{.}
        \ifthenelse{\equal{\imprimiratribuicotutela}{false}}{%%
        %{\bfseries\imprimirtitulododocumento\unskip}. {\imprimirano}. \pageref{LastPage}~f. \imprimirtipodedocumento\ (\imprimirniveldeformacao\ em \imprimircurso) -- \imprimirinstituicao. \imprimircidade, \imprimirano.%%
        }{%% Cotutela
		{\bfseries\imprimirtitulododocumento\unskip}. {\imprimirano}. \pageref{LastPage}~f. \imprimirtipodedocumento\ (\imprimirniveldeformacaoresumo\ em \imprimircurso\ e \imprimircursocotutela) -- \imprimirinstituicao\ e \imprimirinstituicaocotutela. \imprimircidade, \imprimirano.%%
        }
      \end{flushleft}
}{%%
      \par\textbf{\nomepalavraschave:}
      \ifthenelse{\imprimirnumerodepalavraschave > 0}{\imprimirpalavrachavea}{}%%
      \ifthenelse{\imprimirnumerodepalavraschave > 1}{. \imprimirpalavrachaveb}{}%%
      \ifthenelse{\imprimirnumerodepalavraschave > 2}{. \imprimirpalavrachavec}{}%%
      \ifthenelse{\imprimirnumerodepalavraschave > 3}{. \imprimirpalavrachaved}{}%%
      %\ifthenelse{\imprimirnumerodepalavraschave > 4}{. \imprimirpalavrachavee}{}%%
      \ifthenelse{\imprimirnumerodepalavraschave > 0}{.}{}%%
    \end{Spacing}
  \end{resumo}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sumário
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\settocpreprocessor{part}{%% Título da parte no sumário em letras maíusculas
  \let\tempf@rtoc\f@rtoc\def\f@rtoc{\texorpdfstring{\MakeTextUppercase{\tempf@rtoc}}{\tempf@rtoc}}%%
}
\settocpreprocessor{chapter}{%% Título do capítulo no sumário em letras maíusculas
  \let\tempf@rtoc\f@rtoc\def\f@rtoc{\texorpdfstring{\MakeTextUppercase{\tempf@rtoc}}{\tempf@rtoc}}%%
}
\let\oldcontentsline\contentsline%% Título da seção no sumário em letras maíusculas
\def\contentsline#1#2{%%
  \expandafter\ifx\csname l@#1\endcsname\l@section\expandafter\@firstoftwo\else\expandafter\@secondoftwo\fi%%
  {\oldcontentsline{#1}{\MakeTextUppercase{#2}}}{\oldcontentsline{#1}{#2}}%%
}
\renewcommand{\cftpartfont}{\normalfont\normalsize\bfseries}%% Estilo da parte no sumário
\renewcommand{\cftchapterfont}{\normalfont\normalsize\bfseries}%% Estilo do capítulo no sumário
\renewcommand{\cftsectionfont}{\normalfont\normalsize\scshape}%% Estilo da seção no sumário
\renewcommand{\cftsubsectionfont}{\normalfont\normalsize}%% Estilo da subseção no sumário
\renewcommand{\cftsubsubsectionfont}{\normalfont\normalsize}%% Estilo da subsubseção no sumário
\renewcommand{\cftparagraphfont}{\normalfont\normalsize\itshape}%% Estilo do parágrafo no sumário
\renewcommand{\cftsubparagraphfont}{\normalfont\normalsize}%% Estilo do subparágrafo no sumário
\renewcommand{\cftpartpagefont}{\normalfont\normalsize\bfseries}%% Estilo da página da parte no sumário
\renewcommand{\cftchapterpagefont}{\normalfont\normalsize\bfseries}%% Estilo da página do capítulo no sumário
\renewcommand{\cftsectionpagefont}{\normalfont\normalsize}%% Estilo da página da seção no sumário
\renewcommand{\cftsubsectionpagefont}{\normalfont\normalsize}%% Estilo da página da subseção no sumário
\renewcommand{\cftsubsubsectionpagefont}{\normalfont\normalsize}%% Estilo da página da subsubseção no sumário
\renewcommand{\cftparagraphpagefont}{\normalfont\normalsize}%% Estilo da página do parágrafo no sumário
\renewcommand{\cftsubparagraphpagefont}{\normalfont\normalsize}%% Estilo da página do subparágrafo no sumário
\if@semrecuonosumario%% Remoção do recuo dos itens no sumário
  \setlength{\cftpartindent}{0pt}%% Recuo do título da parte
  \setlength{\cftchapterindent}{0pt}%% Recuo do título do capítulo
  \setlength{\cftsectionindent}{0pt}%% Recuo do título da seção
  \setlength{\cftsubsectionindent}{0pt}%% Recuo do título da subseção
  \setlength{\cftsubsubsectionindent}{0pt}%% Recuo do título da subsubseção
  \setlength{\cftparagraphindent}{0pt}%% Recuo do título do parágrafo
  \setlength{\cftsubparagraphindent}{0pt}%% Recuo do título do subparágrafo
\fi
\setlength{\cftbeforepartskip}{2em\@plus\p@}%% Remoção de espaço adicional antes de uma parte nas listas
\setlength{\cftbeforechapterskip}{1em\@plus\p@}%% Remoção de espaço adicional antes de um capítulo nas listas
\renewcommand*{\insertchapterspace}{}%% Remoção do espaço vertical de um capítulo nas listas
\renewcommand{\aftertoctitle}{\afterchaptertitle\vspace*{-0.25\linha}}%% Espaçamento após o título do sumário
\newcommand{\incluirsumario}{%% Definição do comando para inclusão do sumário
  \pdfbookmark[0]{\contentsname}{toc}%% Marcador
  \begin{Spacing}{1.0}%% Espaçamento simples entre linhas
    \tableofcontents*%% Impressão do sumário
  \end{Spacing}
  \cleardoublepage%% Página de verso
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Referências
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%\let\arquivosdereferencias\bibliography%% Arquivos da lista de referências
%\renewcommand{\prebibhook}{\vspace*{0.5\linha}}%% Conteúdo após o título da lista de referências
%\renewcommand{\bibsection}{%% Formatação da lista de referências
  %\chapter*{\bibname}
  %\bibmark
  %\ifnobibintoc\else
    %\phantomsection
    %\addcontentsline{toc}{chapter}{\texorpdfstring{\uppercase{\bibname}}{\bibname}}%% Adição da lista de referências ao sumário
%  \fi
%  \prebibhook
}
%NBR6023/2018: única linha entre referências (antes era 1.5)
%\setlength{\bibitemsep}{1\linha}%% Espaçamento entre itens da lista de referências

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Índice
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\incluirindice}{%% Definição do comando para inclusão do índice
  \renewenvironment{theindex}{%% Formatação do índice
    \clearforchapter
    \if@twocolumn\@restonecolfalse\else\@restonecoltrue\fi
    \ifonecolindex
      \onecolumn
      \chapter*{\indexname}
      \preindexhook
    \else
      \setlength{\columnseprule}{\indexrule}
      \setlength{\columnsep}{\indexcolsep}
      \twocolumn[\@makeschapterhead{\indexname}\preindexhook]
    \fi
    \indexmark
    \ifnoindexintoc\else
      \phantomsection
      \addcontentsline{toc}{chapter}{\texorpdfstring{\uppercase{\indexname}}{\indexname}}%% Adição do índice ao sumário
    \fi
    \thispagestyle{indextitlepagestyle}\parindent\z@
    \parskip\z@ \@plus 0.3\p@\relax
    \let\item\@idxitem
  }{%%
    \if@restonecol\onecolumn\else\twocolumn\fi
  }
  \bookmarksetup{startatroot}%% Capítulos após este comando criam marcadores do pdf na raiz
  \printindex%% Impressão do índice
  \cleardoublepage%% Página de verso
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Partes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\renewcommand{\partnamefont}{\normalfont\normalsize\bfseries\MakeUppercase}%% Fonte do nome da parte
\renewcommand{\partnumfont}{\normalfont\normalsize\bfseries\MakeUppercase}%% Fonte da página da parte
\renewcommand{\parttitlefont}{\normalfont\normalsize\bfseries\MakeUppercase}%% Fonte do título da parte

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Parágrafos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\setparaheadstyle{\normalfont\normalsize\itshape}%% Estilo do título do parágrafo
\setafterparaskip{\aftersubsubsecskip}%% Espaçamento após título do parágrafo

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Espaçamentos em capítulos, seções, subseções,
%% subsubseções, parágrafos e subparágrafos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\setlength{\beforechapskip}{0pt}%% Espaçamento antes do título do capítulo
\setlength{\afterchapskip}{2\linha}%% Espaçamento após o título do capítulo
\setlength{\beforesecskip}{\linha}%% Espaçamento antes do título da seção
\setlength{\aftersecskip}{\linha}%% Espaçamento após o título da seção
\setlength{\beforesubsecskip}{\linha}%% Espaçamento antes do título da subsubseção
\setlength{\aftersubsecskip}{\linha}%% Espaçamento após o título da subsubseção
\setlength{\beforesubsubsecskip}{\linha}%% Espaçamento antes do título da subsubseção
\setlength{\aftersubsubsecskip}{\linha}%% Espaçamento após o título da subsubseção
\setlength{\beforeparaskip}{\linha}%% Espaçamento antes do título do parágrafo
\setlength{\afterparaskip}{\linha}%% Espaçamento após o título do parágrafo
\setlength{\beforesubparaskip}{\linha}%% Espaçamento antes do título do subparágrafo
\setlength{\aftersubparaskip}{\linha}%% Espaçamento após o título do subparágrafo

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Níveis de seções no documento e no sumário
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\setsecnumdepth{all}%% Utilizado no documento
\maxsecnumdepth{all}%% Máximo no documento
\maxtocdepth{all}%% Utilizado no sumário
\settocdepth{all}%% Máximo no sumário

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Estilo tabelas
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\setlength{\aboverulesep}{0pt}
\setlength{\belowrulesep}{0pt}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Estilo de numeração de algoritmos, figuras, tabelas
%% e equações
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\counterwithout{algorithm}{chapter}%% Numeração contínua ao longo dos capítulos para algoritmos
\counterwithout{figure}{chapter}%% Numeração contínua ao longo dos capítulos para figuras
\counterwithout{table}{chapter}%% Numeração contínua ao longo dos capítulos para tabelas
\counterwithout{equation}{chapter}%% Numeração contínua ao longo dos capítulos para equações

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Legendas de objetos flutuantes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\setlength{\abovecaptionskip}{1pt}%% Espaçamento acima da legenda
\setlength{\belowcaptionskip}{1pt}%% Espaçamento abaixo da legenda

\hangcaption%% Recuo do texto das legendas
\if@legendascentralizadas%% Alinhamento das legendas centralizado
  \gdef\@captionjustification{on}%% Ativa alinhamento justificado
  \captionstyle{}%% Estilo das legendas
\else%% Alinhamento das legendas à esquerda
  \gdef\@captionjustification{off}%% Desativa alinhamento justificado
  \captionstyle[\raggedright]{\raggedright}%% Estilo das legendas
\fi
\captiondelim{\space--\space}%% Delimitador das legendas
\captionnamefont{\ABNTEXfontereduzida\bfseries}%% Fonte do nome das legendas
\captiontitlefont{\ABNTEXfontereduzida\bfseries}%% Fonte do título das legendas
\captionsetup{%% Formatação das legendas
  format=hang,%%
  singlelinecheck=\@captionjustification,%%
  font={footnotesize,bf,singlespacing},%%
  labelfont={footnotesize,bf,singlespacing},%%
  textfont={footnotesize,bf,singlespacing},%%
  labelsep={endash},%%
  skip=2.5pt%% Space below caption
}

%Altera formato do label e autoref do pacote subcaption
\RequirePackage[labelformat=simple]{subcaption} %Subfigure caption
\renewcommand\thesubfigure{(\alph{subfigure})}
\renewcommand{\subfigureautorefname}{\figureautorefname}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fonte (referência) para objetos flutuantes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% \ifx\fonte\undefined%% Verificação da definição do comando fonte
  \renewcommand{\fonte}[1]{\legend{\ABNTEXfontereduzida{\bfseries\nomefonte: #1}}}%% Definição do comando fonte
% \fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Compilação de índices utilizando makeindex (se habilitada)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\if@usemakeindex
  \immediate\write18{makeindex \jobname.idx}\relax%% Compilação do índice
  \immediate\write18{makeindex -s \jobname.ist -t \jobname.glg -o \jobname.gls \jobname.glo}\relax%% Compilação do glossário
  \immediate\write18{makeindex -s \jobname.ist -t \jobname.alg -o \jobname.acr \jobname.acn}\relax%% Compilação dos acrônimos
  \immediate\write18{makeindex -s \jobname.ist -t \jobname.alg2 -o \jobname.acr2 \jobname.acn2}\relax%% Compilação das siglas
  \immediate\write18{makeindex -s \jobname.ist -t \jobname.alg3 -o \jobname.acr3 \jobname.acn3}\relax%% Compilação das abreviaturas
  \immediate\write18{makeindex \jobname.nlo -s nomencl.ist -o \jobname.nls}\relax%% Compilação dos símbolos
\fi